import 'package:flutter/material.dart';
import 'package:mama/Screen/Notification_screen.dart';
import 'package:mama/Screen/Profile_screen.dart';
import 'package:mama/Screen/AttendanceHistory_screen.dart';
import 'package:mama/Screen/CheckIn_screen.dart';
import 'package:mama/Screen/CheckOut_screen.dart';
import 'package:mama/Screen/KegiatanHarian_screen.dart';
import 'package:mama/Screen/Cuti_screen.dart';
import 'package:mama/Screen/Penilaian_screen.dart'; // Tambahkan import ini
import 'package:mama/Widget/BottomNavbar.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header tetap sama...
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: Container(
                          width: screenWidth,
                          height: 161,
                          color: const Color(0xFFD35400),
                          child: Image.asset(
                            'lib/assets/login_pattern.png',
                            fit: BoxFit.cover,
                            width: screenWidth,
                            height: 161,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              'Edwin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 80,
                        right: 24,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Menu utama
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HomeMenuItem(
                          icon: Icons.access_time,
                          label: 'Jam Masuk',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckInScreen(),
                              ),
                            );
                          },
                        ),
                        _HomeMenuItem(
                          icon: Icons.access_time_outlined,
                          label: 'Jam Pulang',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckOutScreen(),
                              ),
                            );
                          },
                        ),
                        _HomeMenuItem(
                          asset: 'lib/assets/Homescreen/cuti.png',
                          label: 'Cuti',
                          onTap: () {
                            // Navigasi ke halaman Cuti
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CutiScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HomeMenuItem(
                          asset: 'lib/assets/Homescreen/kegiatan_harian.png',
                          label: 'Kegiatan Harian',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const KegiatanHarianScreen(),
                              ),
                            );
                          },
                        ),
                        _HomeMenuItem(
                          asset: 'lib/assets/Homescreen/riwayat_absensi.png',
                          label: 'Riwayat Absensi',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AttendanceHistoryScreen(),
                              ),
                            );
                          },
                        ),
                        _HomeMenuItem(
                          asset: 'lib/assets/Homescreen/penilaian.png',
                          label: 'Penilaian',
                          onTap: () {
                            // Navigasi ke halaman Penilaian
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PenilaianScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Sisa konten tetap sama...
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Absensi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _DateItem(day: 'MON', date: '4', selected: true),
                            _DateItem(day: 'Tue', date: '5'),
                            _DateItem(day: 'Wed', date: '6'),
                            _DateItem(day: 'Thr', date: '7'),
                            _DateItem(day: 'Fri', date: '8'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke CheckIn screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckInScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDEEE3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Status',
                                  style: TextStyle(
                                    color: Color(0xFF989898),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Belum Absen',
                                  style: TextStyle(
                                    color: Color(0xFFD35400),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.fingerprint,
                                  color: Color(0xFFD35400),
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Pemberitahuan
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pemberitahuan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD35400),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Lorem ipsum dolor sit amet',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi venenatis eget ligula ac posuere. Duis mattis molestie tristique. Ut euismod diam non lorem condimentum sagittis.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}

// Widget classes tetap sama...
class _HomeMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? asset;
  final String label;
  final VoidCallback? onTap;
  const _HomeMenuItem({this.icon, this.asset, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.22),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child:
                    asset != null
                        ? Image.asset(
                          asset!,
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        )
                        : Icon(icon, color: Color(0xFFD35400), size: 28),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFD35400),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;
  const _DateItem({
    required this.day,
    required this.date,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 64,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: selected ? Color(0xFFD35400) : Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: selected ? Colors.white : Color(0xFF989898),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              color: selected ? Colors.white : Color(0xFF989898),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
