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
      orElse: () => AttributeDetail(icon: Icons.help_outline, name: '', description: ''),
    );
    return detail.icon;
  }

  String _getAttributeDescription(String attributeName) {
    final detail = attributeDetails.firstWhere(
      (d) => d.name == attributeName,
      orElse: () => AttributeDetail(icon: Icons.help_outline, name: '', description: 'Nenhuma descrição encontrada.'),
    );
    return detail.description;
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
                  Hero(
                    tag: 'student-image-${student.name}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        student.imageUrl,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 300,
                          width: 300,
                          color: Colors.grey[800],
                          child: const Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      ),
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Score: $displayScore',
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${votingService.getVotesForStudent(student.name).length} votos recebidos',
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
              separatorBuilder: (context, index) => Divider(
                color: Colors.white.withOpacity(0.1),
                height: 16,
              ),
              itemBuilder: (context, index) {
                final attribute = attributes[index];
                final maxScore = 10;
                return Tooltip(
                  message: _getAttributeDescription(attribute.key),
                  child: Row(
                    children: [
                      Icon(
                        _getIconForAttribute(attribute.key),
                        color: theme.colorScheme.secondary,
                        size: 28,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Text(
                          attribute.key,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: LinearProgressIndicator(
                          value: (attribute.value / maxScore).clamp(0.0, 1.0),
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.secondary,
                          ),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${attribute.value}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
