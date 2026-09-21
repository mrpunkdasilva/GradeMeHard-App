import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Data class for attribute details
class AttributeDetail {
  final IconData icon;
  final String name;
  final String description;

  AttributeDetail({
    required this.icon,
    required this.name,
    required this.description,
  });
}

// The list of all attribute details
final List<AttributeDetail> attributeDetails = [
  AttributeDetail(
    icon: Icons.rocket_launch,
    name: 'Foguete no Cronograma',
    description: 'O cara que entrega tudo antes do prazo. Tão raro que deveria ser estudado pela NASA',
  ),
  AttributeDetail(
    icon: Icons.undo,
    name: 'Mito',
    description: 'Sempre tem uma solução. Se fosse um jogo, ele seria o cheat code',
  ),
  AttributeDetail(
    icon: Icons.local_drink,
    name: 'Sangue de Café',
    description: 'Corpo humano? Não. 70% Monster, 20% café, 10% ansiedade existencial.',
  ),
  AttributeDetail(
    icon: Icons.casino,
    name: 'Falador',
    description: 'O cara que fala mais que o professor e ainda consegue convencer o grupo a mudar de ideia.',
  ),
  AttributeDetail(
    icon: Icons.visibility_off,
    name: 'Fantasma',
    description: 'O cara que some do mapa. E só aparece quando o professor chama.',
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
