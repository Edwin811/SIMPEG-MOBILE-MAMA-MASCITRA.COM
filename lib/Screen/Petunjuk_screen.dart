import 'package:flutter/material.dart';
import 'PetunjukAbsensi_screen.dart';
import 'PetunjukKegiatan_screen.dart';
import 'PetunjukCuti_screen.dart';

class PetunjukScreen extends StatelessWidget {
  const PetunjukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header dengan pattern oranye
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
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: const Color(0xFFD35400));
                    },
                  ),
                  Positioned(
                    left: 16,
                    top: 48,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Petunjuk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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

          // List menu petunjuk
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _PetunjukMenuItem(
                  title: 'Cara Absensi Jam Masuk & Jam Pulang',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PetunjukAbsensiScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _PetunjukMenuItem(
                  title: 'Cara Mengisi Kegiatan Harian',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PetunjukKegiatanScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _PetunjukMenuItem(
                  title: 'Cara Mengajukan Cuti',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PetunjukCutiScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk item menu petunjuk
class _PetunjukMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _PetunjukMenuItem({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFD35400),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
