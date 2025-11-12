import 'package:flutter/material.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grademehard_app/services/group_analyzer.dart'; // Import the new service

class GroupAnalysisScreen extends StatelessWidget {
  final List<Student> group;

  const GroupAnalysisScreen({super.key, required this.group});

  // Helper to get an icon for an attribute (this remains here as it's UI related)
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use the GroupAnalyzer service for logic
    final averageStats = GroupAnalyzer.calculateAverageStats(group);
    final funnyAnalysis = GroupAnalyzer.generateFunnyAnalysis(averageStats);
    final totalGroupScore = averageStats.values.fold(0.0, (sum, element) => sum + element);
    final groupRank = GroupAnalyzer.getRankForScore(totalGroupScore);

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
            const SizedBox(height: 16),

            // Group Rank Card
            Card(
              color: theme.colorScheme.secondary.withOpacity(0.2),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/ranks/$groupRank.svg',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rank Final do Grupo',
                          style: GoogleFonts.cinzel(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Score Total: ${totalGroupScore.toStringAsFixed(1)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
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
                      entry.value.toStringAsFixed(1),
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
