// lib/student.dart

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
    final score = totalScore;
    if (score >= 95) return 'ss';
    if (score >= 85) return 's';
    if (score >= 75) return 'a';
    if (score >= 65) return 'b';
    if (score >= 55) return 'c';
    if (score >= 45) return 'd';
    if (score >= 35) return 'e';
    return 'f';
  }
}
