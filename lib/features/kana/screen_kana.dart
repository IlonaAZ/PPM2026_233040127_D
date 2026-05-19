import 'package:flutter/material.dart';

class KanaScreen extends StatefulWidget {
  const KanaScreen({super.key});

  @override
  State<KanaScreen> createState() => _KanaScreenState();
}

class _KanaScreenState extends State<KanaScreen> {
  // 0 = Hiragana, 1 = Katakana, 2 = Kanji
  int _activeTab = 0;

  // Data Hiragana (46 Karakter Standar)
  final List<Map<String, String>> _hiraganaList = [
    {"kana": "あ", "romaji": "A"}, {"kana": "い", "romaji": "I"}, {"kana": "う", "romaji": "U"}, {"kana": "え", "romaji": "E"}, {"kana": "お", "romaji": "O"},
    {"kana": "か", "romaji": "KA"}, {"kana": "き", "romaji": "KI"}, {"kana": "く", "romaji": "KU"}, {"kana": "け", "romaji": "KE"}, {"kana": "こ", "romaji": "KO"},
    {"kana": "さ", "romaji": "SA"}, {"kana": "し", "romaji": "SHI"}, {"kana": "す", "romaji": "SU"}, {"kana": "せ", "romaji": "SE"}, {"kana": "そ", "romaji": "SO"},
    {"kana": "た", "romaji": "TA"}, {"kana": "ち", "romaji": "CHI"}, {"kana": "つ", "romaji": "TSU"}, {"kana": "て", "romaji": "TE"}, {"kana": "と", "romaji": "TO"},
    {"kana": "な", "romaji": "NA"}, {"kana": "に", "romaji": "NI"}, {"kana": "ぬ", "romaji": "NU"}, {"kana": "ね", "romaji": "NE"}, {"kana": "の", "romaji": "NO"},
    {"kana": "は", "romaji": "HA"}, {"kana": "ひ", "romaji": "HI"}, {"kana": "ふ", "romaji": "FU"}, {"kana": "へ", "romaji": "HE"}, {"kana": "ほ", "romaji": "HO"},
    {"kana": "ま", "romaji": "MA"}, {"kana": "み", "romaji": "MI"}, {"kana": "む", "romaji": "MU"}, {"kana": "め", "romaji": "ME"}, {"kana": "も", "romaji": "MO"},
    {"kana": "や", "romaji": "YA"}, {"kana": "", "romaji": ""}, {"kana": "ゆ", "romaji": "YU"}, {"kana": "", "romaji": ""}, {"kana": "よ", "romaji": "YO"},
    {"kana": "ら", "romaji": "RA"}, {"kana": "り", "romaji": "RI"}, {"kana": "る", "romaji": "RU"}, {"kana": "れ", "romaji": "RE"}, {"kana": "ろ", "romaji": "RO"},
    {"kana": "わ", "romaji": "WA"}, {"kana": "", "romaji": ""}, {"kana": "", "romaji": ""}, {"kana": "", "romaji": ""}, {"kana": "を", "romaji": "WO"},
    {"kana": "ん", "romaji": "N"},
  ];

