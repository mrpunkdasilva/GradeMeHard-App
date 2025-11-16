import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/screens/voting_screen.dart';

class SeasonStartScreen extends StatefulWidget {
  const SeasonStartScreen({super.key});

  @override
  State<SeasonStartScreen> createState() => _SeasonStartScreenState();
}

class _SeasonStartScreenState extends State<SeasonStartScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const VotingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A Temporada de Votação Começou!',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Prepare-se para votar...',
              style: GoogleFonts.lato(
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
