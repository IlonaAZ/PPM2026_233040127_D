import 'package:flutter/material.dart';
import '../../widgets/path_node.dart';
import 'widget_learn.dart';
import 'screen_exercise.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const UnitHeaderCard(),
            const SizedBox(height: 50),

            // Level 1: Selesai
            _buildClickableNode(
              context: context, // Mengirimkan context ke fungsi
              title: "Basics 1",
              status: NodeStatus.completed,
              alignment: Alignment.center,
            ),
            _buildConnector(),

            // Level 2: Sedang Dikerjakan (Zig-Zag Kiri)
            _buildClickableNode(
              context: context,
              title: "Greetings",
              status: NodeStatus.current,
              alignment: const Alignment(-0.5, 0),
            ),
            _buildConnector(),

            // Level 3: Terkunci (Zig-Zag Kanan)
            _buildClickableNode(
              context: context,
              title: "Basics 2",
              status: NodeStatus.locked,
              alignment: const Alignment(0.5, 0),
            ),
            _buildConnector(),

            // Level 4: Terkunci (Kembali ke Tengah)
            _buildClickableNode(
              context: context,
              title: "Numbers",
              status: NodeStatus.locked,
              alignment: Alignment.center,
            ),
            _buildConnector(),

            // Level 5: Terkunci (Zig-Zag Kiri)
            _buildClickableNode(
              context: context,
              title: "Family",
              status: NodeStatus.locked,
              alignment: const Alignment(-0.6, 0),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Garis penghubung yang simpel ala Duolingo
  Widget _buildConnector() {
    return Container(
      width: 10,
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // WIDGET HELPER: Ditambahkan parameter BuildContext
  Widget _buildClickableNode({
    required BuildContext context,
    required String title,
    required NodeStatus status,
    required Alignment alignment,
  }) {
    return GestureDetector(
      onTap: status == NodeStatus.locked
          ? null // Jika terkunci, tidak bisa diklik
          : () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExerciseScreen()),
        );
      },
      child: PathNode(
        title: title,
        status: status,
        alignment: alignment,
      ),
    );
  }
}