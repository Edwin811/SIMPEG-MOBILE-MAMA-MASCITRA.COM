import 'package:flutter/material.dart';
import 'Login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background motif oranye
          Container(
            decoration: const BoxDecoration(color: Color(0xFFD35400)),
            child: Image.asset(
              'lib/assets/pattern.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Wave putih di tengah layar
          Positioned(
            top: screenHeight * 0.58, // Turunkan wave dan tulisan lebih jauh
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: screenHeight * 0.42, // Wave lebih pendek
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const SizedBox(
                        width: 193,
                        height: 44,
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      const SizedBox(
                        width: 307,
                        height: 90,
                        child: Text(
                          'Memantau peserta magang dengan mobilitas tinggi menjadi lebih mudah dengan aplikasi manajemen informasi peserta magang berbasis mobile.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF989898),
                            height: 1.1,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper untuk gelombang
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.15);

    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.00);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.18);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.36);
    var secondEndPoint = Offset(size.width, size.height * 0.15);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
