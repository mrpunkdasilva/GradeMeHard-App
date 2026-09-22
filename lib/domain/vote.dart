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

  Map<String, dynamic> toJson() {
    return {
      'voterName': voterName,
      'studentName': studentName,
      'attributePoints': attributePoints,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      voterName: json['voterName'] as String,
      studentName: json['studentName'] as String,
      attributePoints: Map<String, int>.from(json['attributePoints'] as Map),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
