import 'package:flutter/material.dart';

class UnitHeaderCard extends StatelessWidget {
  const UnitHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF58CC02), // Hijau Duolingo
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          bottom: BorderSide(color: Color(0xFF46A302), width: 5), // Efek 3D Bawah
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "UNIT 1",
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            "GREETINGS & BASICS",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 8),
          Text(
            "Learn basic phrases and greet people in Japanese",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}