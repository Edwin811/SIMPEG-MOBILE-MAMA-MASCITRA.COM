import 'package:flutter/material.dart';
import 'package:mama/Screen/SelectedDate_screen.dart';

class RiwayatCutiScreen extends StatefulWidget {
  const RiwayatCutiScreen({super.key});

  @override
  State<RiwayatCutiScreen> createState() => _RiwayatCutiScreenState();
}

class _RiwayatCutiScreenState extends State<RiwayatCutiScreen> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  void _navigateToDatePicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SelectedDateScreen()),
    );

    // Menerima hasil dari SelectedDateScreen
    if (result != null && result is Map<String, DateTime?>) {
      setState(() {
        _selectedStartDate = result['startDate'];
        _selectedEndDate = result['endDate'];
      });
    }
  }

  String _getDateRangeText() {
    if (_selectedStartDate != null && _selectedEndDate != null) {
      return '${_selectedStartDate!.day}/${_selectedStartDate!.month}/${_selectedStartDate!.year} - ${_selectedEndDate!.day}/${_selectedEndDate!.month}/${_selectedEndDate!.year}';
    } else if (_selectedStartDate != null) {
      return '${_selectedStartDate!.day}/${_selectedStartDate!.month}/${_selectedStartDate!.year}';
    }
    return 'Tidak Ada Data';
  }

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
                          'Riwayat Cuti',
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
          const SizedBox(height: 16),

          // Filter Absensi Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
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
                  GestureDetector(
                    onTap: _navigateToDatePicker,
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
                                children: [
                                  const Text(
                                    'Pilih Tanggal',
                                    style: TextStyle(
                                      color: Color(0xFFD35400),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    _getDateRangeText(),
                                    style: TextStyle(
                                      color:
                                          _selectedStartDate != null
                                              ? Colors.black
                                              : Color(0xFF989898),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Content dengan history cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
              children: [
                _CutiHistoryCard(
                  dateRange: '23 July 2025-24 July 2025',
                  status: 'Menunggu',
                  jenisCuti: 'Lorem ipsum dolor sit amet',
                  alasanCuti:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam euismod felis vel sapien tristique, vel venenatis sapien lacinia. Vestibulum et egestas urna. Mauris sed augue luctus, interdum nisl in, lobortis nulla.',
                  catatanCuti: 'Lorem ipsum dolor sit amet',
                  alamatSelama:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam euismod felis vel sapien tristique, vel venenatis sapien lacinia. Vestibulum et egestas urna. Mauris sed augue luctus, interdum nisl in, lobortis nulla.',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),

      // Bottom Button
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
              'Tambah Pengajuan Cuti',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk card history cuti
class _CutiHistoryCard extends StatelessWidget {
  final String dateRange;
  final String status;
  final String jenisCuti;
  final String alasanCuti;
  final String catatanCuti;
  final String alamatSelama;

  const _CutiHistoryCard({
    required this.dateRange,
    required this.status,
    required this.jenisCuti,
    required this.alasanCuti,
    required this.catatanCuti,
    required this.alamatSelama,
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
            child: Text(
              dateRange,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Pengajuan
                const Text(
                  'Status Pengajuan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDivider(),

                // Jenis Cuti
                const Text(
                  'Jenis Cuti',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  jenisCuti,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDivider(),

                // Alasan Cuti
                const Text(
                  'Alasan Cuti',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alasanCuti,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDivider(),

                // Catatan Cuti (Opsional)
                const Text(
                  'Catatan Cuti (Opsional)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  catatanCuti,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDivider(),

                // Alamat Selama Menjalankan Cuti
                const Text(
                  'Alamat Selama Menjalankan Cuti',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alamatSelama,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
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

  Widget _buildDivider() {
    return Container(height: 1, color: const Color(0xFFF0F0F0));
  }
}
