import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F0),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, "LEARN", iconData: Icons.menu_book_rounded),
          _buildNavItem(1, "SIMULATION", iconData: Icons.edit_note_rounded),
          _buildNavItem(2, "ALPHABET", textIcon: "あ"), // Menggunakan teks Hiragana
          _buildNavItem(3, "PROFILE", iconData: Icons.account_circle_outlined),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, {IconData? iconData, String? textIcon}) {
    bool isActive = selectedIndex == index;
    Color itemColor = isActive ? Colors.white : const Color(0xFF8C8A87);
    double iconSize = isActive ? 24.0 : 28.0;

    Widget iconWidget;
    if (textIcon != null) {
      iconWidget = Text(
        textIcon,
        style: TextStyle(
          color: itemColor,
          fontSize: iconSize,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      );
    } else {
      iconWidget = Icon(iconData, color: itemColor, size: iconSize);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color(0xFFCC6633).withOpacity(0.2), // Efek ripple orange
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFCC6633) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              const SizedBox(height: 4),
              Text(
                  label,
                  style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF8C8A87),
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w600
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}