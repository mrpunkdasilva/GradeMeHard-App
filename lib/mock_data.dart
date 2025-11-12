// lib/mock_data.dart

import 'dart:math';
import 'package:grademehard_app/domain/student.dart';

final _random = Random();

// Helper function to create a student with random attributes
Student _createStudent(String name, String imageUrlSeed) {
  return Student(
    name: name,
    imageUrl: 'https://picsum.photos/seed/$imageUrlSeed/200/300',
    attributes: {
      'Deadline Drive': _random.nextInt(10) + 1,
      'Velocidade Alt+Tab': _random.nextInt(10) + 1,
      'QI de Debug': _random.nextInt(10) + 1,
      'Chute Certeiro': _random.nextInt(10) + 1,
      'Palestrinha': _random.nextInt(10) + 1,
      'Bateria Social': _random.nextInt(10) + 1,
      'Magia do Excel': _random.nextInt(10) + 1,
      'Resistência à Prova': _random.nextInt(10) + 1,
      'Saída à Francesa': _random.nextInt(10) + 1,
      'Sangue de Café': _random.nextInt(10) + 1,
    },
  );
}

final List<Student> mockStudents = [
  Student(
    name: 'Zaladria',
    imageUrl: 'https://picsum.photos/seed/zaladria/200/300',
    attributes: {
      'Deadline Drive': 8,
      'Velocidade Alt+Tab': 6,
      'QI de Debug': 9,
      'Chute Certeiro': 5,
      'Palestrinha': 7,
      'Bateria Social': 4,
      'Magia do Excel': 10,
      'Resistência à Prova': 3,
      'Saída à Francesa': 2,
      'Sangue de Café': 8,
    },
  ),
  Student(
    name: 'Jonas "O Coder Fantasma"',
    imageUrl: 'https://picsum.photos/seed/jonas/200/300',
    attributes: {
      'Deadline Drive': 5,
      'Velocidade Alt+Tab': 9,
      'QI de Debug': 8,
      'Chute Certeiro': 7,
      'Palestrinha': 4,
      'Bateria Social': 6,
      'Magia do Excel': 8,
      'Resistência à Prova': 5,
      'Saída à Francesa': 10,
      'Sangue de Café': 7,
    },
  ),
  Student(
    name: 'Beatriz "A Rainha do Debug"',
    imageUrl: 'https://picsum.photos/seed/beatriz/200/300',
    attributes: {
      'Deadline Drive': 9,
      'Velocidade Alt+Tab': 5,
      'QI de Debug': 10,
      'Chute Certeiro': 6,
      'Palestrinha': 8,
      'Bateria Social': 7,
      'Magia do Excel': 3,
      'Resistência à Prova': 8,
      'Saída à Francesa': 4,
      'Sangue de Café': 9,
    },
  ),
  Student(
    name: 'Carlos "O Mestre do Copia e Cola"',
    imageUrl: 'https://picsum.photos/seed/carlos/200/300',
    attributes: {
      'Deadline Drive': 3,
      'Velocidade Alt+Tab': 10,
      'QI de Debug': 5,
      'Chute Certeiro': 9,
      'Palestrinha': 6,
      'Bateria Social': 4,
      'Magia do Excel': 7,
      'Resistência à Prova': 6,
      'Saída à Francesa': 8,
      'Sangue de Café': 5,
    },
  ),
  Student(
    name: 'Fernanda "A Procrastinadora Profissional"',
    imageUrl: 'https://picsum.photos/seed/fernanda/200/300',
    attributes: {
      'Deadline Drive': 2,
      'Velocidade Alt+Tab': 7,
      'QI de Debug': 6,
      'Chute Certeiro': 10,
      'Palestrinha': 9,
      'Bateria Social': 3,
      'Magia do Excel': 5,
      'Resistência à Prova': 4,
      'Saída à Francesa': 9,
      'Sangue de Café': 4,
    },
  ),
  // Adding 25 new mock students
  _createStudent('Lucas "O Mago do CSS"', 'lucas'),
  _createStudent('Mariana "A Lenda do Git"', 'mariana'),
  _createStudent('Pedro "O Destruidor de Builds"', 'pedro'),
  _createStudent('Juliana "A Imperatriz da API"', 'juliana'),
  _createStudent('Rafael "O Arquiteto de Microsserviços"', 'rafael'),
  _createStudent('Camila "A Ninja do JavaScript"', 'camila'),
  _createStudent('Gustavo "O Senhor dos Loops"', 'gustavo'),
  _createStudent('Larissa "A Deusa do Deploy"', 'larissa'),
  _createStudent('Matheus "O Caçador de Bugs"', 'matheus'),
  _createStudent('Amanda "A Oráculo do Stack Overflow"', 'amanda'),
  _createStudent('Bruno "O Executor de Scripts"', 'bruno'),
  _createStudent('Letícia "A Sacerdotisa do Scrum"', 'leticia'),
  _createStudent('Felipe "O Guardião da Documentação"', 'felipe'),
  _createStudent('Gabriela "A Mestre dos Testes"', 'gabriela'),
  _createStudent('Vinicius "O Alquimista de Dados"', 'vinicius'),
  _createStudent('Ana "A Feiticeira do Frontend"', 'ana'),
  _createStudent('Diego "O Bárbaro do Backend"', 'diego'),
  _createStudent('Sofia "A Encantadora de UX"', 'sofia'),
  _createStudent('Thiago "O Monge do Mobile"', 'thiago'),
  _createStudent('Isabella "A Paladina da Performance"', 'isabella'),
  _createStudent('João "O Gladiador do Gradle"', 'joao'),
  _createStudent('Laura "A Dama do Docker"', 'laura'),
  _createStudent('Daniel "O Profeta do Python"', 'daniel'),
  _createStudent('Beatriz "A Valquíria do Vue"', 'beatriz2'),
  _createStudent('Ricardo "O Rei do Regex"', 'ricardo'),
];