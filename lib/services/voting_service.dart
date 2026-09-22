import 'dart:convert';
import 'package:grademehard_app/domain/vote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VotingService {
  static final VotingService _instance = VotingService._internal();
  factory VotingService() => _instance;
  VotingService._internal();

  final List<Vote> _votes = [];
  bool _loaded = false;

  Future<void> init() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final votesJson = prefs.getStringList('votes') ?? [];
    _votes.clear();
    for (final v in votesJson) {
      try {
        final decoded = jsonDecode(v) as Map<String, dynamic>;
        _votes.add(Vote.fromJson(decoded));
      } catch (_) {}
    }
    _loaded = true;
  }

  Future<void> addVote(Vote vote) async {
    _votes.add(vote);
    await _save();
  }

  List<Vote> getVotesForStudent(String studentName) {
    return _votes.where((vote) => vote.studentName == studentName).toList();
  }

  List<Vote> getAllVotes() {
    return List.from(_votes);
  }

  Map<String, int> getAverageAttributes(String studentName) {
    final votes = getVotesForStudent(studentName);
    if (votes.isEmpty) return {};

    final Map<String, List<int>> attributeScores = {};

    for (final vote in votes) {
      for (final entry in vote.attributePoints.entries) {
        attributeScores.putIfAbsent(entry.key, () => []);
        attributeScores[entry.key]!.add(entry.value);
      }
    }

    final Map<String, int> averages = {};
    for (final entry in attributeScores.entries) {
      final sum = entry.value.fold(0, (s, v) => s + v);
      averages[entry.key] = (sum / entry.value.length).round();
    }

    return averages;
  }

  int getStudentTotalScore(String studentName) {
    final averages = getAverageAttributes(studentName);
    if (averages.isEmpty) return 0;
    return averages.values.fold(0, (s, v) => s + v);
  }

  bool hasVotedFor(String voterName, String studentName) {
    return _votes.any(
      (v) => v.voterName == voterName && v.studentName == studentName,
    );
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final votesJson = _votes.map((v) => jsonEncode(v.toJson())).toList();
    await prefs.setStringList('votes', votesJson);
  }
}
