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
    icon: Icons.alarm,
    name: 'Deadline Drive',
    description: 'A energia que só um prazo de entrega de projeto pode gerar.',
  ),
  AttributeDetail(
    icon: Icons.tab,
    name: 'Velocidade Alt+Tab',
    description: 'A rapidez para alternar entre o AutoCAD, o WhatsApp e a aula gravada.',
  ),
  AttributeDetail(
    icon: Icons.bug_report,
    name: 'QI de Debug',
    description: 'A genialidade para achar o erro no código ou no cálculo que ninguém mais viu.',
  ),
  AttributeDetail(
    icon: Icons.check_circle_outline,
    name: 'Chute Certeiro',
    description: 'A habilidade de acertar aquela questão de múltipla escolha na prova sem ter a menor ideia.',
  ),
  AttributeDetail(
    icon: Icons.record_voice_over,
    name: 'Palestrinha',
    description: 'A habilidade de dar mini-palestras sobre assuntos óbvios e atrasar a reunião do grupo.',
  ),
  AttributeDetail(
    icon: Icons.battery_charging_full,
    name: 'Bateria Social',
    description: 'A energia para trabalhos em grupo antes de precisar se isolar com seus fones de ouvido.',
  ),
  AttributeDetail(
    icon: Icons.grid_on,
    name: 'Magia do Excel',
    description: 'A capacidade de criar planilhas que resolvem problemas de cálculo e geram gráficos que o professor ama.',
  ),
  AttributeDetail(
    icon: Icons.book,
    name: 'Resistência à Prova',
    description: 'A capacidade de sobreviver a uma semana de provas finais com poucas horas de sono e muita matéria acumulada.',
  ),
  AttributeDetail(
    icon: Icons.exit_to_app,
    name: 'Saída à Francesa',
    description: 'A arte de escapar daquela aula de Cálculo IV às 7h da manhã sem que o professor perceba.',
  ),
  AttributeDetail(
    icon: Icons.coffee,
    name: 'Sangue de Café',
    description: 'Quando seu corpo funciona à base de café e da esperança de se formar um dia.',
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
