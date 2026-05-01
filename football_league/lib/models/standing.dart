class Standing {
  final int position;
  final String teamName;
  final String teamCrest;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;

  Standing({
    required this.position,
    required this.teamName,
    required this.teamCrest,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
  });

  static int _stat(List stats, String name) {
    final s = stats.firstWhere(
      (s) => s['name'] == name,
      orElse: () => {'value': 0},
    );
    return (s['value'] as num?)?.toInt() ?? 0;
  }

  factory Standing.fromEspn(Map<String, dynamic> json) {
    final stats = json['stats'] as List? ?? [];
    return Standing(
      position: _stat(stats, 'rank'),
      teamName: json['team']?['displayName'] ?? '',
      teamCrest: json['team']?['logos']?[0]?['href'] ?? '',
      playedGames: _stat(stats, 'gamesPlayed'),
      won: _stat(stats, 'wins'),
      draw: _stat(stats, 'ties'),
      lost: _stat(stats, 'losses'),
      points: _stat(stats, 'points'),
      goalsFor: _stat(stats, 'pointsFor'),
      goalsAgainst: _stat(stats, 'pointsAgainst'),
      goalDifference: _stat(stats, 'pointDifferential'),
    );
  }
}
