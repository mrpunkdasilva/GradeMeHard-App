enum Rank {
  f('f', 0, 2, 'Sobrevivente. A presença na faculdade é um ato de pura teimosia.'),
  e('e', 3, 4, 'Especialista em Prova Final. Já tem um lugar cativo na recuperação.'),
  d('d', 5, 6, 'Zona de Risco. Vive perigosamente perto da recuperação.'),
  c('c', 7, 8, 'Aluno Esforçado. A dificuldade é real, mas a força de vontade é maior.'),
  b('b', 9, 10, "Na Média. Passa em tudo, às vezes com um susto, mas sempre dá um jeito."),
  a('a', 11, 12, 'Aluno Exemplar. Faz os trabalhos e sabe o que está fazendo.'),
  s('s', 13, 14, 'Quase uma Lenda. Tira notas altas, mas ainda não alcançou a divindade.'),
  ss('ss', 15, 20, 'Lenda da Turma. O tipo de aluno que os professores citam como exemplo.');

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
