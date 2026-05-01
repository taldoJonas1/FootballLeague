import 'package:flutter/material.dart';
import '../models/standing.dart';
import '../services/football_service.dart';

class StandingsScreen extends StatefulWidget {
  final String leagueName;
  final String leagueCode;

  const StandingsScreen({
    super.key,
    required this.leagueName,
    required this.leagueCode,
  });

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  late Future<List<Standing>> _standingsFuture;

  @override
  void initState() {
    super.initState();
    _standingsFuture = FootballService().getStandings(widget.leagueCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.leagueName),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Standing>>(
        future: _standingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erro: ${snapshot.error}'),
                ],
              ),
            );
          }
          final standings = snapshot.data!;
          return Column(
            children: [
              Container(
                color: const Color(0xFF1B5E20),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Row(
                  children: [
                    SizedBox(width: 32, child: Text('#', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
                    Expanded(child: Text('Time', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
                    SizedBox(width: 30, child: Text('J', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    SizedBox(width: 30, child: Text('V', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    SizedBox(width: 30, child: Text('E', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    SizedBox(width: 30, child: Text('D', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    SizedBox(width: 36, child: Text('Pts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final s = standings[index];
                    Color positionColor = Colors.transparent;
                    if (s.position <= 4) positionColor = Colors.blue.withOpacity(0.15);
                    if (s.position == 5) positionColor = Colors.orange.withOpacity(0.15);
                    if (s.position >= standings.length - 2) positionColor = Colors.red.withOpacity(0.15);

                    return Container(
                      color: positionColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Text('${s.position}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  s.teamCrest.isNotEmpty
                                      ? Image.network(s.teamCrest, width: 24, height: 24,
                                          errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer, size: 24))
                                      : const Icon(Icons.sports_soccer, size: 24),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(s.teamName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30, child: Text('${s.playedGames}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13))),
                            SizedBox(width: 30, child: Text('${s.won}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13))),
                            SizedBox(width: 30, child: Text('${s.draw}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13))),
                            SizedBox(width: 30, child: Text('${s.lost}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13))),
                            SizedBox(
                              width: 36,
                              child: Text('${s.points}', textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
