import 'package:flutter/material.dart';

class TopStatusBar extends StatelessWidget {
  const TopStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              // Icon(Icons.menu, color: Color(0xFFB56A3F), size: 28),
              SizedBox(width: 12),
              Text("MIRAIKU", style: TextStyle(color: Color(0xFFB56A3F), fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFEFE8DD), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: const [
                Text("7", style: TextStyle(color: Color(0xFFD36B36), fontWeight: FontWeight.bold)),
                SizedBox(width: 4), Icon(Icons.local_fire_department, color: Color(0xFFD36B36), size: 18),
                Text(" | ", style: TextStyle(color: Colors.grey)),
                Text("5", style: TextStyle(color: Color(0xFFD36B36), fontWeight: FontWeight.bold)),
                SizedBox(width: 4), Icon(Icons.favorite, color: Color(0xFFD36B36), size: 18),
                Text(" | ", style: TextStyle(color: Colors.grey)),
                Icon(Icons.star, color: Colors.grey, size: 18),
                SizedBox(width: 4), Text("450", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}