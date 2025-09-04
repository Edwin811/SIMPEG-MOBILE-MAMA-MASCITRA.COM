import 'package:flutter/material.dart';

class PetunjukCutiScreen extends StatelessWidget {
  const PetunjukCutiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header dengan tombol back yang lebih jelas
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
                    top: 45, // Adjusted position
                    child: Row(
                      children: [
                        // Tombol back dengan area tap yang lebih besar
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
                              onTap: () {
                                print('Back button tapped'); // Debug
                                Navigator.of(context).pop();
                              },
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
                        // Title dengan lebar yang disesuaikan
                        SizedBox(
                          width:
                              screenWidth -
                              100, // Reserve space for back button
                          child: const Text(
                            'Cara Mengajukan Cuti',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _StepCard(
                  stepNumber: '1',
                  title: 'Akses Menu Cuti',
                  description:
                      'Pilih menu "Cuti" yang tersedia di halaman beranda aplikasi. Pastikan Anda memiliki hak akses untuk mengajukan cuti.',
                  icon: Icons.event_available,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '2',
                  title: 'Pilih Jenis Cuti',
                  description:
                      'Tentukan jenis cuti yang akan diajukan seperti cuti tahunan, cuti sakit, cuti melahirkan, atau cuti khusus lainnya.',
                  icon: Icons.category,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '3',
                  title: 'Tentukan Tanggal',
                  description:
                      'Pilih tanggal mulai dan berakhirnya cuti yang akan diambil. Sistem akan otomatis menghitung jumlah hari kerja.',
                  icon: Icons.date_range,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '4',
                  title: 'Isi Alasan Cuti',
                  description:
                      'Tuliskan alasan atau keterangan lengkap mengapa Anda mengajukan cuti. Berikan penjelasan yang jelas dan sesuai kebijakan.',
                  icon: Icons.description,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '5',
                  title: 'Upload Dokumen Pendukung',
                  description:
                      'Jika diperlukan, upload dokumen pendukung seperti surat dokter untuk cuti sakit atau undangan untuk cuti khusus.',
                  icon: Icons.attach_file,
                ),
                const SizedBox(height: 16),
                _StepCard(
                  stepNumber: '6',
                  title: 'Ajukan Permohonan',
                  description:
                      'Periksa semua data yang telah diisi, lalu tekan "Ajukan" untuk mengirim permohonan cuti ke atasan untuk persetujuan.',
                  icon: Icons.send,
                ),
                const SizedBox(height: 24),

                // Jenis Cuti Section
                Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Color(0xFFD35400), size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Jenis Cuti Yang Tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Cuti Tahunan (12 hari/tahun)\n'
                        '• Cuti Sakit (perlu surat dokter)\n'
                        '• Cuti Melahirkan (3 bulan)\n'
                        '• Cuti Menikah (3 hari)\n'
                        '• Cuti Khitanan Anak (2 hari)\n'
                        '• Cuti Kematian Keluarga (3 hari)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

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
                            'Tips Pengajuan Cuti',
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
                        '• Ajukan cuti minimal 3 hari sebelumnya\n'
                        '• Pastikan sisa cuti mencukupi\n'
                        '• Koordinasi dengan tim sebelum cuti\n'
                        '• Upload dokumen jika diperlukan\n'
                        '• Cek status persetujuan secara berkala',
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
