import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- 1. AVATAR SECTION ---
            _buildAvatarSection(),
            const SizedBox(height: 16),

            // User Info
            const Text(
              "Ahmad Dzaki", // Nama disesuaikan
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Bandung, West Java", // Lokasi disesuaikan
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),

            // --- 2. STATS ROW ---
            _buildStatsRow(),
            const SizedBox(height: 40),

            // --- 3. ACHIEVEMENTS SECTION ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildAchievementsGrid(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET HELPER
  // ==========================================

  Widget _buildAvatarSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Border Oranye Luar
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Color(0xFFCC6633),
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=200', // Placeholder gambar profil
            ),
          ),
        ),
        // Tombol Edit (Pensil)
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.edit,
            size: 16,
            color: Color(0xFFCC6633),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCircle(value: "12,500", label: "TOTAL XP"),
        _buildStatCircle(value: "32", label: "DAYS STREAK", icon: Icons.calendar_today_outlined),
        _buildStatCircle(value: "450/700", label: "WORDS (N5)", icon: Icons.school_outlined),
      ],
    );
  }

  Widget _buildStatCircle({required String value, required String label, IconData? icon}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: const Color(0xFF8C8A87)),
            const SizedBox(height: 4),
          ],
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85, // Mengatur proporsi tinggi vs lebar kartu
      children: [
        _buildAchievementCard(
          iconText: "あ",
          iconColor: const Color(0xFFEBE5DB), // Krem gelap
          title: "HIRAGANA\nMASTER",
          subtitle: "All characters\nunlocked.",
        ),
        _buildAchievementCard(
          iconText: "ア",
          iconColor: const Color(0xFFF0DEC9), // Oranye sangat muda
          title: "KATAKANA\nEXPLORER",
          subtitle: "Journey begun.",
        ),
        _buildAchievementCard(
          iconText: "•", // Dummy untuk solid circle
          iconColor: const Color(0xFFCC6633), // Oranye solid
          title: "N5 BEGINNER",
          subtitle: "First steps taken.",
          isSolidIcon: true,
        ),
        _buildAchievementCard(
          iconText: "日",
          iconColor: const Color(0xFFE8E3DA), // Abu-abu
          title: "KANJI N5\nPIONEER",
          subtitle: "Learn 100 Kanji.",
          isLocked: true,
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String iconText,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool isSolidIcon = false,
    bool isLocked = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32), // Sudut sangat membulat
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ikon Pencapaian
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    isSolidIcon ? "" : iconText,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey : Colors.black87,
                    ),
                  ),
                ),
              ),
              // Tambahan gembok kecil jika terkunci
              if (isLocked)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2EFE9),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.lock, size: 10, color: Colors.grey),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Judul Pencapaian
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isLocked ? Colors.grey : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Subjudul Pencapaian
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: isLocked ? Colors.grey.shade400 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}