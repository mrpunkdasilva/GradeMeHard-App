enum Rank {
  f('f', 0, 8, 'Sobrevivente. A presença na faculdade é um ato de pura teimosia. Cada dia é uma nova batalha contra a chamada.'),
  e('e', 9, 11, 'Especialista em Prova Final. Já tem um lugar cativo na prova de recuperação. A esperança é a última que morre.'),
  d('d', 12, 14, 'Zona de Risco. Vive perigosamente perto da recuperação e da DP. A calculadora de média é sua melhor amiga.'),
  c('c', 15, 17, 'Aluno Esforçado. A dificuldade é real, mas a força de vontade (ou o desespero) é maior. Cada ponto é uma vitória.'),
  b('b', 18, 19, "Na Média. Passa em tudo, às vezes com um susto, mas sempre dá um jeito. O verdadeiro significado de 'o importante é passar'."),
  a('a', 20, 21, 'Aluno Exemplar. Faz os trabalhos, estuda para as provas e geralmente sabe o que está fazendo. Um pilar de qualquer grupo.'),
  s('s', 22, 23, 'Quase uma Lenda. Tira notas altas, entende a matéria, mas ainda não alcançou o status de divindade acadêmica.'),
  ss('ss', 24, 25, 'Lenda da Turma. O tipo de aluno que os professores citam como exemplo e que os colegas pedem ajuda na véspera da prova.');

  final String name;
  final int minScore;
  final int maxScore;
  final String description;

  const Rank(this.name, this.minScore, this.maxScore, this.description);

  static Rank fromScore(double score) {
    for (final rank in Rank.values.reversed) { // Iterate in reverse to match highest scores first
      if (score >= rank.minScore) {
        return rank;
      }
    }
    return Rank.f; // Default to F if score is below all defined minScores
  }
}
