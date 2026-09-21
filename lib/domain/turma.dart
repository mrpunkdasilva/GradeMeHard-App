import 'package:grademehard_app/domain/student.dart';

class Turma {
  final String id;
  final String name;
  final String inviteCode;
  final List<Student> students;

  Turma({
    required this.id,
    required this.name,
    required this.inviteCode,
    this.students = const [],
  });

  Turma copyWith({String? name, List<Student>? students}) {
    return Turma(
      id: id,
      name: name ?? this.name,
      inviteCode: inviteCode,
      students: students ?? this.students,
    );
  }
}
