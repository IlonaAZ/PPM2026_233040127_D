import 'package:flutter/material.dart';

enum NodeStatus { completed, current, locked, test }

class PathNode extends StatelessWidget {
  final String title;
  final NodeStatus status;
  final Alignment alignment;
  final int stars;
  final IconData? customIcon;

  const PathNode({
    super.key,
    required this.title,
    required this.status,
    required this.alignment,
    this.stars = 0,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isLocked = status == NodeStatus.locked;
    bool isCurrent = status == NodeStatus.current;
    bool isTest = status == NodeStatus.test;
    bool isCompleted = status == NodeStatus.completed;

    // Warna elemen berdasarkan status
    Color pillColor = isLocked ? const Color(0xFFE8E3DA) : isCurrent ? const Color(0xFFC6653B) : isTest ? const Color(0xFFF9F6F0) : const Color(0xFF7A7571);
    Color pillTextColor = isLocked ? const Color(0xFF8C8A87) : isTest ? const Color(0xFF4B4B4B) : Colors.white;
    Color nodeColor = isLocked ? const Color(0xFFE8E3DA) : isCurrent ? const Color(0xFFC6653B) : isTest ? const Color(0xFFF9F6F0) : const Color(0xFF7A7571);
    Color iconColor = isLocked ? const Color(0xFF8C8A87) : isCurrent ? Colors.white : isTest ? const Color(0xFFC6653B) : Colors.white;

    // Menentukan Ikon
    IconData nodeIcon = customIcon ?? (isLocked ? Icons.lock : isCurrent ? Icons.back_hand : isTest ? Icons.emoji_events : Icons.check);

    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // LABEL PILL
          if (!isTest) // Unit Test labelnya ada di dalam lingkaran
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(color: pillTextColor, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.5),
              ),
            ),

          const SizedBox(height: 8),

          // LINGKARAN TOMBOL
          Stack(
            alignment: Alignment.center,
            children: [
              // Cincin Progres untuk status Current
              if (isCurrent)
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    value: 0.65, // Persentase progres
                    strokeWidth: 6,
                    backgroundColor: const Color(0xFFC6653B).withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC6653B)),
                  ),
                ),

              // Cincin putih luar (border pelindung)
              Container(
                width: isTest ? 100 : 75,
                height: isTest ? 100 : 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF9F6F0), // Warna background aplikasi
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Center(
                  // Lingkaran dalam berisi warna dan ikon
                  child: Container(
                    width: isTest ? 90 : 55,
                    height: isTest ? 90 : 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: nodeColor,
                    ),
                    child: isTest
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(nodeIcon, color: iconColor, size: 28),
                        const SizedBox(height: 4),
                        const Text("Unit Test", style: TextStyle(color: Color(0xFF4B4B4B), fontWeight: FontWeight.bold, fontSize: 12)),
                        const Text("30 min", style: TextStyle(color: Color(0xFF8C8A87), fontSize: 10)),
                      ],
                    )
                        : Icon(nodeIcon, color: iconColor, size: 28),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // BINTANG (Tidak muncul di Unit Test)
          if (!isTest)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                bool isStarFilled = index < stars;
                return Icon(
                  isStarFilled ? Icons.star : Icons.star,
                  color: isStarFilled ? const Color(0xFFC6653B) : const Color(0xFFDCD6CC),
                  size: 16,
                );
              }),
            ),
        ],
      ),
    );
  }
}