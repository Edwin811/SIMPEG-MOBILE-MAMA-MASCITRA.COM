import 'package:flutter/material.dart';
import 'package:mama/Screen/SelectedDate_screen.dart'; // Tambahkan import

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
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
                  ),
                  Positioned(
                    left: 16,
                    top: 48,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Riwayat Absensi',
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                120,
              ), // Tambahkan padding bottom
              children: [
                _AttendanceCard(
                  date: '23 July 2025',
                  inTime: '07:29:53',
                  inLocation:
                      'Lat: -8.1857992\nLong: 113.6806793\nRM7J+M6Q, Kaliwates, Kecamatan Kaliwates, 68131, Indonesia',
                  outTime: '17:10:41',
                  outLocation:
                      'Lat: -8.1857992\nLong: 113.6806793\nRM7J+M6Q, Kaliwates, Kecamatan Kaliwates, 68131, Indonesia',
                ),
                const SizedBox(height: 16),
                _AttendanceCard(
                  date: '22 July 2025',
                  inTime: '07:29:53',
                  inLocation:
                      'Lat: -8.1857992\nLong: 113.6806793\nRM7J+M6Q, Kaliwates, Kecamatan Kaliwates, 68131, Indonesia',
                  outTime: '17:10:41',
                  outLocation:
                      'Lat: -8.1857992\nLong: 113.6806793\nRM7J+M6Q, Kaliwates, Kecamatan Kaliwates, 68131, Indonesia',
                ),
                const SizedBox(height: 24),
                // ...jangan letakkan filter absensi di sini...
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
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
                                'Select Date',
                                style: TextStyle(
                                  color: Color(0xFFD35400),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'No Data',
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
              Divider(height: 1, color: Color(0xFFF5F5F7)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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

class _AttendanceCard extends StatelessWidget {
  final String date;
  final String inTime;
  final String inLocation;
  final String outTime;
  final String outLocation;
  const _AttendanceCard({
    required this.date,
    required this.inTime,
    required this.inLocation,
    required this.outTime,
    required this.outLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD35400),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Jam Masuk',
                  style: TextStyle(color: Color(0xFF989898), fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  inLocation,
                  style: const TextStyle(
                    color: Color(0xFF989898),
                    fontSize: 12,
                  ),
                ),
                const Divider(height: 20),
                Text(
                  outTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Jam Pulang',
                  style: TextStyle(color: Color(0xFF989898), fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  outLocation,
                  style: const TextStyle(
                    color: Color(0xFF989898),
                    fontSize: 12,
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
