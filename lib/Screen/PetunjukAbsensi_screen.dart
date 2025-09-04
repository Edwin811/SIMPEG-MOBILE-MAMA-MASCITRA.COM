import 'package:flutter/material.dart';

class PetunjukAbsensiScreen extends StatelessWidget {
  const PetunjukAbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header dengan tombol back yang jelas
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
                        SizedBox(
                          width: screenWidth - 100,
                          child: const Text(
                            'Cara Absensi Jam Masuk & Jam Pulang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

          // Content tetap sama seperti sebelumnya...
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _StepCard(
                  stepNumber: '1',
                  title: 'Buka Menu Jam Masuk/Pulang',
                  description:
                      'Pilih menu "Jam Masuk" atau "Jam Pulang" di halaman beranda aplikasi. Pastikan Anda memilih menu yang sesuai dengan waktu absensi.',
                  icon: Icons.access_time,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '2',
                  title: 'Aktifkan Lokasi GPS',
                  description:
                      'Tekan tombol "Lokasi" untuk mengaktifkan GPS dan mendapatkan koordinat lokasi Anda saat ini. Pastikan GPS dalam keadaan aktif dan izin lokasi telah diberikan.',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '3',
                  title: 'Ambil Foto Selfie',
                  description:
                      'Setelah lokasi berhasil didapat, tekan "Selanjutnya" lalu ambil foto selfie untuk absensi. Pastikan wajah terlihat jelas dan pencahayaan cukup.',
                  icon: Icons.camera_alt,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '4',
                  title: 'Submit Absensi',
                  description:
                      'Periksa foto yang telah diambil, jika sudah sesuai tekan tombol "Submit" untuk menyelesaikan absensi. Data akan tersimpan dengan timestamp otomatis.',
                  icon: Icons.check_circle,
                ),
                const SizedBox(height: 24),

                // Tips Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDEEE3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD35400).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Color(0xFFD35400),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Tips Absensi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD35400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Pastikan berada di area kantor saat absensi\n'
                        '• Ambil foto dengan pencahayaan yang baik\n'
                        '• Periksa koneksi internet sebelum submit\n'
                        '• Jam masuk: maksimal pukul 08:00 WIB\n'
                        '• Jam pulang: minimal pukul 17:00 WIB',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFD35400),
                          height: 1.5,
                        ),
                      ),
                    ],
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

// Widget untuk card langkah-langkah
class _StepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String description;
  final IconData? icon;

  const _StepCard({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number circle
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFD35400),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Color(0xFFD35400), size: 20),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
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
