import 'dart:math';
import 'package:flutter/material.dart';
import 'pepak_battle_quiz_screen.dart';

// ─── Vocabulary Data ──────────────────────────────────────────────────────────

class VocabEntry {
  final String indonesia;
  final String ngoko;
  final String krama;
  final String kramaInggil;

  const VocabEntry({
    required this.indonesia,
    required this.ngoko,
    required this.krama,
    required this.kramaInggil,
  });
}

const List<VocabEntry> pepakVocab = [
  VocabEntry(indonesia: 'Uang', ngoko: 'Dhuwit', krama: 'Yatra', kramaInggil: 'Arta'),
  VocabEntry(indonesia: 'Kucing', ngoko: 'Kucing', krama: 'Kucing', kramaInggil: 'Kucing'),
  VocabEntry(indonesia: 'Anjing', ngoko: 'Asu', krama: 'Sona', kramaInggil: 'Sona'),
  VocabEntry(indonesia: 'Sapi', ngoko: 'Sapi', krama: 'Lembu', kramaInggil: 'Lembu'),
  VocabEntry(indonesia: 'Ayam', ngoko: 'Pitik', krama: 'Ayam', kramaInggil: 'Ayam'),
  VocabEntry(indonesia: 'Nasi', ngoko: 'Sego', krama: 'Sekul', kramaInggil: 'Sekul'),
  VocabEntry(indonesia: 'Air', ngoko: 'Banyu', krama: 'Toya', kramaInggil: 'Toya'),
  VocabEntry(indonesia: 'Rumah', ngoko: 'Omah', krama: 'Griya', kramaInggil: 'Dalem'),
  VocabEntry(indonesia: 'Buku', ngoko: 'Buku', krama: 'Buku', kramaInggil: 'Buku'),
  VocabEntry(indonesia: 'Bunga', ngoko: 'Kembang', krama: 'Sekar', kramaInggil: 'Sekar'),
  VocabEntry(indonesia: 'Ikan', ngoko: 'Iwak', krama: 'Ulam', kramaInggil: 'Ulam'),
  VocabEntry(indonesia: 'Pohon', ngoko: 'Wit', krama: 'Wit', kramaInggil: 'Wit'),
  VocabEntry(indonesia: 'Baju', ngoko: 'Klambi', krama: 'Rasukan', kramaInggil: 'Ageman'),
  VocabEntry(indonesia: 'Apel', ngoko: 'Apel', krama: 'Apel', kramaInggil: 'Apel'),
  VocabEntry(indonesia: 'Pisang', ngoko: 'Gedhang', krama: 'Pisang', kramaInggil: 'Pisang'),
  VocabEntry(indonesia: 'Makan', ngoko: 'Mangan', krama: 'Nedha', kramaInggil: 'Dhahar'),
  VocabEntry(indonesia: 'Minum', ngoko: 'Ngombe', krama: 'Ngunjuk', kramaInggil: 'Ngunjuk'),
  VocabEntry(indonesia: 'Tidur', ngoko: 'Turu', krama: 'Tilem', kramaInggil: 'Sare'),
  VocabEntry(indonesia: 'Pergi', ngoko: 'Lunga', krama: 'Kesah', kramaInggil: 'Tindak'),
  VocabEntry(indonesia: 'Datang', ngoko: 'Teka', krama: 'Dhateng', kramaInggil: 'Rawuh'),
  VocabEntry(indonesia: 'Melihat', ngoko: 'Ndelok', krama: 'Ningali', kramaInggil: 'Mirsani'),
  VocabEntry(indonesia: 'Berbicara', ngoko: 'Ngomong', krama: 'Criyos', kramaInggil: 'Ngendika'),
  VocabEntry(indonesia: 'Berjalan', ngoko: 'Mlaku', krama: 'Mlampah', kramaInggil: 'Tindak'),
  VocabEntry(indonesia: 'Duduk', ngoko: 'Lungguh', krama: 'Lenggah', kramaInggil: 'Lenggah'),
  VocabEntry(indonesia: 'Tangan', ngoko: 'Tangan', krama: 'Tangan', kramaInggil: 'Asta'),
  VocabEntry(indonesia: 'Kepala', ngoko: 'Sirah', krama: 'Mustaka', kramaInggil: 'Mustaka'),
  VocabEntry(indonesia: 'Mata', ngoko: 'Mripat', krama: 'Paningal', kramaInggil: 'Paningal'),
  VocabEntry(indonesia: 'Mulut', ngoko: 'Cangkem', krama: 'Tutuk', kramaInggil: 'Lesan'),
  VocabEntry(indonesia: 'Hati', ngoko: 'Ati', krama: 'Manah', kramaInggil: 'Penggalih'),
  VocabEntry(indonesia: 'Nama', ngoko: 'Jeneng', krama: 'Asma', kramaInggil: 'Asma'),
];

