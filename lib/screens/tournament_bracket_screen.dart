import 'package:flutter/material.dart';

class TournamentBracketScreen extends StatelessWidget {
  const TournamentBracketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cây thi đấu Real-time')),
      body: InteractiveViewer( // Cho phép zoom và kéo cây thi đấu [cite: 193]
        constrained: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              _buildRoundColumn("Tứ kết", 4),
              _buildConnectorLine(),
              _buildRoundColumn("Bán kết", 2),
              _buildConnectorLine(),
              _buildRoundColumn("Chung kết", 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundColumn(String roundName, int matchCount) {
    return Column(
      children: [
        Text(roundName, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ...List.generate(matchCount, (index) => _buildMatchCard()),
      ],
    );
  }

  Widget _buildMatchCard() {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Text("Đội A - 11", style: TextStyle(fontSize: 12)),
          Divider(),
          Text("Đội B - 05", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildConnectorLine() {
    return Container(width: 30, height: 2, color: Colors.grey);
  }
}