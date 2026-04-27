import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? Colors.white : const Color(0xFF13324E);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background decorative image
          Image.network(
            'https://api.builder.io/api/v1/image/assets/TEMP/aa8e2da8a48ceeb0d1cfc1bf9028e8e1c0a7fca9?width=1536',
            fit: BoxFit.cover,
            color: Colors.white.withOpacity(0.08),
            colorBlendMode: BlendMode.modulate,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  // Logo IsoJowo
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Iso',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w700,
                            color: primaryTextColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Jowo',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF6D1A5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 88),

                  // Judul halaman
                  Text(
                    'Mlebu ning IsoJowo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1.6,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Sub judul
                  Text(
                    'Mlebu karo akunmu kanggo neruske sinau',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Input Username / Email
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.person_outline,
                          color: Color(0xFF555555),
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _usernameController,
                            style: const TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Username utawa Email',
                              hintStyle: TextStyle(
                                color: Color(0xFF555555),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.42,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Input Password
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.vpn_key_outlined,
                          color: Color(0xFF555555),
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xFF555555),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.42,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF555555),
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Lali Password?
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Navigate to forgot password screen
                      },
                      child: const Text(
                        'Lali Password?',
                        style: TextStyle(
                          color: Color(0xFFFFD38F),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFFFD38F),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol Mlebu (Login)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC6964B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Mlebu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.96,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Utawa mlebu nganggo
                  Text(
                    'Utawa mlebu nganggo',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tombol Google & Apple
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle Google login
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFC6964B),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              'G',
                              style: const TextStyle(
                                color: Color(0xFFC6964B),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Apple
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle Apple login
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFC6964B),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.apple,
                              color: Color(0xFFC6964B),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Durung duwe akun? Daftar Saiki
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Durung duwe akun? ',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.6,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Daftar Saiki',
                              style: TextStyle(
                                color: Color(0xFFFFD38F),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                        ),
                      ],
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
}

// Preview helper (run via flutter run or widget tests)
// ignore: unused_element
Widget _preview() => const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
