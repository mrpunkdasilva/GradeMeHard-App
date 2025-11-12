import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grademehard_app/domain/rank.dart'; // Import the new Rank enum

class RanksExplainedScreen extends StatelessWidget {
  const RanksExplainedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de Ranks', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: Rank.values.length, // Iterate over enum values
        separatorBuilder: (context, index) => Divider(
          color: theme.dividerColor.withOpacity(0.1),
          height: 24,
        ),
        itemBuilder: (context, index) {
          final rank = Rank.values[index]; // Get rank enum value
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ranks/${rank.name}.svg', // Use rank.name
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rank ${rank.name.toUpperCase()}', // Use rank.name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Score: ${rank.minScore}-${rank.maxScore}', // Use rank.minScore and maxScore
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rank.description, // Use rank.description
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}