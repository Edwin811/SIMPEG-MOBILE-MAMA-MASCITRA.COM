import 'package:flutter/material.dart';
import 'package:mama/Widget/BottomNavbar.dart';
import 'package:mama/Screen/Notification_screen.dart';
import 'package:mama/Screen/Home_screen.dart';
import 'package:mama/Screen/Petunjuk_screen.dart';
import 'package:mama/Screen/DataAkun_screen.dart'; // Tambahkan import ini

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: Container(
              width: screenWidth,
              height: 220,
              color: const Color(0xFFD35400),
              child: Stack(
                children: [
                  Image.asset(
                    'lib/assets/login_pattern.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: 220,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: const Color(0xFFD35400));
                    },
                  ),
                  Positioned(
                    top: 48,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 54,
                            color: Color(0xFFD35400),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Doraemon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Pegawai Tetap',
                            style: TextStyle(
                              color: Color(0xFFD35400),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
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
                children: [
                  ListTile(
                    title: const Text(
                      'Data Akun',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Detail you're data account"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color(0xFFD35400),
                    ),
                    onTap: () {
                      // Navigasi ke halaman Data Akun
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DataAkunScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Petunjuk',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('instructions App Kepegawaian'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color(0xFFD35400),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PetunjukScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Tambahkan aksi logout di sini
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD35400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              elevation: 0,
            ),
            child: const Text(
              'Keluar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(username: 'edwin@gmail.com'),
              ),
            );
          }
        },
      ),
    );
  }
}
