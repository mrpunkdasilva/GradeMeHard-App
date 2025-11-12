// lib/student.dart

import 'dart:math';
import 'package:grademehard_app/domain/rank.dart'; // Import the new Rank enum

class Student {
  final String name;
  final String imageUrl;
  final Map<String, int> attributes;

  Student({
    required this.name,
    required this.imageUrl,
    required this.attributes,
  });

  // Getter to calculate the total score from attributes
  int get totalScore {
    return attributes.values.fold(0, (sum, element) => sum + element);
  }

  // Getter to determine rank based on total score
  String get rank {
    return Rank.fromScore(totalScore.toDouble()).name;
  }
}