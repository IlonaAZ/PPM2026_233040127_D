import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int? selectedOption; // Menyimpan indeks pilihan yang diklik

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0), // Background cream elegan
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // --- TOP BAR ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Color(0xFF333333), size: 28),
                  ),
                  const Text(
                    "MIRAIKU",
                    style: TextStyle(
                      color: Color(0xFFCC6633), // Warna oranye utama
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: 1.5,
                      fontFamily: 'Serif', // Menggunakan font serif
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4E5D7), // Latar belakang pil nyawa
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Text("5", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFCC6633), fontSize: 16)),
                        SizedBox(width: 4),
                        Icon(Icons.favorite_border, color: Color(0xFFCC6633), size: 18),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- PROGRESS BAR ---
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("JLPT N5 VOCABULARY", style: TextStyle(color: Color(0xFF8C8A87), fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  Text("6/10", style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E3DA), // Jalur abu-abu
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 6,
                    width: MediaQuery.of(context).size.width * 0.6, // Progress 60%
                    decoration: BoxDecoration(
                      color: const Color(0xFFCC6633), // Progress oranye
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // --- QUESTION TEXT ---
              const Center(
                child: Text(
                  "How do you read this word?",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Color(0xFF4B4B4B)),
                ),
              ),
              const SizedBox(height: 24),

              // --- MAIN CARD (Teks Jepang Besar) ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEBE1), // Cream sedikit gelap
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE8E3DA), width: 1),
                ),
                child: const Center(
                  child: Text(
                    "ねこ",
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- OPTIONS LIST ---
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildOption(0, "A", "ねこ", "NEKO"),
                    _buildOption(1, "B", "いぬ", "INU"),
                    _buildOption(2, "C", "とら", "TORA"),
                    _buildOption(3, "D", "うま", "UMA"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET HELPER: Membuat daftar pilihan ganda
  Widget _buildOption(int index, String code, String text, String romaji) {
    bool isSelected = selectedOption == index;

    // Logika warna berdasarkan status klik
    Color borderColor = isSelected ? const Color(0xFFCC6633) : const Color(0xFFE8E3DA);
    Color bgColor = isSelected ? const Color(0xFFF6E7DC) : Colors.white;
    Color letterBoxColor = isSelected ? const Color(0xFFCC6633) : const Color(0xFFE8E3DA);
    Color letterTextColor = isSelected ? Colors.white : const Color(0xFF4B4B4B);

    return GestureDetector(
      onTap: () => setState(() => selectedOption = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            // Kotak huruf A, B, C, D
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: letterBoxColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  code,
                  style: TextStyle(color: letterTextColor, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Teks Jepang & Romaji
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                const SizedBox(height: 2),
                Text(romaji, style: const TextStyle(fontSize: 12, color: Color(0xFF8C8A87), letterSpacing: 1)),
              ],
            ),
            const Spacer(),

            // Ikon centang (Hanya muncul jika dipilih)
            if (isSelected)
              const Icon(Icons.check_circle_outline, color: Color(0xFFCC6633), size: 28),
          ],
        ),
      ),
    );
  }
}