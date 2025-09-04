import 'package:flutter/material.dart';
import 'package:mama/Screen/PilihTanggal_screen.dart';
import 'package:mama/Screen/RiwayatCuti_screen.dart';
import 'package:mama/Screen/SuccessCuti_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class CutiScreen extends StatefulWidget {
  const CutiScreen({super.key});

  @override
  State<CutiScreen> createState() => _CutiScreenState();
}

class _CutiScreenState extends State<CutiScreen> {
  DateTime? _tanggalMulai;
  DateTime? _tanggalBerakhir;
  String? _selectedJenisCuti;
  final TextEditingController _alasanController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  File? _uploadedFile;

  final List<String> _jenisCutiList = [
    'Cuti Izin Keperluan Khusus',
    'Cuti Sakit',
    'Cuti Tanpa Dibayar',
    'Cuti Bersalin / Mendampingi Persalinan',
    'Cuti Tahunan (Tahun Kontrak)',
  ];

  Future<void> _selectDateRange() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PilihTanggalScreen()),
    );

    if (result != null && result is Map<String, DateTime?>) {
      setState(() {
        _tanggalMulai = result['startDate'];
        _tanggalBerakhir = result['endDate'];
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);

        // Check file size (1MB = 1024 * 1024 bytes)
        final fileSize = await file.length();
        if (fileSize > 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File terlalu besar. Maksimal 1 MB'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          _uploadedFile = file;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error memilih file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _submitCuti() {
    if (_tanggalMulai == null || _tanggalBerakhir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal cuti terlebih dahulu'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    if (_selectedJenisCuti == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jenis cuti'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    if (_alasanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi alasan cuti'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    if (_alamatController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi alamat selama menjalankan cuti'),
          backgroundColor: Color(0xFFD35400),
        ),
      );
      return;
    }

    // Navigate to success page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuccessCutiScreen()),
    );
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
                  // Pattern background
                  Container(
                    width: screenWidth,
                    height: 110,
                    color: const Color(0xFFD35400),
                  ),
                  // Back button and title
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
                          'Cuti',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // History Icon
                  Positioned(
                    right: 16,
                    top: 50,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RiwayatCutiScreen(),
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
                  // Tanggal Cuti
                  const Text(
                    'Tanggal Cuti :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _selectDateRange,
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
                                    color: Color(0xFFD35400),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  _tanggalMulai != null &&
                                          _tanggalBerakhir != null
                                      ? '${_tanggalMulai!.day}/${_tanggalMulai!.month}/${_tanggalMulai!.year} - ${_tanggalBerakhir!.day}/${_tanggalBerakhir!.month}/${_tanggalBerakhir!.year}'
                                      : 'Tidak Ada Data',
                                  style: TextStyle(
                                    color: Color(0xFF989898),
                                    fontSize: 12,
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

                  // File Upload
                  GestureDetector(
                    onTap: _pickFile,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFD35400),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
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
                          Icon(
                            Icons.upload_file,
                            color: Color(0xFFD35400),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _uploadedFile != null
                                ? 'File: ${_uploadedFile!.path.split('/').last}'
                                : 'Upload File (Optional)',
                            style: TextStyle(
                              color: Color(0xFFD35400),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'PDF, JPG, PNG (Max 1MB)',
                            style: TextStyle(
                              color: Color(0xFF989898),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Jenis Cuti - PERBAIKAN UTAMA DI SINI
                  const Text(
                    'Jenis Cuti',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
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
                    child: DropdownButtonFormField<String>(
                      value: _selectedJenisCuti,
                      isExpanded: true, // Tambahkan ini
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintText: 'Pilih Jenis Cuti',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      items:
                          _jenisCutiList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Tambahkan ini
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedJenisCuti = newValue;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFD35400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Alasan Cuti
                  const Text(
                    'Alasan Cuti',
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
                      controller: _alasanController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Catatan Cuti (Opsional)
                  const Text(
                    'Catatan Cuti (Opsional)',
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
                      controller: _catatanController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Alamat Selama Menjalankan Cuti
                  const Text(
                    'Alamat Selama Menjalankan Cuti',
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
                      controller: _alamatController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Write Here',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Send Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _submitCuti,
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
                        'Kirim',
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
    _alasanController.dispose();
    _catatanController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