  // Data Katakana (46 Karakter Standar)
  final List<Map<String, String>> _katakanaList = [
    {"kana": "ア", "romaji": "A"}, {"kana": "イ", "romaji": "I"}, {"kana": "ウ", "romaji": "U"}, {"kana": "エ", "romaji": "E"}, {"kana": "オ", "romaji": "O"},
    {"kana": "カ", "romaji": "KA"}, {"kana": "キ", "romaji": "KI"}, {"kana": "ク", "romaji": "KU"}, {"kana": "ケ", "romaji": "KE"}, {"kana": "コ", "romaji": "KO"},
    {"kana": "サ", "romaji": "SA"}, {"kana": "シ", "romaji": "SHI"}, {"kana": "ス", "romaji": "SU"}, {"kana": "セ", "romaji": "SE"}, {"kana": "ソ", "romaji": "SO"},
    {"kana": "タ", "romaji": "TA"}, {"kana": "チ", "romaji": "CHI"}, {"kana": "ツ", "romaji": "TSU"}, {"kana": "テ", "romaji": "TE"}, {"kana": "ト", "romaji": "TO"},
    {"kana": "ナ", "romaji": "NA"}, {"kana": "ニ", "romaji": "NI"}, {"kana": "ヌ", "romaji": "NU"}, {"kana": "ネ", "romaji": "NE"}, {"kana": "ノ", "romaji": "NO"},
    {"kana": "ハ", "romaji": "HA"}, {"kana": "ヒ", "romaji": "HI"}, {"kana": "フ", "romaji": "FU"}, {"kana": "ヘ", "romaji": "HE"}, {"kana": "ホ", "romaji": "HO"},
    {"kana": "マ", "romaji": "MA"}, {"kana": "ミ", "romaji": "MI"}, {"kana": "ム", "romaji": "MU"}, {"kana": "メ", "romaji": "ME"}, {"kana": "モ", "romaji": "MO"},
    {"kana": "ヤ", "romaji": "YA"}, {"kana": "", "romaji": ""}, {"kana": "ユ", "romaji": "YU"}, {"kana": "", "romaji": ""}, {"kana": "ヨ", "romaji": "YO"},
    {"kana": "ラ", "romaji": "RA"}, {"kana": "リ", "romaji": "RI"}, {"kana": "ル", "romaji": "RU"}, {"kana": "レ", "romaji": "RE"}, {"kana": "ロ", "romaji": "RO"},
    {"kana": "ワ", "romaji": "WA"}, {"kana": "", "romaji": ""}, {"kana": "", "romaji": ""}, {"kana": "", "romaji": ""}, {"kana": "ヲ", "romaji": "WO"},
    {"kana": "ン", "romaji": "N"},
  ];

  @override
  Widget build(BuildContext context) {
    String currentTitle = _activeTab == 0 ? "Hiragana" : "Katakana";
    List<Map<String, String>> currentList = _activeTab == 0 ? _hiraganaList : _katakanaList;

    return Column(
      children: [
        const SizedBox(height: 10),
        // 1. Tab Switcher
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              _buildTabItem("Hiragana", 0),
              const SizedBox(width: 10),
              _buildTabItem("Katakana", 1),
              const SizedBox(width: 10),
              _buildTabItem("Kanji", 2),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 2. Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Learning Header Card
                  _buildLearningHeader(currentTitle),
                  const SizedBox(height: 30),

                  // Character Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: currentList.length,
                    itemBuilder: (context, index) {
                      var item = currentList[index];
                      if (item["kana"] == "") return const SizedBox();
                      return _buildKanaTile(item["kana"]!, item["romaji"]!);
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "KEEP SCROLLING TO EXPLORE",
                    style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Study Tip Card
                  _buildStudyTip(currentTitle),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFB56A3F) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearningHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFD4956B), // Soft orange brown
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Learning $title",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          const Text(
            "Master the 46 angular characters used for foreign loanwords.",
            style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB56A3F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Row(
                  children: const [
                    Text("Start Lesson"),
                    SizedBox(width: 8),
                    Icon(Icons.play_arrow, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                "8 / 46 LEARNED",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKanaTile(String kana, String romaji) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2EBE1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            kana,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            romaji,
            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyTip(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Study Tip", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF5F0), // Very soft orange
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF0DEC9)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline, color: Color(0xFFD36B36), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87, height: 1.5, fontSize: 14),
                    children: [
                      TextSpan(text: "$title is almost exclusively used for foreign words like "),
                      const TextSpan(text: "カメラ (kamera)", style: TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: " or "),
                      const TextSpan(text: "パン (pan)", style: TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ". Try finding katakana on product packaging!"),
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