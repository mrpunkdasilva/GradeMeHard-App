import 'dart:math';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/domain/turma.dart';

class TurmaService {
  static final TurmaService _instance = TurmaService._internal();
  factory TurmaService() => _instance;
  TurmaService._internal();

  Turma? _currentTurma;
  Student? _currentUser;

  Turma? get currentTurma => _currentTurma;
  Student? get currentUser => _currentUser;

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rng = Random();
    return List.generate(6, (_) => chars[rng.nextInt(chars.length)]).join();
  }

  Turma createTurma(String name, String creatorName) {
    final creator = Student(
      name: creatorName,
      imageUrl: 'https://picsum.photos/seed/${creatorName.hashCode}/200/300',
      attributes: {
        'Inteligência': 0,
        'Força': 0,
        'Resistência': 0,
        'Sorte': 0,
        'Carisma': 0,
      },
    );

    final turma = Turma(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      inviteCode: _generateCode(),
      students: [creator],
    );
    _currentTurma = turma;
    _currentUser = creator;
    return turma;
  }

  bool joinTurma(String code, String studentName) {
    final turma = _findTurmaByCode(code);
    if (turma == null) return false;

    final alreadyExists = turma.students.any(
      (s) => s.name.toLowerCase() == studentName.toLowerCase(),
    );
    if (alreadyExists) return false;

    final newStudent = Student(
      name: studentName,
      imageUrl: 'https://picsum.photos/seed/${studentName.hashCode}/200/300',
      attributes: {
        'Inteligência': 0,
        'Força': 0,
        'Resistência': 0,
        'Sorte': 0,
        'Carisma': 0,
      },
    );

    _currentTurma = turma.copyWith(
      students: [...turma.students, newStudent],
    );
    _currentUser = newStudent;
    return true;
  }

  void setCurrentUser(Student student) {
    _currentUser = student;
  }

  Turma? _findTurmaByCode(String code) {
    if (_currentTurma != null && _currentTurma!.inviteCode == code) {
      return _currentTurma;
    }
    // Mock turmas for demo
    return Turma(
      id: 'demo',
      name: 'Turma Demo',
      inviteCode: code,
    );
  }

  List<Student> getStudentsToVote() {
    if (_currentTurma == null || _currentUser == null) return [];
    return _currentTurma!.students
        .where((s) => s.name != _currentUser!.name)
        .toList();
  }
}
