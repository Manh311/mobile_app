import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tournament_provider.dart';

class TournamentListScreen extends StatelessWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentProvider456>();

    return Scaffold(
      appBar: AppBar(title: const Text('Giải đấu chuyên nghiệp')),
      body: ListView.builder(
        itemCount: provider.tournaments.length,
        itemBuilder: (context, index) {
          final t = provider.tournaments[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.emoji_events, color: Colors.orange),
              title: Text(t.name),
              subtitle: Text("Lệ phí: ${t.entryFee}₫"),
              trailing: ElevatedButton(
                onPressed: () => provider.joinTournament(t.id),
                child: const Text('Tham gia'),
              ),
            ),
          );
        },
      ),
    );
  }
}