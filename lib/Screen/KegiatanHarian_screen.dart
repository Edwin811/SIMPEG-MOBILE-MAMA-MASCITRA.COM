import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mama/Screen/SuccessKegiatanHarian_screen.dart';
import 'package:mama/Screen/RiwayatKegiatanHarian_screen.dart'; // Tambahkan import ini

class KegiatanHarianScreen extends StatefulWidget {
  const KegiatanHarianScreen({super.key});

  @override
  State<KegiatanHarianScreen> createState() => _KegiatanHarianScreenState();
}

class _KegiatanHarianScreenState extends State<KegiatanHarianScreen> {
  DateTime? selectedDate;
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _realisasiController = TextEditingController();

  void _showDatePicker() async {
    DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        DateTime selected = DateTime.now();
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color(0xFFD35400), width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      focusedDay: selected,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      selectedDayPredicate: (day) => day == selected,
                      onDaySelected: (day, _) {
                        setModalState(() => selected = day);
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFFD35400).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFD35400),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Color(0xFFD35400),
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Color(0xFFD35400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, selected);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD35400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Pilih Tanggal',
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
            );
          },
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitKegiatan() {
    // Validasi tanggal
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal kegiatan terlebih dahulu'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    // Validasi field kosong
    if (_deskripsiController.text.trim().isEmpty ||
        _targetController.text.trim().isEmpty ||
        _realisasiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    // Jika semua validasi lolos, navigasi ke success page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuccessKegiatanHarianScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header dengan icon history
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
                          'Kegiatan Harian',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // History Icon di pojok kanan
                  Positioned(
                    right: 16,
                    top: 50,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RiwayatKegiatanHarianScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
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
                  // Tanggal Kegiatan
                  const Text(
                    'Tanggal Kegiatan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD35400),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pilih Tanggal',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  selectedDate == null
                                      ? 'Tidak Ada Data'
                                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFD35400),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Deskripsi Kegiatan
                  const Text(
                    'Deskripsi Kegiatan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _deskripsiController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Target Kegiatan
                  const Text(
                    'Target Kegiatan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _targetController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Realisasi Kegiatan
                  const Text(
                    'Realisasi Kegiatan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _realisasiController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Send Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _submitKegiatan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD35400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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

  @override
  void dispose() {
    _deskripsiController.dispose();
    _targetController.dispose();
    _realisasiController.dispose();
    super.dispose();
  }
}
