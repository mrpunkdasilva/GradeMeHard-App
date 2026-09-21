import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/screens/attribute_voting_screen.dart';
import 'package:grademehard_app/screens/ranking_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _students = List.from(mockStudents);
  }

  Future<void> _vote(Student student) async {
    final votedStudentName = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AttributeVotingScreen(
          student: student,
          voterName: 'Votante',
        ),
      ),
    );

    if (votedStudentName != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Voto para $votedStudentName registrado!'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Votação da Turma', style: GoogleFonts.cinzel()),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RankingScreen()),
              );
            },
            icon: const Icon(Icons.emoji_events_outlined),
            label: const Text('Ranking'),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Toque em um aluno para votar',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 230,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return _StudentVoteCard(
                  student: student,
                  onTap: () => _vote(student),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentVoteCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const _StudentVoteCard({
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.colorScheme.secondary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    student.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.person, size: 60, color: Colors.white54),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SvgPicture.asset(
                      'assets/images/ranks/${student.rank}.svg',
                      width: 36,
                      height: 36,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: GoogleFonts.cinzel(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Score: ${student.totalScore}',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