// ─── Quiz Type Enum ───────────────────────────────────────────────────────────

enum QuizType {
  indoNgoko,
  indoKrama,
  indoKramaInggil,
  ngokoIndo,
  ngokoKrama,
  ngokoKramaInggil,
  kramaIndo,
  kramaNgoko,
  kramaKramaInggil,
  kramaInggilIndo,
  kramaInggilNgoko,
  kramaInggilKrama,
}

extension QuizTypeExt on QuizType {
  String get label {
    switch (this) {
      case QuizType.indoNgoko:
        return 'Indo→Ngoko';
      case QuizType.indoKrama:
        return 'Indo→Krama';
      case QuizType.indoKramaInggil:
        return 'Indo→Krama Inggil';
      case QuizType.ngokoIndo:
        return 'Ngoko→Indo';
      case QuizType.ngokoKrama:
        return 'Ngoko→Krama';
      case QuizType.ngokoKramaInggil:
        return 'Ngoko→Krama Inggil';
      case QuizType.kramaIndo:
        return 'Krama→Indo';
      case QuizType.kramaNgoko:
        return 'Krama→Ngoko';
      case QuizType.kramaKramaInggil:
        return 'Krama→Krama Inggil';
      case QuizType.kramaInggilIndo:
        return 'Krama Inggil→Indo';
      case QuizType.kramaInggilNgoko:
        return 'Krama Inggil→Ngoko';
      case QuizType.kramaInggilKrama:
        return 'Krama Inggil→Krama';
    }
  }

  String questionWord(VocabEntry e) {
    switch (this) {
      case QuizType.indoNgoko:
      case QuizType.indoKrama:
      case QuizType.indoKramaInggil:
        return e.indonesia;
      case QuizType.ngokoIndo:
      case QuizType.ngokoKrama:
      case QuizType.ngokoKramaInggil:
        return e.ngoko;
      case QuizType.kramaIndo:
      case QuizType.kramaNgoko:
      case QuizType.kramaKramaInggil:
        return e.krama;
      case QuizType.kramaInggilIndo:
      case QuizType.kramaInggilNgoko:
      case QuizType.kramaInggilKrama:
        return e.kramaInggil;
    }
  }

  String answerWord(VocabEntry e) {
    switch (this) {
      case QuizType.indoNgoko:
      case QuizType.kramaNgoko:
      case QuizType.kramaInggilNgoko:
        return e.ngoko;
      case QuizType.indoKrama:
      case QuizType.ngokoKrama:
      case QuizType.kramaInggilKrama:
        return e.krama;
      case QuizType.indoKramaInggil:
      case QuizType.ngokoKramaInggil:
      case QuizType.kramaKramaInggil:
        return e.kramaInggil;
      case QuizType.ngokoIndo:
      case QuizType.kramaIndo:
      case QuizType.kramaInggilIndo:
        return e.indonesia;
    }
  }

