import 'package:flutter/material.dart';
import 'package:mama/Screen/Home_screen.dart';

class SuccessKegiatanHarianScreen extends StatelessWidget {
  const SuccessKegiatanHarianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Auto navigate back to home after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(username: 'edwin@gmail.com'),
        ),
        (route) => false,
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFD35400),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.check, color: Colors.white, size: 60),
              ),
            ),
            const SizedBox(height: 32),

            // Success Message
            const Text(
              'The Dailies Activities Has Been Sent',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),

            // Optional: Add a manual back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
            ),
          ],
        ),
      ),
    );
  }
}
