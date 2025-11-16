import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/domain/vote.dart';
import 'package:grademehard_app/screens/attributes_screen.dart';
import 'package:grademehard_app/services/voting_service.dart';

class AttributeVotingScreen extends StatefulWidget {
  final Student student;
  final String voterName;

  const AttributeVotingScreen({
    super.key,
    required this.student,
    required this.voterName,
  });

  @override
  State<AttributeVotingScreen> createState() => _AttributeVotingScreenState();
}

class _AttributeVotingScreenState extends State<AttributeVotingScreen> {
  final VotingService _votingService = VotingService();
  late Map<String, int> _attributePoints;
  late int _remainingPoints;

  @override
  void initState() {
    super.initState();
    _remainingPoints = 10;
    _attributePoints = {
      for (var attr in attributeDetails) attr.name: 0
    };
  }

  void _updatePoints(String attributeName, int delta) {
    final currentPoints = _attributePoints[attributeName]!;
    final newPoints = currentPoints + delta;

    if (newPoints < 0 || newPoints > 10) return;

    if (_remainingPoints - delta < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você não tem mais pontos para distribuir!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _attributePoints[attributeName] = newPoints;
      _remainingPoints -= delta;
    });
  }

  void _submitVote() {
    if (_remainingPoints > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você ainda tem $_remainingPoints pontos para distribuir!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final vote = Vote(
      voterName: widget.voterName,
      studentName: widget.student.name,
      attributePoints: _attributePoints,
      timestamp: DateTime.now(),
    );

    _votingService.addVote(vote);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voto para ${widget.student.name} registrado!'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Votar em ${widget.student.name}', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Você tem $_remainingPoints pontos restantes',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attributeDetails.length,
              itemBuilder: (context, index) {
                final attribute = attributeDetails[index];
                final points = _attributePoints[attribute.name]!;

                final canIncrement = points < 10 && _remainingPoints > 0;
                final canDecrement = points > 0;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          attribute.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: canDecrement ? () => _updatePoints(attribute.name, -1) : null,
                            ),
                            Text(
                              points.toString(),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                              onPressed: canIncrement ? () => _updatePoints(attribute.name, 1) : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _submitVote,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Confirmar Voto'),
            ),
          ),
        ],
      ),
    );
  }
}