  String get sourceLabel {
    switch (this) {
      case QuizType.indoNgoko:
      case QuizType.indoKrama:
      case QuizType.indoKramaInggil:
        return 'Indonesia';
      case QuizType.ngokoIndo:
      case QuizType.ngokoKrama:
      case QuizType.ngokoKramaInggil:
        return 'Ngoko';
      case QuizType.kramaIndo:
      case QuizType.kramaNgoko:
      case QuizType.kramaKramaInggil:
        return 'Krama';
      case QuizType.kramaInggilIndo:
      case QuizType.kramaInggilNgoko:
      case QuizType.kramaInggilKrama:
        return 'Krama Inggil';
    }
  }

  String get targetLabel {
    switch (this) {
      case QuizType.indoNgoko:
      case QuizType.kramaNgoko:
      case QuizType.kramaInggilNgoko:
        return 'Ngoko';
      case QuizType.indoKrama:
      case QuizType.ngokoKrama:
      case QuizType.kramaInggilKrama:
        return 'Krama';
      case QuizType.indoKramaInggil:
      case QuizType.ngokoKramaInggil:
      case QuizType.kramaKramaInggil:
        return 'Krama Inggil';
      case QuizType.ngokoIndo:
      case QuizType.kramaIndo:
      case QuizType.kramaInggilIndo:
        return 'Indonesia';
    }
  }
}

// ─── Settings Model ───────────────────────────────────────────────────────────

class PepakBattleSettings {
  final int questionCount;
  final Set<QuizType> selectedTypes;
  final bool shuffleQuestions;
  final bool shuffleChoices;

  const PepakBattleSettings({
    required this.questionCount,
    required this.selectedTypes,
    required this.shuffleQuestions,
    required this.shuffleChoices,
  });
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class PepakBattleScreen extends StatefulWidget {
  const PepakBattleScreen({super.key});

  @override
  State<PepakBattleScreen> createState() => _PepakBattleScreenState();
}

class _PepakBattleScreenState extends State<PepakBattleScreen> {
  int _questionCount = 10;
  final Set<QuizType> _selectedTypes = {
    QuizType.indoNgoko,
    QuizType.ngokoKrama,
    QuizType.kramaInggilNgoko,
  };
  bool _shuffleQuestions = true;
  bool _shuffleChoices = true;

  static const _questionCounts = [5, 10, 15, 20];

