import 'package:flutter/material.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;
  final bool enableHero;

  const StudentCard({
    super.key,
    required this.student,
    this.onTap,
    this.enableHero = true,
  });

  // Helper function to map attribute names to icons
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

    final imageWidget = Image.network(
      student.imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(Icons.error)),
    );

    return InkWell(
      onTap: onTap,
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
            // Image with Hero animation and Rank Icon
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  enableHero
                      ? Hero(
                          tag: 'student-image-${student.name}',
                          child: imageWidget,
                        )
                      : imageWidget,
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SvgPicture.asset(
                      'assets/images/ranks/${student.rank}.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
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
              flex: 2,
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
