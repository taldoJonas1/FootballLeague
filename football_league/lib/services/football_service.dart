import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/standing.dart';

class FootballService {
  static const String _baseUrl =
      'https://site.api.espn.com/apis/v2/sports/soccer';

  static const Map<String, String> _leagues = {
    'Premier League': 'eng.1',
    'La Liga': 'esp.1',
    'Bundesliga': 'ger.1',
    'Serie A': 'ita.1',
    'Ligue 1': 'fra.1',
  };

  static Map<String, String> get leagues => _leagues;

  Future<List<Standing>> getStandings(String leagueId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$leagueId/standings'),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List entries = data['children']?[0]?['standings']?['entries'] ?? [];
      return entries.map((e) => Standing.fromEspn(e)).toList();
    } else {
      throw Exception(
          'Erro ao carregar classificação (${response.statusCode})');
    }
  }
}
