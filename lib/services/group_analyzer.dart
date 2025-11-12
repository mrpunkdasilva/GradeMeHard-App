import 'package:grademehard_app/domain/student.dart';
import 'package:flutter/material.dart'; // For IconData, if needed for attribute mapping
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

    if (highestStat.key == 'Sangue de Café' && lowestStat.key == 'Bateria Social') {
      return "Este grupo funciona à base de pura cafeína e desespero. A produtividade é altíssima, mas há um risco de burnout coletivo antes do projeto chegar à v1.";
    }
    if (highestStat.key == 'QI de Debug' && lowestStat.key == 'Palestrinha') {
      return "Uma equipe de gênios introvertidos. O código será brilhante, mas a apresentação do projeto será feita em monossílabos e com muito contato visual com o chão.";
    }
    if (highestStat.key == 'Chute Certeiro' && lowestStat.key == 'Deadline Drive') {
      return "Este time é a prova de que é melhor ter sorte do que juízo. O projeto será entregue no último minuto, funcionando por um milagre que ninguém consegue explicar.";
    }
    if (highestStat.key == 'Palestrinha' && lowestStat.key == 'QI de Debug') {
      return "Mestres da lábia. Vão convencer o professor de que o bug é, na verdade, uma feature inovadora. O código pode não ser dos melhores, mas a nota será altíssima.";
    }

    return "Este grupo tem seu maior poder em '${highestStat.key}' e sua maior fraqueza em '${lowestStat.key}'. Um equilíbrio... interessante, para dizer o mínimo.";
  }
}