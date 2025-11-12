import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Data class for rank details
class RankDetail {
  final String rank;
  final String scoreRange;
  final String description;

  RankDetail({
    required this.rank,
    required this.scoreRange,
    required this.description,
  });
}

// The list of all rank details
final List<RankDetail> rankDetails = [
  RankDetail(
    rank: 'ss',
    scoreRange: '95-100',
    description: 'Lenda da Turma. O tipo de aluno que os professores citam como exemplo e que os colegas pedem ajuda na véspera da prova.',
  ),
  RankDetail(
    rank: 's',
    scoreRange: '85-94',
    description: 'Quase uma Lenda. Tira notas altas, entende a matéria, mas ainda não alcançou o status de divindade acadêmica.',
  ),
  RankDetail(
    rank: 'a',
    scoreRange: '75-84',
    description: 'Aluno Exemplar. Faz os trabalhos, estuda para as provas e geralmente sabe o que está fazendo. Um pilar de qualquer grupo.',
  ),
  RankDetail(
    rank: 'b',
    scoreRange: '65-74',
    description: "Na Média. Passa em tudo, às vezes com um susto, mas sempre dá um jeito. O verdadeiro significado de 'o importante é passar'.",
  ),
  RankDetail(
    rank: 'c',
    scoreRange: '55-64',
    description: 'Aluno Esforçado. A dificuldade é real, mas a força de vontade (ou o desespero) é maior. Cada ponto é uma vitória.',
  ),
  RankDetail(
    rank: 'd',
    scoreRange: '45-54',
    description: 'Zona de Risco. Vive perigosamente perto da recuperação e da DP. A calculadora de média é sua melhor amiga.',
  ),
  RankDetail(
    rank: 'e',
    scoreRange: '35-44',
    description: 'Especialista em Prova Final. Já tem um lugar cativo na prova de recuperação. A esperança é a última que morre.',
  ),
  RankDetail(
    rank: 'f',
    scoreRange: '< 35',
    description: 'Sobrevivente. A presença na faculdade é um ato de pura teimosia. Cada dia é uma nova batalha contra a chamada.',
  ),
];

class RanksExplainedScreen extends StatelessWidget {
  const RanksExplainedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de Ranks', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: rankDetails.length,
        separatorBuilder: (context, index) => Divider(
          color: theme.dividerColor.withOpacity(0.1),
          height: 24,
        ),
        itemBuilder: (context, index) {
          final rank = rankDetails[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ranks/${rank.rank}.svg',
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rank ${rank.rank.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Score: ${rank.scoreRange}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rank.description,
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
