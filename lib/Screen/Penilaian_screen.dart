import 'package:flutter/material.dart';

class PenilaianScreen extends StatefulWidget {
  const PenilaianScreen({super.key});

  @override
  State<PenilaianScreen> createState() => _PenilaianScreenState();
}

class _PenilaianScreenState extends State<PenilaianScreen> {
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
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Penilaian',
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  Container(
                    width: double.infinity,
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
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD35400).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.assessment,
                                color: Color(0xFFD35400),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Penilaian Kinerja Karyawan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Periode Penilaian: Januari - Desember 2025',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Status: Belum Dinilai',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFD35400),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Kriteria Penilaian
                  const Text(
                    'Kriteria Penilaian',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _KriteriaPenilaianCard(
                    title: 'Kedisiplinan',
                    description:
                        'Penilaian terhadap ketepatan waktu dan kepatuhan terhadap peraturan',
                    score: null,
                    icon: Icons.schedule,
                  ),
                  const SizedBox(height: 12),

                  _KriteriaPenilaianCard(
                    title: 'Kualitas Kerja',
                    description:
                        'Penilaian terhadap kualitas hasil pekerjaan yang diselesaikan',
                    score: null,
                    icon: Icons.star,
                  ),
                  const SizedBox(height: 12),

                  _KriteriaPenilaianCard(
                    title: 'Kerjasama Tim',
                    description:
                        'Penilaian terhadap kemampuan bekerjasama dengan rekan kerja',
                    score: null,
                    icon: Icons.group,
                  ),
                  const SizedBox(height: 12),

                  _KriteriaPenilaianCard(
                    title: 'Inisiatif',
                    description:
                        'Penilaian terhadap kemampuan mengambil inisiatif dalam bekerja',
                    score: null,
                    icon: Icons.lightbulb,
                  ),
                  const SizedBox(height: 12),

                  _KriteriaPenilaianCard(
                    title: 'Komunikasi',
                    description:
                        'Penilaian terhadap kemampuan berkomunikasi dengan baik',
                    score: null,
                    icon: Icons.chat,
                  ),
                  const SizedBox(height: 24),

                  // Info Penilaian
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDEEE3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD35400).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFFD35400),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Informasi Penilaian',
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
                          '• Penilaian dilakukan oleh atasan langsung\n'
                          '• Periode penilaian setiap 6 bulan sekali\n'
                          '• Skala penilaian: 1-5 (1=Kurang, 5=Sangat Baik)\n'
                          '• Hasil penilaian akan mempengaruhi evaluasi kinerja',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Status
                  Container(
                    width: double.infinity,
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
                      children: [
                        const Icon(
                          Icons.pending_actions,
                          color: Color(0xFFD35400),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Menunggu Penilaian',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Penilaian akan dilakukan oleh atasan langsung pada periode yang telah ditentukan.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KriteriaPenilaianCard extends StatelessWidget {
  final String title;
  final String description;
  final int? score;
  final IconData icon;

  const _KriteriaPenilaianCard({
    required this.title,
    required this.description,
    this.score,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFD35400).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFD35400), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          if (score != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD35400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                score.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '-',
                style: TextStyle(
                  color: Color(0xFF989898),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
