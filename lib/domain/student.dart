import 'package:grademehard_app/domain/rank.dart';
import 'package:grademehard_app/services/voting_service.dart';

class Student {
  final String name;
  final String imageUrl;
  final Map<String, int> attributes;

  Student({
    required this.name,
    required this.imageUrl,
    required this.attributes,
  });

  int get totalScore {
    final votedScore = VotingService().getStudentTotalScore(name);
    if (votedScore > 0) return votedScore;
    return attributes.values.fold(0, (sum, element) => sum + element);
  }

  String get rank {
    return Rank.fromScore(totalScore.toDouble()).name;
  }

  Map<String, int> get effectiveAttributes {
    final voted = VotingService().getAverageAttributes(name);
    if (voted.isNotEmpty) return voted;
    return attributes;
  }

  static int getModifier(int score) {
    return ((score - 10) / 2).floor();
  }

  static String formatModifier(int score) {
    final mod = getModifier(score);
    if (mod > 0) return '+$mod';
    return '$mod';
  }
}
