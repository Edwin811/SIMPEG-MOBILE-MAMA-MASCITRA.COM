import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mama/Screen/CameraCaptureOut_screen.dart'; // Import camera checkout

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  Position? _currentPosition;
  bool _loading = false;
  MapController? _mapController;
  String? _errorMessage;
  bool _mapReady = false; // Add this flag

  @override
  void initState() {
    super.initState();
    // Initialize dengan delay untuk memastikan widget ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _mapController = MapController();
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    if (_loading) return;
    if (!mounted) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Layanan lokasi tidak aktif. Silakan aktifkan GPS.';
            _loading = false;
          });
        }
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            setState(() {
              _errorMessage = 'Izin lokasi ditolak.';
              _loading = false;
            });
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            _errorMessage =
                'Izin lokasi ditolak permanen. Buka pengaturan untuk mengizinkan.';
            _loading = false;
          });
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          throw Exception('Timeout mendapatkan lokasi. Coba lagi.');
        },
      );

      if (mounted) {
        setState(() {
          _currentPosition = position;
          _loading = false;
          _errorMessage = null;
        });
      }

      // Move map with safety checks and delay
      if (_mapController != null && _mapReady && mounted) {
        try {
          // Add small delay to ensure map is fully rendered
          await Future.delayed(Duration(milliseconds: 300));
          if (mounted && _mapController != null) {
            _mapController!.move(
              LatLng(position.latitude, position.longitude),
              16.0,
            );
          }
        } catch (e) {
          print('Map move error: $e');
          // Don't show error to user for map movement issues
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: ${e.toString()}';
          _loading = false;
        });
      }
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

          // Map Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD35400), width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildMapWidget(),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Loading indicator
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 12),
                  Text('Mendapatkan lokasi...'),
                ],
              ),
            ),

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
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Location info
          if (_currentPosition != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFDEEE3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Color(0xFFD35400)),
                        SizedBox(width: 8),
                        Text(
                          'Lokasi Berhasil Didapat',
                          style: TextStyle(
                            color: Color(0xFFD35400),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}\nLong: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                      style: const TextStyle(
                        color: Color(0xFFD35400),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : _getCurrentLocation,
                    icon:
                        _loading
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
                            : const Icon(Icons.gps_fixed, color: Colors.white),
                    label: Text(
                      _loading ? 'Mencari...' : 'Lokasi',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _loading ? Colors.grey : const Color(0xFFD35400),
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
                  child: ElevatedButton(
                    onPressed:
                        _currentPosition != null
                            ? () {
                              // Navigasi ke halaman kamera checkout
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => const CameraCaptureOutScreen(),
                                ),
                              );
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _currentPosition != null
                              ? const Color(0xFFD35400)
                              : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Selanjutnya',
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
        ],
      ),
    );
  }

  Widget _buildMapWidget() {
    if (_currentPosition == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 48, color: Color(0xFFD35400)),
            SizedBox(height: 8),
            Text(
              'Tekan tombol Lokasi untuk\nmenampilkan peta',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF989898)),
            ),
          ],
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
        initialZoom: 16.0,
        maxZoom: 18.0,
        minZoom: 10.0,
        // Add callback when map is ready
        onMapReady: () {
          if (mounted) {
            setState(() {
              _mapReady = true;
            });
          }
          print('Map is ready!');
        },
      ),
      children: [
        // Tile layer menggunakan OpenStreetMap (GRATIS!)
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.mama',
          maxZoom: 19,
        ),
        // Marker layer dengan sintaks BENAR untuk v6+
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
              ),
              child: Icon(
                Icons.location_on,
                color: Color(0xFFD35400),
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
