import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// ── Data Model ────────────────────────────────────────────────────────────────

class _SongItem {
  final String title;
  final String duration;
  final int totalSeconds;
  final String audioUrl;

  const _SongItem({
    required this.title,
    required this.duration,
    required this.totalSeconds,
    required this.audioUrl,
  });
}

const List<_SongItem> _playlist = [
  _SongItem(
    title: 'Gendhang Chill - Relaxation',
    duration: '03:14',
    totalSeconds: 194,
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ),
  _SongItem(
    title: 'Gendhang Macapat',
    duration: '03:45',
    totalSeconds: 225,
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ),
  _SongItem(
    title: 'Gendhing Bonang',
    duration: '02:20',
    totalSeconds: 140,
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ),
  _SongItem(
    title: 'Gendhing Babat Layar',
    duration: '04:14',
    totalSeconds: 254,
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class GendingChillScreen extends StatefulWidget {
  const GendingChillScreen({super.key});

  @override
  State<GendingChillScreen> createState() => _GendingChillScreenState();
}

class _GendingChillScreenState extends State<GendingChillScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _isSwitchingTrack = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  String? _audioError;

  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<void>? _completeSub;
  late AnimationController _pulseController;

  static const _orange = Color(0xFFFF8121);
  static const _cardBg = Color(0xFFD9D9D9);
  static const _darkBg = Color(0xFF13324E);

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _playerStateSub = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _isPlaying = state == PlayerState.playing);
    });

    _positionSub = _audioPlayer.onPositionChanged.listen((position) {
      if (!mounted) return;
      setState(() => _currentPosition = position);
    });

    _durationSub = _audioPlayer.onDurationChanged.listen((duration) {
      if (!mounted) return;
      setState(() => _totalDuration = duration);
    });

    _completeSub = _audioPlayer.onPlayerComplete.listen((_) {
      _nextSong(triggeredByComplete: true);
    });
  }

  @override
  void dispose() {
    _playerStateSub?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    _completeSub?.cancel();
    _audioPlayer.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ── Playback helpers ──────────────────────────────────────────────────────

  Future<void> _togglePlay() async {
    if (_isSwitchingTrack) return;
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        final state = _audioPlayer.state;
        if (state == PlayerState.paused && _currentPosition > Duration.zero) {
          await _audioPlayer.resume();
        } else {
          await _playCurrentSong();
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _audioError = 'Gagal memutar audio: $e');
    }
  }

  Future<bool> _playCurrentSong() async {
    final song = _playlist[_currentIndex];
    setState(() {
      _audioError = null;
      _currentPosition = Duration.zero;
      _totalDuration = Duration(seconds: song.totalSeconds);
    });
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(song.audioUrl));
      return true;
    } catch (e) {
      if (!mounted) return false;
      setState(() {
        _isPlaying = false;
        _audioError =
            'Audio gagal diputar. Cek koneksi internet atau coba lagu lain. Detail: $e';
      });
      return false;
    }
  }

  Future<void> _selectSong(int index) async {
    if (_isSwitchingTrack) return;
    _isSwitchingTrack = true;
    setState(() {
      _currentIndex = index;
      _currentPosition = Duration.zero;
      _totalDuration = Duration(seconds: _playlist[index].totalSeconds);
      _audioError = null;
    });
    await _playCurrentSong();
    _isSwitchingTrack = false;
  }

  Future<void> _prevSong() async {
    final prev = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await _selectSong(prev);
  }

  Future<void> _nextSong({bool triggeredByComplete = false}) async {
    if (_isSwitchingTrack) return;
    final next = (_currentIndex + 1) % _playlist.length;
    if (triggeredByComplete && _audioError != null) return;
    await _selectSong(next);
  }

  Future<void> _seekTo(double value) async {
    if (_isSwitchingTrack) return;
    final total = _effectiveDuration;
    final targetMs = (value.clamp(0.0, 1.0) * total.inMilliseconds).round();
    try {
      await _audioPlayer.seek(Duration(milliseconds: targetMs));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _audioError = 'Gagal geser posisi lagu: $e';
      });
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Duration get _effectiveDuration {
    if (_totalDuration > Duration.zero) return _totalDuration;
    return Duration(seconds: _playlist[_currentIndex].totalSeconds);
  }

  double get _progress {
    final totalMs = _effectiveDuration.inMilliseconds;
    if (totalMs == 0) return 0.0;
    return (_currentPosition.inMilliseconds / totalMs).clamp(0.0, 1.0);
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background pattern
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
                _buildTopBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Page title
                        const Text(
                          'Gendhing Chill',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Dengarkan audio lantunan khas Jawa tradisional',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Player card
                        _buildPlayerCard(),
                        const SizedBox(height: 20),
                        // Playlist card
                        _buildPlaylistCard(),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom nav bar (pinned)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(context),
          ),
        ],
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const Spacer(),
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
    );
  }

  // ── Player Card ───────────────────────────────────────────────────────────

  Widget _buildPlayerCard() {
    final song = _playlist[_currentIndex];
    final elapsed = _formatTime(_currentPosition.inSeconds);
    final duration = _formatTime(_effectiveDuration.inSeconds);

    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 9.2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        children: [
          // Song title
          Text(
            song.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _orange,
            ),
          ),
          const SizedBox(height: 16),
          // Album art
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 6.4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://api.builder.io/api/v1/image/assets/TEMP/22af3de5985f81de237bf3a88b7b34d83f1e7e2d?width=456',
                width: 228,
                height: 228,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          if (_audioError != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECEC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _audioError!,
                style: const TextStyle(
                  color: Color(0xFF8E2A2A),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skip previous
              GestureDetector(
                onTap: () => _prevSong(),
                child: const Icon(
                  Icons.skip_previous_rounded,
                  color: _orange,
                  size: 36,
                ),
              ),
              const SizedBox(width: 20),
              // Play / Pause
              GestureDetector(
                onTap: () => _togglePlay(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _orange,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x60000000),
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Skip next
              GestureDetector(
                onTap: () => _nextSong(),
                child: const Icon(
                  Icons.skip_next_rounded,
                  color: _orange,
                  size: 36,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: _orange,
                  inactiveTrackColor: const Color(0x3D000000),
                  thumbColor: _orange,
                  overlayColor: const Color(0x30FF8121),
                ),
                child: Slider(
                  value: _progress.clamp(0.0, 1.0),
                  onChanged: (v) => _seekTo(v),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      elapsed,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      duration,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Playlist Card ─────────────────────────────────────────────────────────

  Widget _buildPlaylistCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 9.2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Playlist',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _orange,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_playlist.length, (i) => _buildPlaylistItem(i)),
        ],
      ),
    );
  }

  Widget _buildPlaylistItem(int index) {
    final song = _playlist[index];
    final isActive = index == _currentIndex;

    return GestureDetector(
      onTap: () => _selectSong(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // Icon button
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isActive ? _orange.withValues(alpha: 0.85) : _orange,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isActive
                    ? [
                        const BoxShadow(
                          color: Color(0x50FF8121),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                    : null,
              ),
              child: isActive && _isPlaying
                  ? _buildEqIcon()
                  : const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
            ),
            const SizedBox(width: 14),
            // Title & duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color:
                          isActive ? const Color(0xFF13324E) : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    song.duration,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isActive ? _orange : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Active indicator
            if (isActive)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _orange,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Animated equalizer bars shown when song is actively playing
  Widget _buildEqIcon() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (_, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(3, (i) {
              final heights = [0.5, 1.0, 0.7];
              final phase = (i * 0.33 + _pulseController.value).clamp(0.0, 1.0);
              final h = (8 + 10 * phase * heights[i]).clamp(4.0, 18.0);
              return Container(
                width: 3,
                height: h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // ── Bottom Nav Bar ────────────────────────────────────────────────────────

  Widget _buildBottomNav(BuildContext context) {
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
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.home_rounded,
                size: 34, color: Color(0xFFC6964B)),
          ),
          const Icon(Icons.search_rounded, size: 30, color: Colors.black),
          const Icon(Icons.person_outline_rounded,
              size: 30, color: Colors.black),
          const Icon(Icons.settings_outlined, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}
