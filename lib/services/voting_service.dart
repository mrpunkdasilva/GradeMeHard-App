import 'package:grademehard_app/domain/vote.dart';

class VotingService {
  static final VotingService _instance = VotingService._internal();
  factory VotingService() => _instance;
  VotingService._internal();

  final List<Vote> _votes = [];

  void addVote(Vote vote) {
    // For simplicity, we're not checking for duplicate votes from the same voter
    _votes.add(vote);
  }

  List<Vote> getVotesForStudent(String studentName) {
    return _votes.where((vote) => vote.studentName == studentName).toList();
  }

  List<Vote> getAllVotes() {
    return List.from(_votes);
  }
}
