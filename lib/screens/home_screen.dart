import 'package:flutter/material.dart';
import 'package:isojowo_app/screens/pepak_battle_screen.dart';
import 'package:isojowo_app/screens/pengaturan_screen.dart';
import 'package:isojowo_app/screens/profil_screen.dart';
import 'aksara_lab_screen.dart';
import 'auto_alus_screen.dart';
import 'flash_jowo_screen.dart';
import 'gendhing_chill_screen.dart';
import 'njawi_look_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13324E),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                _HomeBody(),
                _PlaceholderBody(),
                ProfilScreen(),
                PengaturanScreen(),
              ],
            ),
          ),
          _BottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
          ),
        ],
      ),
    );
  }
}

// ── Home tab body ──
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  static const List<_FeatureItem> _features = [
    _FeatureItem(
      title: 'Njawi Look',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/6f7a5b7279644a7a015da54d5432c56bdb70aebd?width=118',
      imageWidth: 59,
      imageHeight: 54,
    ),
    _FeatureItem(
      title: 'Aksara Lab',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/85da81e5693159ed37fc7a80c87ce3d532d58954?width=161',
      imageWidth: 81,
      imageHeight: 35,
    ),
    _FeatureItem(
      title: 'Pepak Battle',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/21fc0c93652cbe3ce5cab8463004a4d11aa3b05c?width=220',
      imageWidth: 110,
      imageHeight: 85,
    ),
    _FeatureItem(
      title: 'Auto Alus',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/f565e6e3ee9dca6873a7959b8205f183c7521b35?width=178',
      imageWidth: 89,
      imageHeight: 89,
    ),
    _FeatureItem(
      title: 'Flash Jowo',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/b8d7537faafda11d8d989010de88b045bdcd29e8?width=164',
      imageWidth: 82,
      imageHeight: 80,
    ),
    _FeatureItem(
      title: 'Gendhing Chill',
      imageUrl:
          'https://api.builder.io/api/v1/image/assets/TEMP/479aa0cf59b3659f9e58404039d11574919a92e3?width=66',
      imageWidth: 82,
      imageHeight: 80,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background decorative image
        Opacity(
          opacity: 0.08,
          child: Image.network(
            'https://api.builder.io/api/v1/image/assets/TEMP/f1828b978e690114101e186b725d52bdaac93ff7?width=1536',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
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
                    // Profile icon
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    children: [
                      // Banner
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          'https://api.builder.io/api/v1/image/assets/TEMP/76400301b2432ce261624fd48686855d44ad3f89?width=680',
                          width: double.infinity,
                          height: 187,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Feature grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 161 / 158,
                            ),
                        itemCount: _features.length,
                        itemBuilder: (context, index) {
                          return _FeatureCard(item: _features[index]);
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
}

// ── Placeholder for tabs not yet implemented ──
class _PlaceholderBody extends StatelessWidget {
  const _PlaceholderBody();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Segera Hadir',
        style: TextStyle(
          color: Colors.white54,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ---- Feature Card ----

class _FeatureItem {
  final String title;
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;

  const _FeatureItem({
    required this.title,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem item;

  const _FeatureCard({required this.item});

  void _handleTap(BuildContext context) {
    if (item.title == 'Njawi Look') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NjawiLookScreen()),
      );
    } else if (item.title == 'Aksara Lab') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AksaraLabScreen()),
      );
    } else if (item.title == 'Auto Alus') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AutoAlusScreen()),
      );
    } else if (item.title == 'Flash Jowo') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FlashJowoScreen()),
      );
    } else if (item.title == 'Pepak Battle') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PepakBattleScreen()),
      );
    } else if (item.title == 'Gendhing Chill') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GendingChillScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9EAD7),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              item.imageUrl,
              width: item.imageWidth,
              height: item.imageHeight,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_not_supported_outlined,
                size: 48,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Bottom Nav Bar ----

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

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
          _NavItem(
            icon: Icons.home_rounded,
            isSelected: selectedIndex == 0,
            onTap: () => onTap(0),
            activeColor: const Color(0xFFC6964B),
          ),
          _NavItem(
            icon: Icons.search_rounded,
            isSelected: selectedIndex == 1,
            onTap: () => onTap(1),
            activeColor: const Color(0xFFC6964B),
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            isSelected: selectedIndex == 2,
            onTap: () => onTap(2),
            activeColor: const Color(0xFFC6964B),
          ),
          _NavItem(
            icon: Icons.settings_outlined,
            isSelected: selectedIndex == 3,
            onTap: () => onTap(3),
            activeColor: const Color(0xFFC6964B),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Icon(
          icon,
          size: 32,
          color: isSelected ? activeColor : Colors.black,
        ),
      ),
    );
  }
}

// ignore: unused_element
Widget _preview() => const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
