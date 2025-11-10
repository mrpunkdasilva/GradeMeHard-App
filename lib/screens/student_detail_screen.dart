import 'package:flutter/material.dart';
import 'package:grademehard_app/student.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  // Helper function to map attribute names to icons (copied from StudentCard)
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
    final attributes = student.attributes.entries.toList();

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
            // Character Image
            Center(
              child: Hero(
                tag: 'student-image-${student.name}', // Unique tag for the animation
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
            // Attributes List
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
                return Row(
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
                        value: attribute.value / 10.0, // Assuming max value is 10
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.secondary,
                        ),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${attribute.value}/10',
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
