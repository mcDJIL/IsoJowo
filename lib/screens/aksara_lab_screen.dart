import 'package:flutter/material.dart';

// ── Data ─────────────────────────────────────────────────────────────────────

class _AksaraItem {
  final String latin;
  final String javanese;
  const _AksaraItem({required this.latin, required this.javanese});
}

const List<_AksaraItem> _hanacaraka = [
  _AksaraItem(latin: 'HA', javanese: 'ꦲ'),
  _AksaraItem(latin: 'NA', javanese: 'ꦤ'),
  _AksaraItem(latin: 'CA', javanese: 'ꦕ'),
  _AksaraItem(latin: 'RA', javanese: 'ꦫ'),
  _AksaraItem(latin: 'KA', javanese: 'ꦏ'),
  _AksaraItem(latin: 'DA', javanese: 'ꦢ'),
  _AksaraItem(latin: 'TA', javanese: 'ꦠ'),
  _AksaraItem(latin: 'SA', javanese: 'ꦱ'),
  _AksaraItem(latin: 'WA', javanese: 'ꦮ'),
  _AksaraItem(latin: 'LA', javanese: 'ꦭ'),
  _AksaraItem(latin: 'PA', javanese: 'ꦥ'),
  _AksaraItem(latin: 'DHA', javanese: 'ꦝ'),
  _AksaraItem(latin: 'JA', javanese: 'ꦗ'),
  _AksaraItem(latin: 'YA', javanese: 'ꦪ'),
  _AksaraItem(latin: 'NYA', javanese: 'ꦚ'),
  _AksaraItem(latin: 'MA', javanese: 'ꦩ'),
  _AksaraItem(latin: 'GA', javanese: 'ꦒ'),
  _AksaraItem(latin: 'BA', javanese: 'ꦧ'),
  _AksaraItem(latin: 'THA', javanese: 'ꦛ'),
  _AksaraItem(latin: 'NGA', javanese: 'ꦔ'),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class AksaraLabScreen extends StatefulWidget {
  const AksaraLabScreen({super.key});

  @override
  State<AksaraLabScreen> createState() => _AksaraLabScreenState();
}

class _AksaraLabScreenState extends State<AksaraLabScreen> {
  int _selectedIndex = 0;
  bool _isDrawing = false;
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];

  _AksaraItem get _selected => _hanacaraka[_selectedIndex];

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _currentStroke = [];
    });
  }

  void _selectAksara(int index) {
    setState(() {
      _selectedIndex = index;
      _strokes.clear();
      _currentStroke = [];
    });
  }

  void _checkWriting() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ResultSheet(
        aksara: _selected,
        strokeCount: _strokes.length,
        totalPoints: _strokes.fold<int>(0, (sum, s) => sum + s.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
      bottomNavigationBar: const _BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Iso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'Jowo',
                style: TextStyle(
                  color: Color(0xFFF6D1A5),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Decorative background
          Opacity(
            opacity: 0.06,
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/6639e9376a4630c7aa92df3f84d2bcee94634ff3?width=1536',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page title
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 2),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Aksara',
                          style: TextStyle(
                            color: Color(0xFFF6D1A5),
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' Lab',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Subtitle
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text(
                    'Pilih aksara sing arep mbok sinaoni. Terus jajal tulis neng kanvas sebelah ngisor kuwi ya!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    physics: _isDrawing
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      children: [
                        // ── Aksara Grid Card ──────────────────────────────
                        _AksaraGridCard(
                          selectedIndex: _selectedIndex,
                          total: _hanacaraka.length,
                          onSelect: _selectAksara,
                        ),
                        const SizedBox(height: 20),
                        // ── Drawing Canvas Card ───────────────────────────
                        _DrawingCanvas(
                          strokes: _strokes,
                          currentStroke: _currentStroke,
                          hintText:
                              'Tulisno aksara ${_selected.latin} (${_selected.javanese}) neng kene',
                          onPanStart: (pos) => setState(() {
                            _isDrawing = true;
                            _currentStroke = [pos];
                          }),
                          onPanUpdate: (pos) => setState(() {
                            _currentStroke.add(pos);
                          }),
                          onPanEnd: () => setState(() {
                            if (_currentStroke.isNotEmpty) {
                              _strokes.add(List.from(_currentStroke));
                            }
                            _isDrawing = false;
                            _currentStroke = [];
                          }),
                          onClear: _clearCanvas,
                        ),
                        const SizedBox(height: 20),
                        // ── Periksa Tulisan Button ────────────────────────
                        _PeriksaButton(onTap: _checkWriting),
                        const SizedBox(height: 8),
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

// ── Aksara Grid Card ──────────────────────────────────────────────────────────

class _AksaraGridCard extends StatelessWidget {
  final int selectedIndex;
  final int total;
  final ValueChanged<int> onSelect;

  const _AksaraGridCard({
    required this.selectedIndex,
    required this.total,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(9, 12),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: total,
            itemBuilder: (_, index) {
              final item = _hanacaraka[index];
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => onSelect(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFF8121)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.javanese,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : Colors.black,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.latin,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Pagination badge
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFC6964B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                '${selectedIndex + 1}/$total',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Drawing Canvas ────────────────────────────────────────────────────────────

class _DrawingCanvas extends StatelessWidget {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;
  final String hintText;
  final ValueChanged<Offset> onPanStart;
  final ValueChanged<Offset> onPanUpdate;
  final VoidCallback onPanEnd;
  final VoidCallback onClear;

  const _DrawingCanvas({
    required this.strokes,
    required this.currentStroke,
    required this.hintText,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = strokes.isEmpty && currentStroke.isEmpty;

    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(9, 12),
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Drawing surface
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: (event) => onPanStart(event.localPosition),
                onPointerMove: (event) => onPanUpdate(event.localPosition),
                onPointerUp: (_) => onPanEnd(),
                onPointerCancel: (_) => onPanEnd(),
                child: CustomPaint(
                  painter: _CanvasPainter(
                    strokes: strokes,
                    currentStroke: currentStroke,
                  ),
                  child: Container(), // needed to fill GestureDetector
                ),
              ),
            ),
            // Hint text
            if (isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    hintText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFBBBBBB),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            // Trash / clear button
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: onClear,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFDDDDDD)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Canvas Painter ────────────────────────────────────────────────────────────

class _CanvasPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;

  const _CanvasPainter({
    required this.strokes,
    required this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      _drawStroke(canvas, paint, stroke);
    }
    _drawStroke(canvas, paint, currentStroke);
  }

  void _drawStroke(Canvas canvas, Paint paint, List<Offset> stroke) {
    if (stroke.length < 2) {
      if (stroke.length == 1) {
        canvas.drawCircle(stroke[0], 2.0, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
      return;
    }
    final path = Path()..moveTo(stroke[0].dx, stroke[0].dy);
    for (int i = 1; i < stroke.length; i++) {
      path.lineTo(stroke[i].dx, stroke[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CanvasPainter old) =>
      old.strokes != strokes || old.currentStroke != currentStroke;
}

// ── Periksa Tulisan Button ────────────────────────────────────────────────────

class _PeriksaButton extends StatelessWidget {
  final VoidCallback onTap;
  const _PeriksaButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFF8121),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(6, 10),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle_outline_rounded,
                color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'Periksa Tulisan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Result Bottom Sheet ───────────────────────────────────────────────────────

class _ResultSheet extends StatelessWidget {
  final _AksaraItem aksara;
  final int strokeCount;
  final int totalPoints;

  const _ResultSheet({
    required this.aksara,
    required this.strokeCount,
    required this.totalPoints,
  });

  int get _score {
    if (strokeCount == 0) return 0;
    // Simulate a score: more strokes & points = richer drawing
    final base = (totalPoints / 10).clamp(0, 40).toInt();
    final strokeBonus = (strokeCount * 8).clamp(0, 40);
    return (base + strokeBonus + 20).clamp(0, 100);
  }

  Color get _scoreColor {
    if (_score >= 80) return const Color(0xFF4CAF50);
    if (_score >= 60) return const Color(0xFFFF8121);
    return const Color(0xFFE53935);
  }

  String get _feedbackText {
    if (strokeCount == 0) {
      return 'Tulisno aksaramu neng kanvas dhisit ya!';
    }
    if (_score >= 80) return 'Apik banget! Tulisanmu wis apik!';
    if (_score >= 60) return 'Lumayan! Latihan maneh supaya luwih apik!';
    return 'Isih perlu latihan akeh. Aja nyerah ya!';
  }

  String get _emoji {
    if (strokeCount == 0) return '✏️';
    if (_score >= 80) return '🎉';
    if (_score >= 60) return '👍';
    return '💪';
  }

  @override
  Widget build(BuildContext context) {
    final noDrawing = strokeCount == 0;

    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Aksara preview
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF9EAD7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0C9A0), width: 1.5),
            ),
            child: Center(
              child: Text(
                aksara.javanese,
                style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF13324E),
                  height: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Aksara name
          Text(
            '${aksara.javanese}  ·  ${aksara.latin}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF13324E),
            ),
          ),
          const SizedBox(height: 20),

          if (noDrawing) ...[
            // No drawing state
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('✏️', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Tulisno aksaramu neng kanvas dhisit ya!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF795548),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Score card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9EAD7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        _emoji,
                        style: const TextStyle(fontSize: 36),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Skor Tulisanmu',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_score / 100',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: _scoreColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: _score / 100,
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(_scoreColor),
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Feedback
                  Text(
                    _feedbackText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF13324E),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Stats row
            Row(
              children: [
                _StatChip(
                  label: 'Jumlah Goresan',
                  value: '$strokeCount',
                  icon: Icons.gesture_rounded,
                ),
                const SizedBox(width: 10),
                _StatChip(
                  label: 'Total Titik',
                  value: '$totalPoints',
                  icon: Icons.timeline_rounded,
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8121),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Tutup',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF13324E)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF13324E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom Nav Bar (same style as HomeScreen)
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

// ── Preview ───────────────────────────────────────────────────────────────────

// ignore: unused_element
Widget _preview() => const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AksaraLabScreen(),
    );
