import 'package:flutter/material.dart';
import 'package:mama/Screen/Home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Motif oranye di atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: LoginWaveClipper(),
              child: Container(
                height: screenHeight * 0.38,
                decoration: const BoxDecoration(color: Color(0xFFD35400)),
                child: Image.asset(
                  'lib/assets/login_pattern.png',
                  fit: BoxFit.none, // Tampilkan gambar sesuai ukuran asli
                  alignment: Alignment.topLeft, // Atur posisi gambar (opsional)
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Color(0xFFD35400));
                  },
                ),
              ),
            ),
          ),
          // Konten login di bawah wave
          Positioned.fill(
            top: screenHeight * 0.32,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Silahkan masuk dengan password\ndan Email-mu yang terdaftar',
                    style: TextStyle(fontSize: 16, color: Color(0xFF989898)),
                  ),
                  const SizedBox(height: 32),
                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD35400), width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Email',
                        hintStyle: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFFD35400),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD35400), width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Password',
                        hintStyle: const TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFFD35400),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF989898),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email dan Password harus diisi!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        // Validasi email sederhana
                        if (!_emailController.text.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email tidak valid!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        // Jika valid, lanjut ke HomeScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    HomeScreen(username: _emailController.text),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD35400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 18,
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Wave putih di bawah motif oranye
class LoginWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85);

    var controlPoint = Offset(size.width * 0.5, size.height);
    var endPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
