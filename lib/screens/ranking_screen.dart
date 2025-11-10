import 'package:flutter/material.dart';
import 'package:grademehard_app/mock_data.dart';
import 'package:grademehard_app/widgets/student_card.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking de Alunos'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Changed from 2 to 3
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.65, // Adjusted for the new content
        ),
        itemCount: mockStudents.length,
        itemBuilder: (context, index) {
          final student = mockStudents[index];
          return StudentCard(student: student);
        },
      ),
    );
  }
}
