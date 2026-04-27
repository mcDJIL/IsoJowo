import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// ── Data Model ───────────────────────────────────────────────────────────────

class _FlashCard {
  final String imageUrl;
  final String labelIndonesia;
  final String labelNgoko;
  final String labelKrama;
  final String labelKramaInggil;
  final String emoji;

  const _FlashCard({
    required this.imageUrl,
    required this.labelIndonesia,
    required this.labelNgoko,
    required this.labelKrama,
    required this.labelKramaInggil,
    required this.emoji,
  });
}

const List<_FlashCard> _flashCards = [
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1554672408-730436b60dde?w=600&q=80',
    labelIndonesia: 'Uang',
    labelNgoko: 'Dhuwit',
    labelKrama: 'Yatra',
    labelKramaInggil: 'Arta',
    emoji: '💰',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600&q=80',
    labelIndonesia: 'Kucing',
    labelNgoko: 'Kucing',
    labelKrama: 'Kucing',
    labelKramaInggil: 'Kucing',
    emoji: '🐱',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&q=80',
    labelIndonesia: 'Anjing',
    labelNgoko: 'Asu',
    labelKrama: 'Sona',
    labelKramaInggil: 'Sona',
    emoji: '🐶',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1546445317-29f4545e9d53?w=600&q=80',
    labelIndonesia: 'Sapi',
    labelNgoko: 'Sapi',
    labelKrama: 'Lembu',
    labelKramaInggil: 'Lembu',
    emoji: '🐄',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?w=600&q=80',
    labelIndonesia: 'Ayam',
    labelNgoko: 'Pitik',
    labelKrama: 'Ayam',
    labelKramaInggil: 'Ayam',
    emoji: '🐔',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=600&q=80',
    labelIndonesia: 'Nasi',
    labelNgoko: 'Sego',
    labelKrama: 'Sekul',
    labelKramaInggil: 'Sekul',
    emoji: '🍚',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=600&q=80',
    labelIndonesia: 'Air',
    labelNgoko: 'Banyu',
    labelKrama: 'Toya',
    labelKramaInggil: 'Toya',
    emoji: '💧',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600&q=80',
    labelIndonesia: 'Rumah',
    labelNgoko: 'Omah',
    labelKrama: 'Griya',
    labelKramaInggil: 'Dalem',
    emoji: '🏠',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600&q=80',
    labelIndonesia: 'Buku',
    labelNgoko: 'Buku',
    labelKrama: 'Buku',
    labelKramaInggil: 'Buku',
    emoji: '📚',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1490750967868-88df5691cc0e?w=600&q=80',
    labelIndonesia: 'Bunga',
    labelNgoko: 'Kembang',
    labelKrama: 'Sekar',
    labelKramaInggil: 'Sekar',
    emoji: '🌸',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1524704654690-b56c05c78a00?w=600&q=80',
    labelIndonesia: 'Ikan',
    labelNgoko: 'Iwak',
    labelKrama: 'Ulam',
    labelKramaInggil: 'Ulam',
    emoji: '🐟',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1510914828947-36f754990aa5?w=600&q=80',
    labelIndonesia: 'Pohon',
    labelNgoko: 'Wit',
    labelKrama: 'Wit',
    labelKramaInggil: 'Wit',
    emoji: '🌳',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600&q=80',
    labelIndonesia: 'Baju',
    labelNgoko: 'Klambi',
    labelKrama: 'Rasukan',
    labelKramaInggil: 'Ageman',
    emoji: '👕',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=600&q=80',
    labelIndonesia: 'Apel',
    labelNgoko: 'Apel',
    labelKrama: 'Apel',
    labelKramaInggil: 'Apel',
    emoji: '🍎',
  ),
  _FlashCard(
    imageUrl:
        'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=600&q=80',
    labelIndonesia: 'Pisang',
    labelNgoko: 'Gedhang',
    labelKrama: 'Pisang',
    labelKramaInggil: 'Pisang',
    emoji: '🍌',
  ),
];

// ── Screen ───────────────────────────────────────────────────────────────────

class FlashJowoScreen extends StatefulWidget {
  const FlashJowoScreen({super.key});

  @override
  State<FlashJowoScreen> createState() => _FlashJowoScreenState();
}

