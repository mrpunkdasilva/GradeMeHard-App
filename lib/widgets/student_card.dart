import 'package:flutter/material.dart';
import 'package:grademehard_app/student.dart';
import 'package:grademehard_app/screens/student_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  // Helper function to map attribute names to icons
  IconData _getIconForAttribute(String attribute) {
    switch (attribute) {
      case 'Força de Vontade':
        return Icons.shield;
      case 'Agilidade':
        return Icons.directions_run;
      case 'Inteligência':
        return Icons.school;
      case 'Sorte':
        return Icons.casino;
      case 'Carisma':
        return Icons.star;
      case 'Stamina':
        return Icons.favorite;
      case 'Magia':
        return Icons.auto_awesome; // A magic wand/sparkles icon
      case 'Defesa':
        return Icons.security;
      case 'Furtividade':
        return Icons.visibility_off;
      case 'Cafeína':
        return Icons.coffee;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailScreen(student: student),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: theme.colorScheme.secondary, width: 1),
        ),
        color: theme.colorScheme.surface.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image with Hero animation
            Expanded(
              flex: 5,
              child: Hero(
                tag: 'student-image-${student.name}',
                child: Image.network(
                  student.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            // Name
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Text(
                student.name,
                style: GoogleFonts.cinzel(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(color: theme.colorScheme.secondary, height: 1),
            // Attributes Grid
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(
                  spacing: 4.0, // horizontal spacing
                  runSpacing: 4.0, // vertical spacing
                  alignment: WrapAlignment.center,
                  children: student.attributes.entries.map((entry) {
                    return Tooltip(
                      message: '${entry.key}: ${entry.value}',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForAttribute(entry.key),
                            color: theme.colorScheme.secondary,
                            size: 18,
                          ),
                          Text(
                            '${entry.value}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
