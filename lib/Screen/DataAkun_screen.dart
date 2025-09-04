import 'package:flutter/material.dart';

class DataAkunScreen extends StatelessWidget {
  const DataAkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header dengan pattern oranye
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
                          'Data Akun',
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

          // Data Akun Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    // Email
                    _DataItem(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'edwin@gmail.com',
                    ),
                    _buildDivider(),

                    // NIP
                    _DataItem(
                      icon: Icons.badge_outlined,
                      label: 'NIP',
                      value: '123456789/1234567890',
                    ),
                    _buildDivider(),

                    // Nama
                    _DataItem(
                      icon: Icons.person_outline,
                      label: 'Nama',
                      value: 'Edwin',
                    ),
                    _buildDivider(),

                    // Nomor Telepon
                    _DataItem(
                      icon: Icons.phone_outlined,
                      label: 'Nomor Telepon',
                      value: '12345678910',
                    ),
                    _buildDivider(),

                    // Alamat
                    _DataItem(
                      icon: Icons.location_on_outlined,
                      label: 'Alamat',
                      value: 'Lorem ipsum dolor sit amet, consectetur.',
                    ),
                    _buildDivider(),

                    // Tempat Lahir
                    _DataItem(
                      icon: Icons.place_outlined,
                      label: 'Tempat Lahir',
                      value: 'Lorem ipsum dolor sit amet, consectetur.',
                    ),
                    _buildDivider(),

                    // Tanggal Lahir
                    _DataItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Tanggal Lahir',
                      value: '02/09/2008',
                    ),
                    _buildDivider(),

                    // Jenis Kelamin
                    _DataItem(
                      icon: Icons.person_2_outlined,
                      label: 'Jenis Kelamin',
                      value: 'Laki laki dong bosss',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: const Color(0xFFF0F0F0),
    );
  }
}

// Widget untuk item data
class _DataItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DataItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFD35400).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFFD35400), size: 20),
          ),
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD35400),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