class _FlashJowoScreenState extends State<FlashJowoScreen> {
  int _currentIndex = 0;
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;
  String? _speakingLabel;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('id-ID');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _tts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _speakingLabel = null;
        });
      }
    });
    _tts.setErrorHandler((_) {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _speakingLabel = null;
        });
      }
    });
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking && _speakingLabel == text) {
      await _tts.stop();
      setState(() {
        _isSpeaking = false;
        _speakingLabel = null;
      });
      return;
    }
    await _tts.stop();
    setState(() {
      _isSpeaking = true;
      _speakingLabel = text;
    });
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex < _flashCards.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = _flashCards[_currentIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? Colors.white : const Color(0xFF13324E);
    final secondaryTextColor =
        isDark ? Colors.white70 : const Color(0xB313324E);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: const _BottomNavBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Decorative background
          Opacity(
            opacity: 0.06,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/f1828b978e690114101e186b725d52bdaac93ff7?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── Top Bar ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryTextColor,
                          size: 24,
                        ),
                      ),
                      // Logo
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Iso',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: primaryTextColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Jowo',
                              style: TextStyle(
                                fontSize: 22,
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

                // ── Title & Subtitle ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Flash ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF6D1A5),
                              ),
                            ),
                            TextSpan(
                              text: 'Jowo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tes kemampuan kosakata Jawamu. Klik suara di kartu untuk melihat jawaban.',
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryTextColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Scrollable body ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      children: [
                        // ── Flashcard ────────────────────────────────────
                        _FlashCardWidget(
                          card: card,
                          currentIndex: _currentIndex,
                          total: _flashCards.length,
                          onPrev: _currentIndex > 0 ? _goPrev : null,
                          onNext:
                              _currentIndex < _flashCards.length - 1
                                  ? _goNext
                                  : null,
                        ),

                        const SizedBox(height: 24),

                        // ── Answer Cards ─────────────────────────────────
                        _AnswerCard(
                          label: 'INDONESIA',
                          word: card.labelIndonesia,
                          bgColor: const Color(0xFFFF8121),
                          textColor: Colors.white,
                          labelColor: Colors.white70,
                          isSpeaking:
                              _isSpeaking &&
                              _speakingLabel == card.labelIndonesia,
                          onSpeak: () => _speak(card.labelIndonesia),
                        ),
                        const SizedBox(height: 12),
                        _AnswerCard(
                          label: 'NGOKO',
                          word: card.labelNgoko,
                          bgColor: const Color(0xFFC6964B),
                          textColor: Colors.white,
                          labelColor: Colors.white70,
                          isSpeaking:
                              _isSpeaking &&
                              _speakingLabel == card.labelNgoko,
                          onSpeak: () => _speak(card.labelNgoko),
                        ),
                        const SizedBox(height: 12),
                        _AnswerCard(
                          label: 'KRAMA',
                          word: card.labelKrama,
                          bgColor: const Color(0xFFF9EAD7),
                          textColor: Colors.black87,
                          labelColor: Colors.black54,
                          isSpeaking:
                              _isSpeaking &&
                              _speakingLabel == card.labelKrama,
                          onSpeak: () => _speak(card.labelKrama),
                        ),
                        const SizedBox(height: 12),
                        _AnswerCard(
                          label: 'KRAMA INGGIL',
                          word: card.labelKramaInggil,
                          bgColor: const Color(0xFFFFDABE),
                          textColor: Colors.black87,
                          labelColor: Colors.black54,
                          isSpeaking:
                              _isSpeaking &&
                              _speakingLabel == card.labelKramaInggil,
                          onSpeak: () => _speak(card.labelKramaInggil),
                        ),

                        const SizedBox(height: 24),
                      ],
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

// ── Flashcard Widget ──────────────────────────────────────────────────────────

class _FlashCardWidget extends StatelessWidget {
  final _FlashCard card;
  final int currentIndex;
  final int total;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _FlashCardWidget({
    required this.card,
    required this.currentIndex,
    required this.total,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(9, 12), blurRadius: 0),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${currentIndex + 1} / $total',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Image with nav arrows
          Row(
            children: [
              // Prev arrow
              _NavArrow(
                icon: Icons.chevron_left_rounded,
                onTap: onPrev,
              ),
              const SizedBox(width: 8),

              // Image
              Expanded(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(2, 5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.network(
                      card.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            color: const Color(0xFFF0E8D8),
                            child: Center(
                              child: Text(
                                card.emoji,
                                style: const TextStyle(fontSize: 72),
                              ),
                            ),
                          ),
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: const Color(0xFFF0E8D8),
                          child: Center(
                            child: Text(
                              card.emoji,
                              style: const TextStyle(fontSize: 72),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),
              // Next arrow
              _NavArrow(
                icon: Icons.chevron_right_rounded,
                onTap: onNext,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              total > 10 ? 10 : total,
              (i) {
                final idx = total > 10 ? (currentIndex ~/ (total / 10)) : i;
                final active =
                    total > 10
                        ? i == (currentIndex * 10 ~/ total)
                        : i == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        active
                            ? const Color(0xFFE0962F)
                            : Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
            child: Icon(
              Icons.settings_outlined,
              size: 32,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav Arrow Button ──────────────────────────────────────────────────────────

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.3,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFE0962F),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 0,
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: Colors.black),
        ),
      ),
    );
  }
}

// ── Answer Card ───────────────────────────────────────────────────────────────

class _AnswerCard extends StatelessWidget {
  final String label;
  final String word;
  final Color bgColor;
  final Color textColor;
  final Color labelColor;
  final bool isSpeaking;
  final VoidCallback onSpeak;

  const _AnswerCard({
    required this.label,
    required this.word,
    required this.bgColor,
    required this.textColor,
    required this.labelColor,
    required this.isSpeaking,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(6, 10),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          // Label + Word
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  word,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),

          // Speaker button
          GestureDetector(
            onTap: onSpeak,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    isSpeaking
                        ? const Color(0xFFE0962F)
                        : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(8),
                boxShadow:
                    isSpeaking
                        ? [
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 0,
                          ),
                        ]
                        : [],
              ),
              child: Icon(
                isSpeaking ? Icons.volume_up_rounded : Icons.volume_up_outlined,
                size: 20,
                color: isSpeaking ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
