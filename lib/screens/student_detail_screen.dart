import 'package:flutter/material.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/screens/attributes_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grademehard_app/screens/student_discussion_screen.dart';
import 'package:grademehard_app/services/voting_service.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  IconData _getIconForAttribute(String attribute) {
    final detail = attributeDetails.firstWhere(
      (d) => d.name == attribute,
      orElse: () => AttributeDetail(icon: Icons.help_outline, name: '', description: '', imagePath: ''),
    );
    return detail.icon;
  }

  String _getAttributeDescription(String attributeName) {
    final detail = attributeDetails.firstWhere(
      (d) => d.name == attributeName,
      orElse: () => AttributeDetail(icon: Icons.help_outline, name: '', description: 'Nenhuma descrição encontrada.', imagePath: ''),
    );
    return detail.description;
  }

  Color _getModifierColor(int score) {
    final mod = Student.getModifier(score);
    if (mod >= 3) return Colors.green;
    if (mod >= 1) return Colors.lightGreen;
    if (mod == 0) return Colors.grey;
    if (mod >= -2) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final votingService = VotingService();
    final votedAttributes = votingService.getAverageAttributes(student.name);
    final attributes = votedAttributes.isNotEmpty
        ? votedAttributes.entries.toList()
        : student.attributes.entries.toList();
    final totalScore = votingService.getStudentTotalScore(student.name);
    final displayScore = totalScore > 0 ? totalScore : student.totalScore;
    final voteCount = votingService.getVotesForStudent(student.name).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          student.name,
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SvgPicture.asset(
                      'assets/images/card.svg',
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: SvgPicture.asset(
                      'assets/images/ranks/${student.rank}.svg',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Text(
                      student.name,
                      style: GoogleFonts.cinzel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          const Shadow(blurRadius: 6, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.secondary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SCORE TOTAL: ',
                    style: GoogleFonts.cinzel(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '$displayScore',
                    style: GoogleFonts.cinzel(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$voteCount voto${voteCount != 1 ? 's' : ''} recebido${voteCount != 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Atributos',
              style: GoogleFonts.cinzel(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attributes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final attribute = attributes[index];
                final score = attribute.value;
                final modifier = Student.getModifier(score);
                final modifierStr = Student.formatModifier(score);
                final modifierColor = _getModifierColor(score);

                final detail = attributeDetails.firstWhere(
                  (d) => d.name == attribute.key,
                  orElse: () => AttributeDetail(icon: Icons.help_outline, name: '', description: '', imagePath: ''),
                );

                return Tooltip(
                  message: _getAttributeDescription(attribute.key),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          detail.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 60,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  _getIconForAttribute(attribute.key),
                                  color: theme.colorScheme.secondary,
                                  size: 24,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        attribute.key,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        modifierStr,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: modifierColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    child: LinearProgressIndicator(
                                      value: (score / 20).clamp(0.0, 1.0),
                                      backgroundColor: Colors.white24,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        modifierColor,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$score',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDiscussionScreen(student: student),
            ),
          );
        },
        label: Text('Discutir', style: GoogleFonts.cinzel()),
        icon: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
