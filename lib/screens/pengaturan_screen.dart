import 'package:flutter/material.dart';
import '../providers/theme_notifier.dart';
import '../theme/app_theme.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Batik background decoration ──────────────────────────
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Page title ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: colors.titleText,
                    letterSpacing: -1.0,
                  ),
                ),
              ),

              // ── Scrollable body ───────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Section: Akun ─────────────────────────
                      _SectionLabel(label: 'Akun', colors: colors),
                      const SizedBox(height: 10),
                      _SettingsCard(
                        children: [
                          _SettingsRow(
                            label: 'Ubah Detail Akun',
                            colors: colors,
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Section: Aplikasi ──────────────────────
                      _SectionLabel(label: 'Aplikasi', colors: colors),
                      const SizedBox(height: 10),
                      _SettingsCard(
                        children: [
                          // Theme toggle row
                          _ThemeToggleRow(colors: colors),
                          _RowDivider(color: colors.divider),
                          _SettingsRow(
                            label: 'Notifikasi',
                            colors: colors,
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Section: Dukungan dan Legal ────────────
                      _SectionLabel(
                          label: 'Dukungan dan Legal', colors: colors),
                      const SizedBox(height: 10),
                      _SettingsCard(
                        children: [
                          _SettingsRow(
                            label: 'Hubungi Kami',
                            colors: colors,
                            onTap: () {},
                          ),
                          _RowDivider(color: colors.divider),
                          _SettingsRow(
                            label: 'Kebijakan Privasi',
                            colors: colors,
                            onTap: () {},
                          ),
                          _RowDivider(color: colors.divider),
                          _SettingsRow(
                            label: 'Tentang Aplikasi',
                            colors: colors,
                            onTap: () {
                              _showTentangDialog(context, colors);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // ── Keluar Button ──────────────────────────
                      _KeluarButton(
                        onTap: () {
                          _showLogoutDialog(context, colors);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, AppColors colors) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
        title: Text(
          'Keluar',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: colors.cardText,
            fontSize: 20,
          ),
        ),
        content: Text(
          'Apa kowe yakin arep metu saka akun iki?',
          style: TextStyle(color: colors.cardText, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Ora',
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD02E2E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Ya, Keluar',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _showTentangDialog(BuildContext context, AppColors colors) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
        title: Text(
          'Tentang Aplikasi',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: colors.cardText,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IsoJowo',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: colors.accent,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Versi 1.0.0',
              style: TextStyle(color: colors.cardText, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Aplikasi kanggo sinau basa lan budaya Jawa kanthi cara sing nyenengake.',
              style: TextStyle(
                color: colors.cardText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.accent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Tutup',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Section label
// ─────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  final AppColors colors;

  const _SectionLabel({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.sectionText,
        letterSpacing: -0.8,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Settings card – groups multiple rows
// ─────────────────────────────────────────────────────────────────

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 9.2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Single settings row with label + chevron
// ─────────────────────────────────────────────────────────────────

class _SettingsRow extends StatelessWidget {
  final String label;
  final AppColors colors;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.label,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: colors.cardText,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 28,
              color: colors.cardText,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Theme toggle row (Dark / Light segmented picker)
// ─────────────────────────────────────────────────────────────────

class _ThemeToggleRow extends StatelessWidget {
  final AppColors colors;

  const _ThemeToggleRow({required this.colors});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.instance,
      builder: (context, themeMode, _) {
        final isDark = themeMode == ThemeMode.dark;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Tema',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: colors.cardText,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              // Segmented toggle
              Container(
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dark segment
                    GestureDetector(
                      onTap: () => ThemeNotifier.instance.setDark(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF13324E)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20)),
                        ),
                        child: Text(
                          'Dark',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : colors.cardText,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                    ),
                    // Light segment
                    GestureDetector(
                      onTap: () => ThemeNotifier.instance.setLight(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: !isDark
                              ? const Color(0xFFF9EAD7)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(20)),
                        ),
                        child: Text(
                          'Light',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: !isDark
                                ? const Color(0xFF13324E)
                                : colors.cardText,
                            letterSpacing: -0.4,
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
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Thin divider between rows
// ─────────────────────────────────────────────────────────────────

class _RowDivider extends StatelessWidget {
  final Color color;

  const _RowDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: color,
      indent: 18,
      endIndent: 18,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Keluar (Logout) button
// ─────────────────────────────────────────────────────────────────

class _KeluarButton extends StatelessWidget {
  final VoidCallback onTap;

  const _KeluarButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFD02E2E),
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
            'Keluar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF3EDE7),
              letterSpacing: -1.0,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Preview ───────────────────────────────────────────────────────────────────

class PengaturanScreenPreview extends StatelessWidget {
  const PengaturanScreenPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.instance,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const Scaffold(
            body: PengaturanScreen(),
          ),
        );
      },
    );
  }
}

// ignore: unused_element
Widget get _preview => const PengaturanScreenPreview();
