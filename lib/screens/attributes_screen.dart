import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttributeDetail {
  final IconData icon;
  final String name;
  final String description;
  final String imagePath;

  AttributeDetail({
    required this.icon,
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

final List<AttributeDetail> attributeDetails = [
  AttributeDetail(
    icon: Icons.psychology,
    name: 'Inteligência',
    description: 'A capacidade de entender a matéria sem precisar de 3 tutoriais no YouTube.',
    imagePath: 'assets/images/rectangle-purple.svg',
  ),
  AttributeDetail(
    icon: Icons.fitness_center,
    name: 'Força',
    description: 'A capacidade de carregar o grupo inteiro nas costas no projeto final.',
    imagePath: 'assets/images/rectangle-red.svg',
  ),
  AttributeDetail(
    icon: Icons.shield,
    name: 'Resistência',
    description: 'Sobreviver a uma semana de provas com 2h de sono e muita matéria acumulada.',
    imagePath: 'assets/images/rectangle-brown.svg',
  ),
  AttributeDetail(
    icon: Icons.casino,
    name: 'Sorte',
    description: 'Acertar tudo chutando. Não sabe a matéria, mas o chute é certeiro.',
    imagePath: 'assets/images/rectangle-yellow.svg',
  ),
  AttributeDetail(
    icon: Icons.star,
    name: 'Carisma',
    description: 'Convencer o professor de que o bug é uma feature. Fala mais que o grupo inteiro.',
    imagePath: 'assets/images/rectangle-purple.svg',
  ),
];

class AttributesScreen extends StatelessWidget {
  const AttributesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Glossário de Atributos', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: attributeDetails.length,
        separatorBuilder: (context, index) => Divider(
          color: theme.dividerColor.withOpacity(0.1),
          height: 24,
        ),
        itemBuilder: (context, index) {
          final attribute = attributeDetails[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                attribute.icon,
                size: 40,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attribute.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      attribute.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
