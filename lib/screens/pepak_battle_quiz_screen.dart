import 'dart:math';
import 'package:flutter/material.dart';
import 'pepak_battle_screen.dart';

// ─── Quiz Question Model ──────────────────────────────────────────────────────

class QuizQuestion {
  final String questionWord;
  final String sourceLabel;
  final String targetLabel;
  final String correctAnswer;
  final List<String> choices; // always 4

  const QuizQuestion({
    required this.questionWord,
    required this.sourceLabel,
    required this.targetLabel,
    required this.correctAnswer,
    required this.choices,
  });
}

// ─── Question Generator ───────────────────────────────────────────────────────

List<QuizQuestion> generateQuestions(PepakBattleSettings settings) {
  final rng = Random();
  final types = settings.selectedTypes.toList();

  // Build pool of all (entry × type) pairs
  final pool = <_PoolItem>[];
  for (final type in types) {
    for (final entry in pepakVocab) {
      pool.add(_PoolItem(entry: entry, type: type));
    }
  }

  if (settings.shuffleQuestions) pool.shuffle(rng);

  final questions = <QuizQuestion>[];
  final count = settings.questionCount;

  for (int i = 0; i < count; i++) {
    final item = pool[i % pool.length];
    final type = item.type;
    final entry = item.entry;
    final correctAnswer = type.answerWord(entry);

    // Build wrong choices from same target-language pool, excluding correct
    final wrongPool = pepakVocab
        .where((e) => e != entry)
        .map((e) => type.answerWord(e))
        .where((w) => w != correctAnswer)
        .toSet()
        .toList()
      ..shuffle(rng);

    final wrongChoices = wrongPool.take(3).toList();
    // Pad if vocab is too small
    while (wrongChoices.length < 3) {
      wrongChoices.add('—');
    }

    final choices = [correctAnswer, ...wrongChoices];
    if (settings.shuffleChoices) choices.shuffle(rng);

    questions.add(QuizQuestion(
      questionWord: type.questionWord(entry),
      sourceLabel: type.sourceLabel,
      targetLabel: type.targetLabel,
      correctAnswer: correctAnswer,
      choices: choices,
    ));
  }

  return questions;
}

class _PoolItem {
  final VocabEntry entry;
  final QuizType type;
  _PoolItem({required this.entry, required this.type});
}

// ─── Quiz Screen ──────────────────────────────────────────────────────────────

enum _QuizPhase { answering, feedback, result }

class PepakBattleQuizScreen extends StatefulWidget {
  final PepakBattleSettings settings;

  const PepakBattleQuizScreen({super.key, required this.settings});

  @override
  State<PepakBattleQuizScreen> createState() => _PepakBattleQuizScreenState();
}

