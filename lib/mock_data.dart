// lib/mock_data.dart

import 'dart:math';
import 'student.dart';

final _random = Random();

// Helper function to create a student with random attributes
Student _createStudent(String name, String imageUrlSeed) {
  return Student(
    name: name,
    imageUrl: 'https://picsum.photos/seed/$imageUrlSeed/200/300',
    attributes: {
      'Força de Vontade': _random.nextInt(10) + 1,
      'Agilidade': _random.nextInt(10) + 1,
      'Inteligência': _random.nextInt(10) + 1,
      'Sorte': _random.nextInt(10) + 1,
      'Carisma': _random.nextInt(10) + 1,
      'Stamina': _random.nextInt(10) + 1,
      'Magia': _random.nextInt(10) + 1,
      'Defesa': _random.nextInt(10) + 1,
      'Furtividade': _random.nextInt(10) + 1,
      'Cafeína': _random.nextInt(10) + 1,
    },
  );
}

final List<Student> mockStudents = [
  Student(
    name: 'Zaladria',
    imageUrl: 'https://picsum.photos/seed/zaladria/200/300',
    attributes: {
      'Força de Vontade': 8,
      'Agilidade': 6,
      'Inteligência': 9,
      'Sorte': 5,
      'Carisma': 7,
      'Stamina': 4,
      'Magia': 10,
      'Defesa': 3,
      'Furtividade': 2,
      'Cafeína': 8,
    },
  ),
  Student(
    name: 'Jonas "O Coder Fantasma"',
    imageUrl: 'https://picsum.photos/seed/jonas/200/300',
    attributes: {
      'Força de Vontade': 5,
      'Agilidade': 9,
      'Inteligência': 8,
      'Sorte': 7,
      'Carisma': 4,
      'Stamina': 6,
      'Magia': 8,
      'Defesa': 5,
      'Furtividade': 10,
      'Cafeína': 7,
    },
  ),
  Student(
    name: 'Beatriz "A Rainha do Debug"',
    imageUrl: 'https://picsum.photos/seed/beatriz/200/300',
    attributes: {
      'Força de Vontade': 9,
      'Agilidade': 5,
      'Inteligência': 10,
      'Sorte': 6,
      'Carisma': 8,
      'Stamina': 7,
      'Magia': 3,
      'Defesa': 8,
      'Furtividade': 4,
      'Cafeína': 9,
    },
  ),
  Student(
    name: 'Carlos "O Mestre do Copia e Cola"',
    imageUrl: 'https://picsum.photos/seed/carlos/200/300',
    attributes: {
      'Força de Vontade': 3,
      'Agilidade': 10,
      'Inteligência': 5,
      'Sorte': 9,
      'Carisma': 6,
      'Stamina': 4,
      'Magia': 7,
      'Defesa': 6,
      'Furtividade': 8,
      'Cafeína': 5,
    },
  ),
  Student(
    name: 'Fernanda "A Procrastinadora Profissional"',
    imageUrl: 'https://picsum.photos/seed/fernanda/200/300',
    attributes: {
      'Força de Vontade': 2,
      'Agilidade': 7,
      'Inteligência': 6,
      'Sorte': 10,
      'Carisma': 9,
      'Stamina': 3,
      'Magia': 5,
      'Defesa': 4,
      'Furtividade': 9,
      'Cafeína': 4,
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
