import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/domain/rank.dart'; // Import the new Rank enum

class GroupAnalyzer {
  static Map<String, double> calculateAverageStats(List<Student> group) {
    final averageStats = <String, double>{};
    if (group.isEmpty) return averageStats;

    // Assuming all students have the same attribute keys
    final attributeKeys = group.first.attributes.keys;

    for (final key in attributeKeys) {
      double total = 0;
      for (final student in group) {
        total += (student.attributes[key] ?? 0).toDouble();
      }
      averageStats[key] = total / group.length;
    }
    return averageStats;
  }

  static String getRankForScore(double score) {
    return Rank.fromScore(score).name;
  }

  static String generateFunnyAnalysis(Map<String, double> avgStats) {
    if (avgStats.isEmpty) return "Um grupo vazio... a personificação da procrastinação.";

    final sortedStats = avgStats.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    final lowestStat = sortedStats.first;
    final highestStat = sortedStats.last;

    if (highestStat.key == 'Resistência' && lowestStat.key == 'Carisma') {
      return "Este grupo aguenta qualquer desafio, mas ninguém consegue convencer o professor. Sobrevivem, mas não brilham.";
    }
    if (highestStat.key == 'Força' && lowestStat.key == 'Inteligência') {
      return "Muita força de vontade, pouca estratégia. O projeto vai ser entregue, mas pode não funcionar.";
    }
    if (highestStat.key == 'Sorte' && lowestStat.key == 'Inteligência') {
      return "Puro instinto. Não sabem o que estão fazendo, mas de alguma forma dá certo. Sorte de principiante?";
    }
    if (highestStat.key == 'Inteligência' && lowestStat.key == 'Resistência') {
      return "Gênios mas frágeis. O projeto será brilhante, se sobreviverem até a entrega.";
    }

    return "Este grupo tem seu maior poder em '${highestStat.key}' e sua maior fraqueza em '${lowestStat.key}'. Um equilíbrio... interessante.";
  }

  static List<Student> suggestStudentsForImprovement(
      List<Student> currentGroup, List<Student> allStudents) {
    if (currentGroup.isEmpty) return [];

    final averageStats = calculateAverageStats(currentGroup);
    if (averageStats.isEmpty) return [];

    // Identify the lowest average stat key
    final lowestStatEntry = averageStats.entries.reduce(
        (a, b) => a.value < b.value ? a : b);
    final lowestStatKey = lowestStatEntry.key;

    // Filter out students already in the current group
    final candidates = allStudents
        .where((student) => !currentGroup.contains(student))
        .toList();

    candidates.sort((a, b) =>
        (b.attributes[lowestStatKey] ?? 0)
            .compareTo(a.attributes[lowestStatKey] ?? 0));

    return candidates.take(3).toList();
  }
}
