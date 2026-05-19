import 'package:flutter/material.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Langsung mengembalikan ScrollView
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "JAPANESE PROFICIENCY",
              style: TextStyle(color: Color(0xFFCC6633), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            const Text(
              "JLPT N5 Full\nMock",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, height: 1.2),
            ),
            const SizedBox(height: 16),
            const Text(
              "Experience the complete standardized test environment. This simulation follows the official JLPT structure and timing to prepare you for success.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 30),

            _buildExamStructureCard(),
            const SizedBox(height: 20),
            _buildOneAttemptCard(),
            const SizedBox(height: 20),
            _buildRequirementNote(),
            const SizedBox(height: 30),
            _buildUnlockButtonSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildExamStructureCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EBE1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.insert_chart_outlined, color: Colors.black87),
              SizedBox(width: 10),
              Text("Exam Structure", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 20),
          _buildStatRow("DURATION", "105", " min"),
          const SizedBox(height: 16),
          _buildStatRow("QUESTIONS", "80", " total"),
          const SizedBox(height: 16),
          _buildStatRow("DIFFICULTY", "N5", " entry"),
          const SizedBox(height: 24),
          _buildSectionTile(Icons.translate, "Vocabulary", "Language Knowledge", "25 Min"),
          const SizedBox(height: 10),
          _buildSectionTile(Icons.menu_book, "Grammar & Reading", "Structure and Comprehension", "50 Min"),
          const SizedBox(height: 10),
          _buildSectionTile(Icons.hearing, "Listening", "Audio Section", "30 Min"),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value, style: const TextStyle(color: Color(0xFFCC6633), fontSize: 24, fontWeight: FontWeight.w600)),
            Text(unit, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTile(IconData icon, String title, String subtitle, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF9F6F0), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFFEBE5DB), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.black87, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildOneAttemptCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFEBE5DB), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1596484552834-6a58f850e0a1?auto=format&fit=crop&q=80&w=400'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("One Attempt Only", style: TextStyle(color: Color(0xFF8B2C2C), fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text("Finish in one sitting. Timer cannot be paused once the listening section begins.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildRequirementNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0DEC9), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFFCC6633), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("REQUIREMENT", style: TextStyle(color: Color(0xFFCC6633), fontSize: 10, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Headphones recommended for the listening portion.", style: TextStyle(color: Colors.black87, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockButtonSection() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB56A3F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Unlock & Start Test", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.rocket_launch, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text("Price: 150 XP or Free with Premium", style: TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    );
  }
}