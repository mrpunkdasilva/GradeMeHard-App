class Vote {
  final String voterName;
  final String studentName;
  final Map<String, int> attributePoints;
  final DateTime timestamp;

  Vote({
    required this.voterName,
    required this.studentName,
    required this.attributePoints,
    required this.timestamp,
  });
}
