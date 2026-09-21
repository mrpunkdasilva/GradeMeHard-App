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

    if (highestStat.key == 'Sangue de Monster' && lowestStat.key == 'Fantasma da Presence') {
      return "Este grupo funciona à base de Monster e ansiedade. Trabalham muito, mas ninguém aparece na aula. O professor já esqueceu o nome deles.";
    }
    if (highestStat.key == 'Ctrl+Z Humano' && lowestStat.key == 'Foguete no Cronograma') {
      return "Mestres do improviso. Entregam tudo no último minuto, mas sempre tem um herói que conserta antes da apresentação.";
    }
    if (highestStat.key == 'Chutônico' && lowestStat.key == 'Foguete no Cronograma') {
      return "Este time é a prova de que sorte também é habilidade. O projeto será entregue atrasado, mas a nota será surpreendentemente alta.";
    }
    if (highestStat.key == 'Foguete no Cronograma' && lowestStat.key == 'Sangue de Monster') {
      return "Grupo organizado e pontual. Entregam tudo antes do prazo, mas precisam de muito café para manter o ritmo.";
    }

    return "Este grupo tem seu maior poder em '${highestStat.key}' e sua maior fraqueza em '${lowestStat.key}'. Um equilíbrio... interessante, para dizer o mínimo.";
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
