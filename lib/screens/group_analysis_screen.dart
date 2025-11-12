import 'package:flutter/material.dart';
import 'package:grademehard_app/student.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupAnalysisScreen extends StatelessWidget {
  final List<Student> group;

  const GroupAnalysisScreen({super.key, required this.group});

  // Helper to get an icon for an attribute
  IconData _getIconForAttribute(String attribute) {
    switch (attribute) {
      case 'Deadline Drive':
        return Icons.alarm;
      case 'Velocidade Alt+Tab':
        return Icons.tab;
      case 'QI de Debug':
        return Icons.bug_report;
      case 'Chute Certeiro':
        return Icons.check_circle_outline;
      case 'Palestrinha':
        return Icons.record_voice_over;
      case 'Bateria Social':
        return Icons.battery_charging_full;
      case 'Magia do Excel':
        return Icons.grid_on;
      case 'Resistência à Prova':
        return Icons.book;
      case 'Saída à Francesa':
        return Icons.exit_to_app;
      case 'Sangue de Café':
        return Icons.coffee;
      default:
        return Icons.help_outline;
    }
  }

  // --- Analysis Logic ---
  Map<String, double> _calculateAverageStats() {
    final averageStats = <String, double>{};
    if (group.isEmpty) return averageStats;

    // Get all attribute keys from the first student
    final attributeKeys = group.first.attributes.keys;

    for (final key in attributeKeys) {
      double total = 0;
      for (final student in group) {
        total += student.attributes[key] ?? 0;
      }
      averageStats[key] = total / group.length;
    }

    return averageStats;
  }

  String _generateFunnyAnalysis(Map<String, double> avgStats) {
    if (avgStats.isEmpty) return "Um grupo vazio... a personificação da procrastinação.";

    // Find highest and lowest stats
    final sortedStats = avgStats.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    final lowestStat = sortedStats.first;
    final highestStat = sortedStats.last;

    // Generate funny text based on highest and lowest stats
    // This can be expanded with many more fun combinations!
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
  // --- End of Analysis Logic ---


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final averageStats = _calculateAverageStats();
    final funnyAnalysis = _generateFunnyAnalysis(averageStats);

    return Scaffold(
      appBar: AppBar(
        title: Text("Análise do Grupo", style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Funny Analysis Text Card
            Card(
              color: theme.colorScheme.surface,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  funnyAnalysis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Average Stats List
            Text(
              'Atributos Médios do Grupo',
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: averageStats.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.white.withOpacity(0.1),
                height: 16,
              ),
              itemBuilder: (context, index) {
                final entry = averageStats.entries.elementAt(index);
                return Row(
                  children: [
                    Icon(
                      _getIconForAttribute(entry.key),
                      color: theme.colorScheme.secondary,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: LinearProgressIndicator(
                        value: entry.value / 10.0,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.secondary,
                        ),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      entry.value.toStringAsFixed(1), // Show one decimal place
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
