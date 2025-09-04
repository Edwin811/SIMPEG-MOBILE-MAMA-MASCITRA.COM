import 'package:flutter/material.dart';
import 'package:mama/Screen/Home_screen.dart';

class SuccessSubmitScreen extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessSubmitScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  // Function to get current time in WIB (UTC+7)
  String _getCurrentTimeWIB() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 7));
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFD35400),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD35400).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 60),
              ),

              const SizedBox(height: 40),

              // Time Display - Real Time WIB
              Text(
                _getCurrentTimeWIB(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD35400),
                ),
              ),

              const SizedBox(height: 16),

              // Success Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Color(0xFF989898)),
              ),

              const SizedBox(height: 60),

              // Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Kembali ke halaman home dan hapus semua halaman sebelumnya
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                const HomeScreen(username: 'edwin@gmail.com'),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD35400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
