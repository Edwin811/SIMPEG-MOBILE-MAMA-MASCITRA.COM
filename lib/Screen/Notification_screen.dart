import 'package:flutter/material.dart';
import 'package:mama/Widget/BottomNavbar.dart';
import 'package:mama/Screen/Home_screen.dart';
import 'package:mama/Screen/Profile_screen.dart'; // Tambahkan import ini
import 'package:mama/Screen/DetailNotification_Screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Pattern oranye dengan rounded kanan kiri
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: Container(
              width: screenWidth,
              height: 110,
              color: const Color(0xFFD35400),
              child: Stack(
                children: [
                  Image.asset(
                    'lib/assets/login_pattern.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: 110,
                  ),
                  Positioned(
                    left: 24,
                    bottom: 24,
                    child: const Text(
                      'Pemberitahuan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // List Notifikasi
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _NotificationCard(
                  title:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  desc:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam euismod felis vel sapien tristique, vel venenatis sapien lacinia. Vestibulum et egestas urna. Mauris sed augue luctus, interdum nisl in, lobortis',
                  date: '22 Juli 2025',
                ),
                const SizedBox(height: 20),
                _NotificationCard(
                  title:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  desc:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam euismod felis vel sapien tristique, vel venenatis sapien lacinia. Vestibulum et egestas urna. Mauris sed augue luctus, interdum nisl in, lobortis',
                  date: '22 Juli 2025',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: 0, // 0 = Notifikasi
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(username: 'edwin@gmail.com'),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  const _NotificationCard({
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailNotificationScreen(title: title, desc: desc),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(color: Color(0xFF989898), fontSize: 13),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF989898),
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFD35400),
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget bottom navigation
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    );
  }
}
