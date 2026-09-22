import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/screens/season_start_screen.dart';
import 'package:grademehard_app/services/auth_service.dart';
import 'package:grademehard_app/services/voting_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().init();
  await VotingService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define our dark, high-fantasy color scheme
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6A1B9A), // Deep mystical purple
      brightness: Brightness.dark,
      primary: const Color(0xFF8E44AD), // Lighter purple
      secondary: const Color(0xFF00BCD4), // Magical cyan accent
      background: const Color(0xFF121212), // Very dark background
      surface: const Color(0xFF1E1E1E), // Slightly lighter surface for cards
    );

    // Create the theme data
    final theme = ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colorScheme.secondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ).apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Grade Me Hard',
      theme: theme,
      home: const SeasonStartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
