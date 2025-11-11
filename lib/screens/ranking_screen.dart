import 'package:flutter/material.dart';
import 'package:grademehard_app/mock_data.dart';
import 'package:grademehard_app/screens/group_builder_screen.dart';
import 'package:grademehard_app/screens/student_detail_screen.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_outlined),
            tooltip: 'Montar Grupo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupBuilderScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0, // Max width of each item
          mainAxisExtent: 303.0, // Fixed height of each item
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: mockStudents.length,
        itemBuilder: (context, index) {
          final student = mockStudents[index];
          return StudentCard(
            student: student,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetailScreen(student: student),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
