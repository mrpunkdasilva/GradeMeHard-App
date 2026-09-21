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
      'Foguete no Cronograma': _random.nextInt(6),
      'Ctrl+Z Humano': _random.nextInt(6),
      'Sangue de Monster': _random.nextInt(6),
      'Chutônico': _random.nextInt(6),
      'Fantasma da Presence': _random.nextInt(6),
    },
  );
}

final List<Student> mockStudents = [
  Student(
    name: 'Zaladria',
    imageUrl: 'https://picsum.photos/seed/zaladria/200/300',
    attributes: {
      'Foguete no Cronograma': 5,
      'Ctrl+Z Humano': 3,
      'Sangue de Monster': 4,
      'Chutônico': 2,
      'Fantasma da Presence': 1,
    },
  ),
  Student(
    name: 'Jonas "O Coder Fantasma"',
    imageUrl: 'https://picsum.photos/seed/jonas/200/300',
    attributes: {
      'Foguete no Cronograma': 2,
      'Ctrl+Z Humano': 5,
      'Sangue de Monster': 3,
      'Chutônico': 4,
      'Fantasma da Presence': 5,
    },
  ),
  Student(
    name: 'Beatriz "A Rainha do Debug"',
    imageUrl: 'https://picsum.photos/seed/beatriz/200/300',
    attributes: {
      'Foguete no Cronograma': 5,
      'Ctrl+Z Humano': 5,
      'Sangue de Monster': 4,
      'Chutônico': 3,
      'Fantasma da Presence': 2,
    },
  ),
  Student(
    name: 'Carlos "O Mestre do Copia e Cola"',
    imageUrl: 'https://picsum.photos/seed/carlos/200/300',
    attributes: {
      'Foguete no Cronograma': 1,
      'Ctrl+Z Humano': 2,
      'Sangue de Monster': 3,
      'Chutônico': 5,
      'Fantasma da Presence': 4,
    },
  ),
  Student(
    name: 'Fernanda "A Procrastinadora Profissional"',
    imageUrl: 'https://picsum.photos/seed/fernanda/200/300',
    attributes: {
      'Foguete no Cronograma': 1,
      'Ctrl+Z Humano': 4,
      'Sangue de Monster': 2,
      'Chutônico': 5,
      'Fantasma da Presence': 3,
    },
  ),
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
