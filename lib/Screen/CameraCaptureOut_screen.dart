import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:mama/Screen/SuccessSubmit_screen.dart'; // Import halaman sukses

class CameraCaptureOutScreen extends StatefulWidget {
  const CameraCaptureOutScreen({super.key});

  @override
  State<CameraCaptureOutScreen> createState() => _CameraCaptureOutScreenState();
}

class _CameraCaptureOutScreenState extends State<CameraCaptureOutScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _errorMessage;
  CameraDevice _selectedCamera = CameraDevice.rear; // Default kamera belakang

  Future<void> _takePicture() async {
    print('🟡 [Camera] _takePicture() started with camera: $_selectedCamera');

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      print('🟡 [Camera] Checking camera availability...');

      // Check camera availability first
      final bool isAvailable = await _picker.supportsImageSource(
        ImageSource.camera,
      );

      print('🟡 [Camera] Camera availability: $isAvailable');

      if (!isAvailable) {
        print('🔴 [Camera] Camera not available');
        setState(() {
          _errorMessage = 'Kamera tidak tersedia di perangkat ini';
          _isLoading = false;
        });
        return;
      }

      print('🟡 [Camera] Starting image picker with camera: $_selectedCamera');

      // Add timeout and better error handling
      final XFile? photo = await _picker
          .pickImage(
            source: ImageSource.camera,
            imageQuality: 85,
            preferredCameraDevice:
                _selectedCamera, // Gunakan kamera yang dipilih
            maxWidth: 1920,
            maxHeight: 1080,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException(
                'Timeout saat membuka kamera',
                const Duration(seconds: 30),
              );
            },
          );

      print('🟡 [Camera] Image picker result: ${photo?.path ?? 'null'}');

      if (photo != null) {
        print('🟢 [Camera] Photo captured successfully: ${photo.path}');

        // Check if file exists
        final file = File(photo.path);
        final exists = await file.exists();
        print('🟡 [Camera] File exists: $exists');

        if (exists) {
          final fileSize = await file.length();
          print('🟡 [Camera] File size: $fileSize bytes');
        }

        setState(() {
          _imageFile = file;
          _isLoading = false;
          _errorMessage = null;
        });
      } else {
        print('🟠 [Camera] User cancelled or no photo taken');
        setState(() {
          _isLoading = false;
          _errorMessage = null; // User cancelled, bukan error
        });
      }
    } on PlatformException catch (e) {
      print('🔴 [Camera] PlatformException caught:');
      print('🔴 [Camera] Code: ${e.code}');
      print('🔴 [Camera] Message: ${e.message}');
      print('🔴 [Camera] Details: ${e.details}');

      setState(() {
        _isLoading = false;
        _errorMessage = _getPlatformErrorMessage(e);
      });
    } catch (e, stackTrace) {
      print('🔴 [Camera] Exception caught:');
      print('🔴 [Camera] Error: $e');
      print('🔴 [Camera] Type: ${e.runtimeType}');
      print('🔴 [Camera] Stack trace: $stackTrace');

      setState(() {
        _isLoading = false;
        _errorMessage = _getErrorMessage(e.toString());
      });
    }
  }

  void _switchCamera() {
    setState(() {
      _selectedCamera =
          _selectedCamera == CameraDevice.rear
              ? CameraDevice.front
              : CameraDevice.rear;
    });
    print('🟡 [Camera] Switched to: $_selectedCamera');
  }

  String _getPlatformErrorMessage(PlatformException e) {
    print('🟡 [Camera] Processing platform error: ${e.code} - ${e.message}');

    switch (e.code) {
      case 'camera_access_denied':
        return 'Akses kamera ditolak. Buka Pengaturan > Privacy & Security > Camera > Mama untuk mengizinkan akses kamera.';
      case 'channel-error':
        return 'Terjadi kesalahan sistem kamera.\n\nCoba:\n1. Restart aplikasi\n2. Restart perangkat\n3. Pastikan tidak ada aplikasi lain yang menggunakan kamera';
      case 'photo_access_denied':
        return 'Akses galeri foto ditolak. Berikan izin akses galeri foto di pengaturan.';
      case 'camera_access_restricted':
        return 'Akses kamera dibatasi oleh pengaturan perangkat.';
      default:
        return 'Error kamera: ${e.message ?? e.code}\n\nCoba restart aplikasi atau perangkat.';
    }
  }

  String _getErrorMessage(String error) {
    print('🟡 [Camera] Processing error message: $error');

    if (error.contains('camera_access_denied')) {
      return 'Akses kamera ditolak. Buka Pengaturan > Privacy > Camera > Mama untuk mengizinkan akses kamera.';
    } else if (error.contains('channel-error')) {
      return 'Terjadi kesalahan sistem. Coba restart aplikasi.';
    } else if (error.contains('PlatformException')) {
      return 'Kamera tidak dapat diakses. Pastikan tidak ada aplikasi lain yang menggunakan kamera.';
    } else if (error.contains('permission')) {
      return 'Izin kamera diperlukan. Silakan berikan izin akses kamera.';
    } else if (error.contains('not available')) {
      return 'Kamera tidak tersedia pada perangkat ini.';
    } else if (error.contains('TimeoutException')) {
      return 'Timeout saat membuka kamera. Coba lagi.';
    }
    return 'Error mengambil foto: $error';
  }

  void _retakePicture() {
    print('🟡 [Camera] Retaking picture');
    setState(() {
      _imageFile = null;
      _errorMessage = null;
    });
  }

  void _submitPhoto() {
    if (_imageFile != null) {
      print('🟢 [Camera] Submitting photo and navigating to success page');

      // Navigasi ke halaman sukses untuk checkout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => const SuccessSubmitScreen(
                title: 'Absensi Pulang Telah Berhasil',
                subtitle: 'Selamat Beristirahat',
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
                          'Jam Pulang',
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

          // Camera preview container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD35400), width: 2),
                borderRadius: BorderRadius.circular(18),
                color: Color(0xFFF5F5F5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                    _imageFile != null
                        ? Stack(
                          children: [
                            Image.file(
                              _imageFile!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: _retakePicture,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 64,
                                    color: Color(0xFF989898),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Ambil Foto untuk Absensi',
                                    style: TextStyle(
                                      color: Color(0xFF989898),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _selectedCamera == CameraDevice.rear
                                        ? 'Kamera Belakang'
                                        : 'Kamera Depan',
                                    style: TextStyle(
                                      color: Color(0xFFD35400),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Switch Camera Button
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: _switchCamera,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD35400),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.flip_camera_ios,
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
          ),

          const SizedBox(height: 16),

          // Error message
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Error mengambil foto:',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Button
          if (_imageFile == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _takePicture,
                  icon:
                      _isLoading
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : const Icon(Icons.camera_alt, color: Colors.white),
                  label: Text(
                    _isLoading ? 'Membuka Kamera...' : 'Ambil Foto',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isLoading ? Colors.grey : const Color(0xFFD35400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                ),
              ),
            ),

          // Submit button when image is captured
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _retakePicture,
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        'Ambil Ulang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _submitPhoto,
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD35400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
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
