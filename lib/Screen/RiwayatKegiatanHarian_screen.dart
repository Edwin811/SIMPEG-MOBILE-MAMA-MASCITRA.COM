import 'package:flutter/material.dart';
import 'package:mama/Screen/SelectedDate_screen.dart';

class RiwayatKegiatanHarianScreen extends StatelessWidget {
  const RiwayatKegiatanHarianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header
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
                    top: 45,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => Navigator.of(context).pop(),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Riwayat Kegiatan Harian',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
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
          const SizedBox(height: 16),

          // Content dengan history cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                140,
              ), // Padding bottom untuk filter
              children: [
                _ActivityHistoryCard(
                  date: '23 July 2025',
                  deskripsi: 'Lorem ipsum dolor sit amet',
                  target:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam euismod felis vel sapien tristique, vel venenatis sapien lacinia. Vestibulum et egestas urna. Mauris sed augue luctus, interdum nisl in, lobortis nulla.',
                  realisasi: 'Lorem ipsum dolor sit amet',
                ),
                const SizedBox(height: 16),
                // Tambahkan lebih banyak history cards jika diperlukan
              ],
            ),
          ),
        ],
      ),

      // Bottom Filter Sheet
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Absensi',
                style: TextStyle(
                  color: Color(0xFFD35400),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),

              // Date Selector
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectedDateScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD35400),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Pilih Tanggal',
                                style: TextStyle(
                                  color: Color(0xFFD35400),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Tidak Ada Data',
                                style: TextStyle(
                                  color: Color(0xFF989898),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
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
              ),
              const SizedBox(height: 16),

              // Search Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementasi logic pencarian
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur pencarian akan segera tersedia'),
                        backgroundColor: Color(0xFFD35400),
                      ),
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
                    'Cari',
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

// Widget untuk card history kegiatan
class _ActivityHistoryCard extends StatelessWidget {
  final String date;
  final String deskripsi;
  final String target;
  final String realisasi;

  const _ActivityHistoryCard({
    required this.date,
    required this.deskripsi,
    required this.target,
    required this.realisasi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header tanggal
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD35400),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Deskripsi Kegiatan
                const Text(
                  'Deskripsi Kegiatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),

                // Divider
                Container(height: 1, color: const Color(0xFFF0F0F0)),
                const SizedBox(height: 12),

                // Target Kegiatan
                const Text(
                  'Target Kegiatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  target,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),

                // Divider
                Container(height: 1, color: const Color(0xFFF0F0F0)),
                const SizedBox(height: 12),

                // Realisasi Kegiatan
                const Text(
                  'Realisasi Kegiatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  realisasi,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