  void _toggleType(QuizType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  void _clearTypes() => setState(() => _selectedTypes.clear());

  void _randomFourTypes() {
    final shuffled = List<QuizType>.from(QuizType.values)..shuffle(Random());
    setState(() {
      _selectedTypes
        ..clear()
        ..addAll(shuffled.take(4));
    });
  }

  void _startQuiz() {
    if (_selectedTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal satu tipe pertanyaan dulu!'),
          backgroundColor: Color(0xFFE0962F),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PepakBattleQuizScreen(
          settings: PepakBattleSettings(
            questionCount: _questionCount,
            selectedTypes: Set.from(_selectedTypes),
            shuffleQuestions: _shuffleQuestions,
            shuffleChoices: _shuffleChoices,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? Colors.white : const Color(0xFF13324E);
    final secondaryTextColor =
        isDark ? Colors.white70 : const Color(0xB313324E);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: _PepakBottomNavBar(onHome: () => Navigator.pop(context)),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.06,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/08fd866c2beef0c7cbea717cffcaf7cf85516ab9?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back,
                            color: primaryTextColor, size: 24),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Iso',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: primaryTextColor)),
                          TextSpan(
                              text: 'Jowo',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF6D1A5))),
                        ]),
                      ),
                    ],
                  ),
                ),

                // Title & subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Pepak ',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF6D1A5))),
                          TextSpan(
                              text: 'Battle',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: primaryTextColor)),
                        ]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Siapkan, strategikamu. Tentukan level tantangan dan\ntipe soal yang mau kamu taklukkan!',
                        style: TextStyle(
                            fontSize: 12, color: secondaryTextColor, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Settings card
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(9, 12),
                              blurRadius: 0),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Jumlah Pertanyaan ──────────────────────────
                          const Text('Jumlah Pertanyaan',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _questionCounts.map((count) {
                              final isSelected = _questionCount == count;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _questionCount = count),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 44,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFF8121)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(1, 1),
                                          blurRadius: 0),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$count',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),

                          // ── Tipe Pertanyaan ────────────────────────────
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tipe Pertanyaan (${_selectedTypes.length} dipilih)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _PillButton(
                                    label: 'Kosongkan',
                                    onTap: _clearTypes,
                                  ),
                                  _PillButton(
                                    label: 'Acak 4 tipe',
                                    icon: Icons.shuffle_rounded,
                                    onTap: _randomFourTypes,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Type chip grid (3 columns)
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isNarrow = constraints.maxWidth < 360;
                              final crossAxisCount = isNarrow ? 2 : 3;

                              return GridView.count(
                                crossAxisCount: crossAxisCount,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: isNarrow ? 3.2 : 3.0,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                children: QuizType.values.map((type) {
                                  final isSelected =
                                      _selectedTypes.contains(type);
                                  return GestureDetector(
                                    onTap: () => _toggleType(type),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFFF8121)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.black),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            type.label,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w700,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── Opsi Acak ──────────────────────────────────
                          Row(
                            children: const [
                              Icon(Icons.shuffle_rounded,
                                  size: 18, color: Colors.black),
                              SizedBox(width: 6),
                              Text('Opsi Acak',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 360) {
                                return Column(
                                  children: [
                                    _ToggleCard(
                                      title: 'Acak Pertanyaan',
                                      subtitle: 'urutan Pertanyaan diacak',
                                      value: _shuffleQuestions,
                                      onChanged: (v) =>
                                          setState(() => _shuffleQuestions = v),
                                    ),
                                    const SizedBox(height: 8),
                                    _ToggleCard(
                                      title: 'Acak Pilihan',
                                      subtitle: 'urutan Jawaban diacak',
                                      value: _shuffleChoices,
                                      onChanged: (v) =>
                                          setState(() => _shuffleChoices = v),
                                    ),
                                  ],
                                );
                              }

                              return Row(
                                children: [
                                  Expanded(
                                    child: _ToggleCard(
                                      title: 'Acak Pertanyaan',
                                      subtitle: 'urutan Pertanyaan diacak',
                                      value: _shuffleQuestions,
                                      onChanged: (v) =>
                                          setState(() => _shuffleQuestions = v),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _ToggleCard(
                                      title: 'Acak Pilihan',
                                      subtitle: 'urutan Jawaban diacak',
                                      value: _shuffleChoices,
                                      onChanged: (v) =>
                                          setState(() => _shuffleChoices = v),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── Mulai Quiz ─────────────────────────────────
                          GestureDetector(
                            onTap: _startQuiz,
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF8121),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(2, 3),
                                      blurRadius: 0),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_arrow_rounded,
                                      color: Colors.white, size: 24),
                                  SizedBox(width: 6),
                                  Text(
                                    'Mulai Quiz',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
}

// ─── Pill Button ──────────────────────────────────────────────────────────────

class _PillButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _PillButton({required this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFE0962F),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 11),
              const SizedBox(width: 3),
            ],
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ─── Toggle Card ──────────────────────────────────────────────────────────────

class _ToggleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE9B15A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 10)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 8, color: Colors.black54)),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.65,
            alignment: Alignment.centerRight,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFFFF8121),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav Bar ───────────────────────────────────────────────────────────

class _PepakBottomNavBar extends StatelessWidget {
  final VoidCallback onHome;
  const _PepakBottomNavBar({required this.onHome});

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
            onTap: onHome,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Icon(Icons.home_rounded,
                  size: 32, color: Color(0xFFC6964B)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Icon(Icons.search_rounded, size: 32, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Icon(Icons.person_outline_rounded,
                size: 32, color: Colors.black),
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
