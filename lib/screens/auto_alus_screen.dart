import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoAlusScreen extends StatefulWidget {
  const AutoAlusScreen({super.key});

  @override
  State<AutoAlusScreen> createState() => _AutoAlusScreenState();
}

class _AutoAlusScreenState extends State<AutoAlusScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _outputText = '';

  // -----------------------------------------------------------------------
  // Kamus Ngoko -> Krama Alus
  // -----------------------------------------------------------------------
  static const Map<String, String> _kamus = {
    // Ganti orang
    'aku': 'kula',
    'saya': 'kula',
    'kowe': 'panjenengan',
    'sampean': 'panjenengan',
    'sampeyan': 'panjenengan',
    'awakmu': 'panjenengan',
    'dheweke': 'piyambakipun',
    'deweke': 'piyambakipun',
    'kita': 'kita',
    'kito': 'kita',
    'kami': 'kawula',
    'kabeh': 'sedaya',

    // Sapaan
    'pak': 'bapak',
    'bu': 'ibu',
    'mas': 'mas',
    'mbak': 'mbakyu',
    'kangmas': 'kangmas',
    'adik': 'adik',

    // Kata kerja umum
    'arep': 'badhe',
    'mau': 'badhe',
    'pengen': 'kepengin',
    'kepingin': 'kepengin',
    'lunga': 'tindak',
    'lungo': 'tindak',
    'teka': 'rawuh',
    'teko': 'rawuh',
    'tuku': 'tumbas',
    'dodol': 'sade',
    'mangan': 'dhahar',
    'ngombe': 'ngunjuk',
    'turu': 'sare',
    'tangi': 'wungu',
    'mlaku': 'tindak',
    'mlayu': 'mlayu',
    'maca': 'maos',
    'nulis': 'nyerat',
    'ngomong': 'ngendika',
    'omong': 'ngendika',
    'ngandika': 'ngendika',
    'weruh': 'pirsa',
    'ngerti': 'mangertos',
    'reti': 'mangertos',
    'eruh': 'pirsa',
    'ndelok': 'mirsani',
    'ndeleng': 'mirsani',
    'krungu': 'mireng',
    'rungokake': 'mirengaken',
    'kandha': 'ngendika',
    'takon': 'nyuwun pirsa',
    'jaluk': 'nyuwun',
    'njaluk': 'nyuwun',
    'nyuwun': 'nyuwun',
    'menehi': 'maringi',
    'weneh': 'maringi',
    'gawa': 'bekta',
    'nggawa': 'mbekta',
    'golek': 'pados',
    'ngolek': 'madosi',
    'jupuk': 'mendhet',
    'njupuk': 'mendhet',
    'simpen': 'nyimpen',
    'mulih': 'wangsul',
    'bali': 'wangsul',
    'metu': 'medal',
    'mlebu': 'mlebet',
    'dolan': 'tindak dolan',
    'ngaji': 'ngaji',
    'sinau': 'sinau',
    'garap': 'damel',
    'gawe': 'damel',
    'nggawe': 'damel',
    'kerja': 'nyambut damel',
    'nyambut': 'nyambut',
    'mbantu': 'mbiyantu',
    'bantu': 'biyantu',
    'blanja': 'belanja',
    'masak': 'olah-olah',
    'nyapu': 'nyaponi',
    'adus': 'adus',
    'ngantuk': 'ngantuk',
    'lara': 'gerah',
    'loro': 'gerah',
    'waras': 'sehat',
    'mati': 'seda',
    'urip': 'gesang',
    'lair': 'miyos',

    // Kata sifat
    'apik': 'sae',
    'apek': 'sae',
    'becik': 'sae',
    'elek': 'awon',
    'ala': 'awon',
    'gedhe': 'ageng',
    'gede': 'ageng',
    'cilik': 'alit',
    'kecil': 'alit',
    'dawa': 'panjang',
    'cendhek': 'cekak',
    'cendak': 'cekak',
    'akeh': 'kathah',
    'sithik': 'sekedhik',
    'sitik': 'sekedhik',
    'anyar': 'enggal',
    'lawas': 'lami',
    'tuwa': 'sepuh',
    'enom': 'enem',
    'pinter': 'pinter',
    'bodho': 'kirang wasis',
    'alon': 'alon',
    'cepet': 'enggal',
    'adoh': 'tebih',
    'cedhak': 'caket',
    'cerak': 'caket',
    'banter': 'santer',
    'rame': 'rame',
    'sepi': 'sepi',
    'larang': 'awis',
    'murah': 'mirah',
    'seneng': 'remen',
    'sedih': 'susah',
    'bungah': 'bingah',
    'susah': 'susah',
    'isin': 'isin',
    'wedi': 'ajrih',
    'wani': 'wantun',
    'kesel': 'sayah',
    'loyo': 'ringkih',
    'kuat': 'kiyat',
    'lemu': 'lemu',
    'kuru': 'kuru',
    'ayu': 'ayu',
    'bagus': 'bagus',
    'resik': 'resik',
    'reged': 'reged',

    // Kata keterangan
    'wis': 'sampun',
    'wes': 'sampun',
    'durung': 'dereng',
    'lagi': 'saweg',
    'isih': 'taksih',
    'sik': 'taksih',
    'ora': 'mboten',
    'gak': 'mboten',
    'nggak': 'mboten',
    'ndak': 'mboten',
    'iya': 'inggih',
    'iyo': 'inggih',
    'ya': 'inggih',
    'yo': 'inggih',
    'mengko': 'mangke',
    'mbesuk': 'benjing',
    'sesuk': 'benjing',
    'wingi': 'kala wau',
    'biyen': 'rumiyin',
    'saiki': 'sakmenika',
    'saike': 'sakmenika',
    'seiki': 'sakmenika',
    'siki': 'sakmenika',
    'mung': 'namung',
    'bae': 'kemawon',
    'wae': 'kemawon',
    'ae': 'kemawon',
    'maneh': 'malih',
    'meneh': 'malih',
    'kudu': 'kedah',
    'karo': 'kaliyan',
    'lan': 'saha',
    'utawa': 'utawi',
    'opo': 'menapa',
    'apa': 'menapa',
    'sopo': 'sinten',
    'sapa': 'sinten',
    'kapan': 'kapan',
    'piye': 'kados pundi',
    'ngopo': 'kenging menapa',
    'ngapa': 'kenging menapa',
    'kenopo': 'kenging menapa',
    'kenapa': 'kenging menapa',
    'ngendi': 'wonten pundi',
    'nandi': 'wonten pundi',
    'neng': 'wonten',
    'ning': 'wonten',
    'ing': 'wonten',
    'ana': 'wonten',
    'ono': 'wonten',
    'nang': 'wonten',
    'saka': 'saking',
    'dari': 'saking',
    'menyang': 'dhateng',
    'marang': 'dhateng',
    'kanggo': 'kangge',
    'kango': 'kangge',
    'nggo': 'kangge',
    'supaya': 'supados',
    'ben': 'supados',
    'amarga': 'amargi',
    'merga': 'amargi',
    'soale': 'amargi',
    'nanging': 'ananging',
    'tapi': 'ananging',
    'terus': 'lajeng',
    'banjur': 'lajeng',
    'langsung': 'langsung',
    'padha': 'sami',
    'podo': 'sami',

    // Kata benda
    'omah': 'griya',
    'omahe': 'griyane',
    'omahku': 'griya kula',
    'sekolah': 'sekolah',
    'pasar': 'peken',
    'warung': 'warung',
    'dalan': 'margi',
    'kali': 'lepen',
    'alas': 'wana',
    'sawah': 'sabin',
    'kebun': 'kebon',
    'desa': 'dhusun',
    'kutha': 'kitha',
    'negara': 'negari',
    'buku': 'buku',
    'serat': 'serat',
    'kaos': 'rasukan',
    'klambi': 'rasukan',
    'celana': 'kain',
    'sepatu': 'setopel',
    'sandal': 'selop',
    'pangan': 'dhahar',
    'panganan': 'dhaharan',
    'wedang': 'unjukan',
    'banyu': 'toya',
    'motor': 'motor',
    'mobil': 'kendaraan',
    'pit': 'pit',
    'peso': 'lading',
    'piring': 'piring',
    'gelas': 'gelas',
    'kasur': 'kasur',
    'kursi': 'kursi',
    'meja': 'meja',
    'lemari': 'lemari',
    'tangan': 'asta',
    'sikil': 'suku',
    'suku': 'suku',
    'sirah': 'mustaka',
    'gulu': 'jangga',
    'weteng': 'padharan',
    'ati': 'manah',
    'badan': 'badan',
    'irung': 'grana',
    'mata': 'mripat',
    'kuping': 'talingan',
    'cangkem': 'tutuk',
    'untu': 'waos',
    'rambut': 'rikma',
    'anak': 'putra',
    'bapak': 'bapak',
    'ibu': 'ibu',
    'sedulur': 'sedherek',
    'adhik': 'adhi',
    'kakang': 'kakang',
    'mbah': 'eyang',
    'uwong': 'tiyang',
    'wong': 'tiyang',
    'bocah': 'lare',
    'priya': 'kakung',
    'wedok': 'estri',
    'bojone': 'semahipun',
    'bojo': 'semah',
    'kanca': 'kanca',
    'konco': 'rencang',
    'guru': 'guru',
    'dokter': 'dokter',

    // Angka
    'siji': 'setunggal',
    'loroo': 'kalih',
    'telu': 'tiga',
    'papat': 'sekawan',
    'lima': 'gangsal',
    'enem': 'enem',
    'pitu': 'pitu',
    'wolu': 'wolu',
    'songo': 'songo',
    'sepuluh': 'sedasa',

    // Kata lain
    'iki': 'menika',
    'ini': 'menika',
    'iku': 'menika',
    'itu': 'menika',
    'kae': 'menika',
    'kono': 'mrika',
    'kene': 'mriki',
    'ngono': 'mekaten',
    'ngene': 'mekaten',
    'mengkono': 'mekaten',
    'mengkene': 'mekaten',
    'matur': 'matur',
    'nuwun': 'nuwun',
    'suwun': 'matur nuwun',
    'maturnuwun': 'matur nuwun',
    'mangga': 'mangga',
    'monggo': 'mangga',
    'mpun': 'sampun',
    'dereng': 'dereng',
    'pirsa': 'pirsa',
    'kagem': 'kangge',
    'dalem': 'kula',
    'panjenengan': 'panjenengan',
  };

  // -----------------------------------------------------------------------
  // Logika Translate
  // -----------------------------------------------------------------------
  String _translateToKrama(String input) {
    if (input.trim().isEmpty) return '';

    final sentences = input.split(RegExp(r'(?<=[.!?])\s+'));
    final List<String> translatedSentences = [];

    for (final sentence in sentences) {
      final words = sentence.split(RegExp(r'\s+'));
      final List<String> translatedWords = [];

      for (final rawWord in words) {
        if (rawWord.isEmpty) continue;

        // Pisahkan tanda baca akhir
        final trailingPunct = RegExp(r'[.,!?;:]+$');
        final punct = trailingPunct.stringMatch(rawWord) ?? '';
        final word = rawWord.replaceAll(trailingPunct, '');

        final lower = word.toLowerCase();
        final translation = _kamus[lower];

        if (translation != null) {
          // Pertahankan huruf kapital awal kalimat
          final translated =
              word[0].toUpperCase() == word[0] && word.isNotEmpty
                  ? '${translation[0].toUpperCase()}${translation.substring(1)}'
                  : translation;
          translatedWords.add('$translated$punct');
        } else {
          translatedWords.add(rawWord);
        }
      }

      translatedSentences.add(translatedWords.join(' '));
    }

    return translatedSentences.join(' ');
  }

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      setState(() {
        _outputText = _translateToKrama(_inputController.text);
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _hapusInput() {
    _inputController.clear();
    setState(() {
      _outputText = '';
    });
  }

  void _copyOutput() {
    if (_outputText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _outputText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Teks Krama Alus disalin!'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFC6964B),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? Colors.white : const Color(0xFF13324E);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background decorative image
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
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryTextColor,
                          size: 24,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Iso',
                              style: TextStyle(
                                fontFamily: 'Noto Sans Javanese',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: primaryTextColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Jowo',
                              style: TextStyle(
                                fontFamily: 'Noto Sans Javanese',
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

                // ---- Scrollable Body ----
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Page title
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Auto',
                                style: TextStyle(
                                  fontFamily: 'Noto Sans Javanese',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF6D1A5),
                                ),
                              ),
                              TextSpan(
                                text: ' Alus',
                                style: TextStyle(
                                  fontFamily: 'Noto Sans Javanese',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: primaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        Text(
                          'Gak perlu takut kualat pas ngomong sama wong tuo. Ketik Ngoko, langsung dadi Krama Alus!',
                          style: TextStyle(
                            fontFamily: 'Noto Sans Javanese',
                            fontSize: 13,
                            color: primaryTextColor,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ---- Ngoko Card (Input) ----
                        _TranslatorCard(
                          label: 'Ngoko (Kasar)',
                          badgeLabel: 'Input',
                          badgeColor: const Color(0xFFBF8E49),
                          cardColor: const Color(0xFFD9D9D9),
                          textAreaColor: const Color(0xFFBF8E4936),
                          charCount: _inputController.text.length,
                          showClear: true,
                          onClear: _hapusInput,
                          child: TextField(
                            controller: _inputController,
                            maxLines: 8,
                            style: const TextStyle(
                              fontFamily: 'Noto Sans Javanese',
                              fontSize: 13,
                              color: Color(0xFF373737),
                              height: 1.8,
                            ),
                            decoration: const InputDecoration(
                              hintText:
                                  'Ketik ukoro boso jowo ngoko neng kene...\nContoh :\nPak aku arep dolan neng Surabaya',
                              hintStyle: TextStyle(
                                fontFamily: 'Noto Sans Javanese',
                                fontSize: 13,
                                color: Color(0xFF373737),
                                height: 1.8,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ---- Krama Card (Output) ----
                        _TranslatorCard(
                          label: 'Krama (Alus)',
                          badgeLabel: 'Output',
                          badgeColor: const Color(0xFFE0962F),
                          cardColor: const Color(0xFFCBCBCB),
                          textAreaColor: const Color(0xFFCCB28D36),
                          charCount: _outputText.length,
                          showCopy: _outputText.isNotEmpty,
                          onCopy: _copyOutput,
                          child: _outputText.isEmpty
                              ? const Text(
                                  'Hasil konversi bakal metu nang kene...',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans Javanese',
                                    fontSize: 13,
                                    color: Color(0xFF232323),
                                    height: 1.8,
                                  ),
                                )
                              : SelectableText(
                                  _outputText,
                                  style: const TextStyle(
                                    fontFamily: 'Noto Sans Javanese',
                                    fontSize: 13,
                                    color: Color(0xFF232323),
                                    height: 1.8,
                                  ),
                                ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // ---- Bottom Nav Bar ----
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
// Translator Card Widget
// ---------------------------------------------------------------------------
class _TranslatorCard extends StatelessWidget {
  final String label;
  final String badgeLabel;
  final Color badgeColor;
  final Color cardColor;
  final Color textAreaColor;
  final int charCount;
  final bool showClear;
  final bool showCopy;
  final VoidCallback? onClear;
  final VoidCallback? onCopy;
  final Widget child;

  const _TranslatorCard({
    required this.label,
    required this.badgeLabel,
    required this.badgeColor,
    required this.cardColor,
    required this.textAreaColor,
    required this.charCount,
    this.showClear = false,
    this.showCopy = false,
    this.onClear,
    this.onCopy,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(9, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: label + badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Maven Pro',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  badgeLabel,
                  style: const TextStyle(
                    fontFamily: 'Noto Sans Javanese',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Text area box
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 170),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: textAreaColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: child,
          ),
          const SizedBox(height: 10),

          // Footer: char count + action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$charCount karakter',
                style: const TextStyle(
                  fontFamily: 'Noto Sans Javanese',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
              ),
              if (showClear)
                GestureDetector(
                  onTap: onClear,
                  child: const Text(
                    'Hapus',
                    style: TextStyle(
                      fontFamily: 'Noto Sans Javanese',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              if (showCopy)
                GestureDetector(
                  onTap: onCopy,
                  child: Row(
                    children: const [
                      Icon(Icons.copy_rounded, size: 14, color: Colors.black),
                      SizedBox(width: 4),
                      Text(
                        'Salin',
                        style: TextStyle(
                          fontFamily: 'Noto Sans Javanese',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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

// ---------------------------------------------------------------------------
// Preview
// ---------------------------------------------------------------------------
// ignore: unused_element
Widget _preview() => const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AutoAlusScreen(),
    );
