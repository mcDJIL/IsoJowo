import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// ---------------------------------------------------------------------------
// GANTI dengan Gemini API Key kamu dari https://aistudio.google.com/
// ---------------------------------------------------------------------------
const String _kGeminiApiKey = 'AIzaSyDxTway9pdiUleCo3txBiPYJet9h6dwLoI';

const String _kGeminiEndpoint =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

const String _kTransformPrompt =
    'Transform this person in the photo to wear authentic traditional Javanese '
    'cultural clothing. For a man, dress them in a batik shirt (baju batik), '
    'blangkon (traditional Javanese head cover), and jarik (batik sarong). '
    'For a woman, dress them in a kebaya with batik jarik, and add sanggul '
    '(traditional Javanese hair bun) with accessories like a flower ornament. '
    'Keep the person\'s face and identity clearly visible and realistic. '
    'The background should reflect a Javanese cultural atmosphere. '
    'Make the result look natural, beautiful, and photorealistic.';

// ---------------------------------------------------------------------------

class NjawiLookScreen extends StatefulWidget {
  const NjawiLookScreen({super.key});

  @override
  State<NjawiLookScreen> createState() => _NjawiLookScreenState();
}

class _NjawiLookScreenState extends State<NjawiLookScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;
  Uint8List? _resultImageBytes;
  bool _isLoading = false;
  String? _errorMessage;

  // ---------- Pick image ----------

  Future<void> _pickFromCamera() async {
    setState(() {
      _resultImageBytes = null;
      _errorMessage = null;
    });
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 85,
      );
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() {
          _selectedImage = file;
          _selectedImageBytes = bytes;
        });
      }
    } on MissingPluginException {
      setState(() {
        _errorMessage =
            'Plugin image_picker belum aktif. Stop app lalu jalankan lagi (full restart), jangan hanya hot reload.';
      });
    } catch (e) {
      setState(() => _errorMessage = 'Gagal buka kamera: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() {
      _resultImageBytes = null;
      _errorMessage = null;
    });
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() {
          _selectedImage = file;
          _selectedImageBytes = bytes;
        });
      }
    } on MissingPluginException {
      setState(() {
        _errorMessage =
            'Plugin image_picker belum aktif. Stop app lalu jalankan lagi (full restart), jangan hanya hot reload.';
      });
    } catch (e) {
      setState(() => _errorMessage = 'Gagal pilih foto: $e');
    }
  }

  // ---------- Gemini AI transform ----------

  Future<void> _transformWithAI() async {
    if (_selectedImage == null || _selectedImageBytes == null) return;
    if (_kGeminiApiKey == 'AIzaSyDxTway9pdiUleCo3txBiPYJet9h6dwLoI') {
      // Pastikan menggunakan API key milikmu yang aktif
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _resultImageBytes = null;
    });

    try {
      final imageBytes = _selectedImageBytes!;
      final base64Image = base64Encode(imageBytes);
      final imageName = _selectedImage!.name.toLowerCase();
      final mimeType = imageName.endsWith('.png') ? 'image/png' : 'image/jpeg';

      // STRUKTUR PAYLOAD DIPERBAIKI
      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              // Gambar dikirim duluan
              {
                'inline_data': {'mime_type': mimeType, 'data': base64Image},
              },
              // Disusul dengan instruksi
              {'text': _kTransformPrompt},
            ],
          },
        ],
        'generationConfig': {
          // Hapus 'responseModalities' yang memaksa 'IMAGE' agar tidak bad request
          'temperature': 0.4,
        },
      });

      final response = await http.post(
        Uri.parse('$_kGeminiEndpoint?key=$_kGeminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body) as Map<String, dynamic>;
          final candidates = json['candidates'] as List?;
          
          if (candidates != null && candidates.isNotEmpty) {
            final parts = (candidates.first['content']['parts'] as List?);
            
            if (parts != null && parts.isNotEmpty) {
              final textResponse = parts.first['text'] as String?;
              
              if (textResponse != null && textResponse.isNotEmpty) {
                if (mounted) {
                  setState(() => _errorMessage = null);
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text(
                        'AI Transformation Result',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: SingleChildScrollView(
                        child: Text(
                          textResponse,
                          style: const TextStyle(
                            color: Color(0xFF13324E),
                            height: 1.5,
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Color(0xFFFF8121)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                setState(() => _errorMessage = 'API returned empty response.');
              }
            } else {
              setState(() => _errorMessage = 'No parts in API response.');
            }
          } else {
            setState(() => _errorMessage = 'No candidates in API response.');
          }
        } catch (parseErr) {
          setState(() => _errorMessage = 'Response parsing error: $parseErr');
        }
      } else {
        try {
          final errJson = jsonDecode(response.body) as Map<String, dynamic>;
          final msg = errJson['error']?['message'] ?? 'Error ${response.statusCode}';
          setState(() => _errorMessage = 'API Error: $msg');
        } catch (_) {
          setState(() => _errorMessage = 'HTTP ${response.statusCode}. Check API key or quota.');
        }
      }
    } catch (e) {
      setState(() => _errorMessage = 'Terjadi error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _resetAll() {
    setState(() {
      _selectedImage = null;
      _selectedImageBytes = null;
      _resultImageBytes = null;
      _errorMessage = null;
    });
  }

  // ---------- Build ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Decorative batik background
          Opacity(
            opacity: 0.08,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/08fd866c2beef0c7cbea717cffcaf7cf85516ab9?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ---- Header ----
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Iso',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Jowo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF6D1A5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ---- Scrollable body ----
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Njawi Look',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        const Text(
                          'Upload fotomu dan biarkan AI yang merubah foto kamu jadi nuansa Jawa paling otentik.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // ---- Source buttons ----
                        Row(
                          children: [
                            _SourceButton(
                              label: 'Kamera',
                              icon: Icons.camera_alt_outlined,
                              filled: true,
                              onTap: _pickFromCamera,
                            ),
                            const SizedBox(width: 12),
                            _SourceButton(
                              label: 'Upload Foto',
                              icon: Icons.upload_outlined,
                              filled: false,
                              onTap: _pickFromGallery,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ---- Polaroid Frame ----
                        Center(
                          child: _PolaroidFrame(
                            selectedImageBytes: _selectedImageBytes,
                            resultBytes: _resultImageBytes,
                            isLoading: _isLoading,
                            onShutter: _selectedImage == null
                                ? _pickFromCamera
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ---- Error message ----
                        if (_errorMessage != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECEC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.red.shade300),
                            ),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 13,
                              ),
                            ),
                          ),

                        // ---- Action buttons ----
                        if (_selectedImage != null && !_isLoading) ...[
                          const SizedBox(height: 16),
                          if (_resultImageBytes == null)
                            _TransformButton(onTap: _transformWithAI)
                          else
                            Column(
                              children: [
                                _TransformButton(
                                  label: 'Transform Ulang',
                                  onTap: _transformWithAI,
                                ),
                                const SizedBox(height: 12),
                                _OutlineButton(
                                  label: 'Mulai Ulang',
                                  onTap: _resetAll,
                                ),
                              ],
                            ),
                        ],

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // ---- Bottom Nav ----
                _BottomNavBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Polaroid Frame
// ---------------------------------------------------------------------------

class _PolaroidFrame extends StatelessWidget {
  final Uint8List? selectedImageBytes;
  final Uint8List? resultBytes;
  final bool isLoading;
  final VoidCallback? onShutter;

  const _PolaroidFrame({
    required this.selectedImageBytes,
    required this.resultBytes,
    required this.isLoading,
    this.onShutter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 9, offset: Offset(3, 3)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        children: [
          // Image area
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              height: 280,
              color: Colors.black,
              child: _buildImageContent(),
            ),
          ),
          const SizedBox(height: 12),

          // Caption or shutter button
          if (resultBytes != null)
            const Text(
              'Tampilan Njawi kamu siap!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            )
          else if (isLoading)
            const Column(
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF8121),
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'AI lagi ngubah ke nuansa Jawa...',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          else if (onShutter != null)
            GestureDetector(
              onTap: onShutter,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8121),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(2, 2)),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            )
          else
            const Text(
              'Upload Foto Terbaikmu Disini!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    if (isLoading && selectedImageBytes != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(selectedImageBytes!, fit: BoxFit.cover),
          Container(color: Colors.black54),
          const Center(
            child: CircularProgressIndicator(color: Color(0xFFFF8121)),
          ),
        ],
      );
    }

    if (resultBytes != null) {
      return Image.memory(resultBytes!, fit: BoxFit.cover);
    }

    if (selectedImageBytes != null) {
      return Image.memory(selectedImageBytes!, fit: BoxFit.cover);
    }

    // Placeholder
    return const Center(
      child: Icon(Icons.account_circle, size: 100, color: Colors.white),
    );
  }
}

// ---------------------------------------------------------------------------
// Source Button (Kamera / Upload Foto)
// ---------------------------------------------------------------------------

class _SourceButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _SourceButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: filled ? const Color(0xFFFF8121) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: filled ? Colors.white : Colors.black),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: filled ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Transform Button
// ---------------------------------------------------------------------------

class _TransformButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _TransformButton({
    required this.onTap,
    this.label = 'Transform ke Njawi Look',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8121),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_fix_high_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Outline Button
// ---------------------------------------------------------------------------

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom Nav Bar
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9EAD7),
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
        left: 24,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Icon(Icons.home_rounded, size: 32, color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Icon(Icons.search_rounded, size: 32, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Icon(
              Icons.person_outline_rounded,
              size: 32,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Icon(Icons.settings_outlined, size: 32, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Preview
// ---------------------------------------------------------------------------

// ignore: unused_element
Widget _preview() => const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: NjawiLookScreen(),
);
