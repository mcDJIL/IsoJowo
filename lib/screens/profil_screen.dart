import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Batik background texture
        Opacity(
          opacity: 0.08,
          child: Image.network(
            'https://api.builder.io/api/v1/image/assets/TEMP/af2f31244a96780af8e5d3b99364e6047be00948?width=1536',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Profile Avatar ──
                _ProfileAvatar(),
                const SizedBox(height: 18),

                // ── Name ──
                const Text(
                  'Mahesa Jenar',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEBDECE),
                    letterSpacing: -1.6,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 2),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Level Progress Bar ──
                _LevelBar(),
                const SizedBox(height: 16),

                // ── Stat Cards ──
                _StatCardsRow(),
                const SizedBox(height: 28),

                // ── Achievement Badges ──
                _AchievementsSection(),
                const SizedBox(height: 28),

                // ── Edit Profil Button ──
                _EditProfilButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Profile Avatar with gold ring
// ─────────────────────────────────────────────
class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 168,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFC6964B),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          'https://api.builder.io/api/v1/image/assets/TEMP/761ce53b01b8d64956b25f4c134273b265caa249?width=374',
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) => progress == null
              ? child
              : Container(
                  color: const Color(0xFF1E4A6E),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFC6964B),
                      strokeWidth: 2,
                    ),
                  ),
                ),
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFF1E4A6E),
            child: const Icon(
              Icons.person_rounded,
              size: 72,
              color: Color(0xFFC6964B),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Level + XP Progress Bar
// ─────────────────────────────────────────────
class _LevelBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Level 5',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              '35%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            // Background track
            Container(
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.30),
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            // Progress fill
            FractionallySizedBox(
              widthFactor: 0.35,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8121),
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Row of 3 Stat Cards
// ─────────────────────────────────────────────
class _StatCardsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _StatCard(
            label: 'Skor\nPepak Battle',
            value: '15200',
            icon: _CoinIcon(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'Aksara\nTertulis',
            value: '13',
            icon: _PenIcon(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'Koleksi\nNjawi Look',
            value: '5',
            icon: _SheetIcon(),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Widget icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9EAD7),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF000000),
            blurRadius: 9.2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 3),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Stat card icons (custom SVG-like via Canvas)
// ─────────────────────────────────────────────
class _CoinIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.monetization_on_rounded,
      color: Color(0xFFC6964B),
      size: 20,
    );
  }
}

class _PenIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.draw_rounded,
      color: Color(0xFFC6964B),
      size: 20,
    );
  }
}

class _SheetIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.content_paste_rounded,
      color: Color(0xFFC6964B),
      size: 20,
    );
  }
}

// ─────────────────────────────────────────────
// Lencana Pencapaian Section
// ─────────────────────────────────────────────
class _AchievementsSection extends StatelessWidget {
  static const _badges = [
    _BadgeData(
      label: 'Aksara\nMaster',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/fa6e2f348b861e6ad14b7ee3dbefbd8d9c81855c?width=160',
    ),
    _BadgeData(
      label: 'Pepak\nWarrior',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/f8981ba2bd4bfdde544ea3d8f60777707ee1631c?width=160',
    ),
    _BadgeData(
      label: 'Pepak\nMaster',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/edb1ae2179ef8778b7311377e015290bf4efedd3?width=160',
    ),
    _BadgeData(
      label: 'Macapat\nLover',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/7ddf42ae7e276da3f1ed9dc9d0e67a0e04a39a5c?width=160',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text(
          'Lencana Pencapaian',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFF3EDE7),
            letterSpacing: -1.0,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
        const SizedBox(height: 16),
        // Badge row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _badges
              .map((badge) => _BadgeWidget(badge: badge))
              .toList(),
        ),
      ],
    );
  }
}

class _BadgeData {
  final String label;
  final String imageUrl;

  const _BadgeData({required this.label, required this.imageUrl});
}

class _BadgeWidget extends StatelessWidget {
  final _BadgeData badge;

  const _BadgeWidget({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              badge.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF1E4A6E),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Color(0xFFC6964B),
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badge.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF3EDE7),
            letterSpacing: -0.28,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Edit Profil Button
// ─────────────────────────────────────────────
class _EditProfilButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to edit profile screen
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFC6964B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1),
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
            'Edit Profil',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF3EDE7),
              letterSpacing: -1.2,
            ),
          ),
        ),
      ),
    );
  }
}
