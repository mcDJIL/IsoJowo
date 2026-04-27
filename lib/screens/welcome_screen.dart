import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
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
          // Main content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Title: IsoJowo
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Iso',
                        style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
                const SizedBox(height: 32),
                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    'Belajar Bahasa Jawa cara Gen Z. Mulai dari nol sampai jadi master tata krama, kabeh ono neng kene!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      height: 2.0,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                // Mulai Sinau Button
                Container(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 54,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Mulai Sinau',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.72,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
