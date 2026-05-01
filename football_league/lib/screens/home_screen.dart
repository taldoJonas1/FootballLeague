import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/football_service.dart';
import 'standings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _signOut() async {
    await GoogleSignIn(
      clientId:
          '241425730674-egs0qtndtqc8181de1jib9gauu8mnfac.apps.googleusercontent.com',
    ).signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final leagues = FootballService.leagues;

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚽ Football League'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF2E7D32),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child:
                      user?.photoURL == null ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, ${user?.displayName ?? 'Usuário'}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Escolha uma liga para ver a tabela',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final name = leagues.keys.elementAt(index);
                final code = leagues.values.elementAt(index);
                final icons = [
                  '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
                  '🇪🇸',
                  '🇩🇪',
                  '🇮🇹',
                  '🇫🇷'
                ];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Text(icons[index],
                        style: const TextStyle(fontSize: 32)),
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('Código: $code'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StandingsScreen(
                            leagueName: name,
                            leagueCode: code,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
