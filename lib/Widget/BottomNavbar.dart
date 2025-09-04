import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Lebih lebar ke atas
      padding: const EdgeInsets.only(bottom: 20), // Naikkan lagi
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.notifications_none,
            label: 'Notifikasi',
            selected: selectedIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.home,
            label: 'Beranda',
            selected: selectedIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: selectedIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20), // Naikkan icon lebih atas
          Icon(icon, color: selected ? Color(0xFFD35400) : Color(0xFF989898)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selected ? Color(0xFFD35400) : Color(0xFF989898),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