class _PepakBattleQuizScreenState extends State<PepakBattleQuizScreen>
    with SingleTickerProviderStateMixin {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  _QuizPhase _phase = _QuizPhase.answering;
  List<bool> _answerLog = [];

  late AnimationController _resultAnimController;
  late Animation<double> _resultScaleAnim;
  late Animation<double> _resultFadeAnim;

  @override
  void initState() {
    super.initState();
    _questions = generateQuestions(widget.settings);
    _resultAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _resultScaleAnim = CurvedAnimation(
      parent: _resultAnimController,
      curve: Curves.easeOutBack,
    );
    _resultFadeAnim = CurvedAnimation(
      parent: _resultAnimController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _resultAnimController.dispose();
    super.dispose();
  }

  void _onAnswerSelected(String answer) {
    if (_phase != _QuizPhase.answering) return;
    final isCorrect = answer == _questions[_currentIndex].correctAnswer;
    setState(() {
      _selectedAnswer = answer;
      _phase = _QuizPhase.feedback;
      if (isCorrect) _score++;
      _answerLog.add(isCorrect);
    });
  }

  void _onNext() {
    if (_phase != _QuizPhase.feedback) return;
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _phase = _QuizPhase.answering;
      });
    } else {
      setState(() => _phase = _QuizPhase.result);
      _resultAnimController.forward();
    }
  }

  void _playAgain() {
    _resultAnimController.reset();
    setState(() {
      _questions = generateQuestions(widget.settings);
      _currentIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _phase = _QuizPhase.answering;
      _answerLog = [];
    });
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Metu saka Quiz?',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text(
            'Progresmu bakal ilang yen metu saiki.',
            style: TextStyle(color: Colors.black54)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal',
                style: TextStyle(color: Color(0xFFE0962F))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Metu',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ─── Choice colors ─────────────────────────────────────────────────────────

  Color _choiceBgColor(String choice) {
    if (_phase != _QuizPhase.feedback) return Colors.white;
    final correct = _questions[_currentIndex].correctAnswer;
    if (choice == correct) return const Color(0xFF02C63C);
    if (choice == _selectedAnswer) return const Color(0xFFF44336);
    return Colors.white;
  }

  Color _choiceTextColor(String choice) {
    if (_phase != _QuizPhase.feedback) return Colors.black;
    final correct = _questions[_currentIndex].correctAnswer;
    if (choice == correct || choice == _selectedAnswer) return Colors.white;
    return Colors.black;
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_phase == _QuizPhase.result) return _buildResult(context);
    return _buildQuiz(context);
  }

  // ─── Quiz UI ───────────────────────────────────────────────────────────────

  Widget _buildQuiz(BuildContext context) {
    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Batik background
          Opacity(
            opacity: 0.15,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/08fd866c2beef0c7cbea717cffcaf7cf85516ab9?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar: back arrow + IsoJowo ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _showExitDialog,
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 24),
                      ),
                      RichText(
                        text: const TextSpan(children: [
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
                        ]),
                      ),
                    ],
                  ),
                ),

                // ── Title + subtitle ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'Pepak ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF6D1A5),
                            ),
                          ),
                          TextSpan(
                            text: 'Battle',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Buktikan kalau kamu jagoan bahasa Jawa!\nNgoko, Krama, Krama Inggil - Semua bakal diuji disini.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Main quiz card + Lanjut ──────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      children: [
                        // ── Quiz card ──────────────────────────────────
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9E9E9),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.black, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(9, 12),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // "Kembali Ke Pengaturan" button
                              GestureDetector(
                                onTap: _showExitDialog,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.arrow_back,
                                          size: 13, color: Colors.black),
                                      SizedBox(width: 4),
                                      Text(
                                        'Kembali Ke Pengaturan',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Progress bar
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final totalW = constraints.maxWidth;
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: totalW,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.black),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        height: 8,
                                        width: totalW * progress,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE0962F),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 8),

                              // Question number (right aligned)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Pertanyaan ${_currentIndex + 1} dari ${_questions.length}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Mode badge (right) + Score (right)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  // Mode badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0962F),
                                      borderRadius:
                                          BorderRadius.circular(18),
                                      border:
                                          Border.all(color: Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.circle_outlined,
                                            size: 12, color: Colors.black),
                                        const SizedBox(width: 4),
                                        Text(
                                          q.sourceLabel,
                                          style: const TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Score : $_score',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF8121),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Question text
                              Text(
                                'Apa bahasa ${q.targetLabel.toLowerCase()} dari "${q.questionWord}" ?',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Answer choices
                              ...List.generate(q.choices.length, (i) {
                                final choice = q.choices[i];
                                final bg = _choiceBgColor(choice);
                                final tc = _choiceTextColor(choice);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () => _onAnswerSelected(choice),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: bg,
                                        borderRadius:
                                            BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Colors.black),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                            blurRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        choice,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: tc,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Lanjut button ──────────────────────────────
                        GestureDetector(
                          onTap: _phase == _QuizPhase.feedback
                              ? _onNext
                              : null,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: double.infinity,
                            height: 42,
                            decoration: BoxDecoration(
                              color: _phase == _QuizPhase.feedback
                                  ? const Color(0xFFFF8121)
                                  : const Color(0xFFFF8121).withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Lanjut',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
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

  // ─── Result UI ─────────────────────────────────────────────────────────────

  Widget _buildResult(BuildContext context) {
    final total = _questions.length;
    final percentage = total > 0 ? (_score / total * 100).round() : 0;

    String message;
    if (percentage >= 90) {
      message = 'Sempurna! Kamu master bahasa Jawa!';
    } else if (percentage >= 75) {
      message = 'Apik banget! Terusna latihanmu!';
    } else if (percentage >= 60) {
      message = 'Lumayan apik! Ayo luwih semangat maneh!';
    } else if (percentage >= 40) {
      message = 'Isih perlu latihan maneh, aja nyerah!';
    } else {
      message = 'Aja serik, sinau maneh banjur coba maneh!';
    }

    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Batik background
          Opacity(
            opacity: 0.15,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/08fd866c2beef0c7cbea717cffcaf7cf85516ab9?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _resultFadeAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top bar ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 24),
                        ),
                        RichText(
                          text: const TextSpan(children: [
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
                          ]),
                        ),
                      ],
                    ),
                  ),

                  // ── Title + subtitle ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'Pepak ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF6D1A5),
                              ),
                            ),
                            TextSpan(
                              text: 'Battle',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Buktikan kalau kamu jagoan bahasa Jawa!\nNgoko, Krama, Krama Inggil - Semua bakal diuji disini.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Result card ──────────────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      child: ScaleTransition(
                        scale: _resultScaleAnim,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9E9E9),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(9, 12),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Trophy icon circle
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0962F),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.emoji_events_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              // "Kuis Rampung!" title
                              const Text(
                                'Kuis Rampung!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Score e.g. "10/10"
                              Text(
                                '$_score/$total',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFFF8121),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Message
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF676767),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // ── Buttons ───────────────────────────────
                              Row(
                                children: [
                                  // Main Maneh
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _playAgain,
                                      child: Container(
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF8121),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.black),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(2, 2),
                                              blurRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Main Maneh',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Ubah Pengaturan
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.black),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(2, 2),
                                              blurRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Ubah Pengaturan',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
