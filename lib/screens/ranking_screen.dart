import 'package:flutter/material.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/screens/attributes_screen.dart';
import 'package:grademehard_app/screens/group_builder_screen.dart';
import 'package:grademehard_app/screens/ranks_explained_screen.dart';
import 'package:grademehard_app/screens/student_detail_screen.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/widgets/student_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RankingBody();
  }
}

class RankingBody extends StatelessWidget {
  const RankingBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Sort students by total score in descending order
    final sortedStudents = List<Student>.from(mockStudents)
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));

    final top5Students = sortedStudents.take(5).toList();
    final remainingStudents = sortedStudents.skip(5).toList();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Top 5 Section ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Top 5 Alunos',
            style: GoogleFonts.cinzel(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          height: 260, // Height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: top5Students.length,
            itemBuilder: (context, index) {
              final student = top5Students[index];
              return SizedBox(
                width: 250, // Width of the larger cards for top 5
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: StudentCard(
                    student: student,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailScreen(student: student),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),

        // --- Divider and Title for the rest ---
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Text(
            'Ranking Geral',
            style: GoogleFonts.cinzel(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),

        // --- Remaining Students List ---
        Expanded(
          child: ListView.builder(
            itemCount: remainingStudents.length,
            itemBuilder: (context, index) {
              final student = remainingStudents[index];
              // Rank position starts from 6
              final rankPosition = index + 6;
              return _StudentListTile(
                student: student,
                rankPosition: rankPosition,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudentDetailScreen(student: student),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// A custom list tile for the general ranking
class _StudentListTile extends StatelessWidget {
  final Student student;
  final int rankPosition;
  final VoidCallback onTap;

  const _StudentListTile({
    required this.student,
    required this.rankPosition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            // Rank Position
            Text(
              '$rankPosition',
              style: GoogleFonts.cinzel(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(width: 16),
            // Student Image
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(student.imageUrl),
            ),
            const SizedBox(width: 16),
            // Name and Score
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Score: ${student.totalScore}',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Rank SVG
            SvgPicture.asset(
              'assets/images/ranks/${student.rank}.svg',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
