enum Rank {
  f('f', 0, 3, 'Sobrevivente. A presença na faculdade é um ato de pura teimosia.'),
  e('e', 4, 6, 'Especialista em Prova Final. Já tem um lugar cativo na recuperação.'),
  d('d', 7, 9, 'Zona de Risco. Vive perigosamente perto da recuperação.'),
  c('c', 10, 12, 'Aluno Esforçado. A dificuldade é real, mas a força de vontade é maior.'),
  b('b', 13, 15, "Na Média. Passa em tudo, às vezes com um susto, mas sempre dá um jeito."),
  a('a', 16, 17, 'Aluno Exemplar. Faz os trabalhos e sabe o que está fazendo.'),
  s('s', 18, 19, 'Quase uma Lenda. Tira notas altas, mas ainda não alcançou a divindade.'),
  ss('ss', 20, 20, 'Lenda da Turma. O tipo de aluno que os professores citam como exemplo.');

  final String name;
  final int minScore;
  final int maxScore;
  final String description;

  const Rank(this.name, this.minScore, this.maxScore, this.description);

  static Rank fromScore(double score) {
    for (final rank in Rank.values.reversed) {
      if (score >= rank.minScore) {
        return rank;
      }
    }
    return Rank.f;
  }
}
