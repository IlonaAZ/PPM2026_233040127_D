class QuizRepository {
  static List<Map<String, dynamic>> getQuestions(int unit, String difficulty) {
    if (unit == 1) {
      if (difficulty == 'basic') {
        return [
          {
            'type': 'multiple_choice',
            'question': 'Apa arti dari "おはようございます" (Ohayou gozaimasu)?',
            'japanese': 'おはようございます',
            'options': [
              {'code': 'A', 'text': 'Selamat pagi', 'romaji': 'Selamat Pagi'},
              {'code': 'B', 'text': 'Selamat siang', 'romaji': 'Selamat Siang'},
              {'code': 'C', 'text': 'Selamat malam', 'romaji': 'Selamat Malam'},
              {'code': 'D', 'text': 'Sampai jumpa', 'romaji': 'Sampai Jumpa'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Ungkapan yang digunakan saat berpisah untuk waktu lama atau selamanya adalah...',
            'japanese': 'さようなら',
            'options': [
              {'code': 'A', 'text': 'Konnichiwa', 'romaji': 'KONNICHIWA'},
              {'code': 'B', 'text': 'Sayounara', 'romaji': 'SAYOUNARA'},
              {'code': 'C', 'text': 'Mata ne', 'romaji': 'MATA NE'},
              {'code': 'D', 'text': 'Oyasuminasai', 'romaji': 'OYASUMINASAI'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Bagaimana cara menyapa seseorang di siang hari?',
            'japanese': 'こんにちは',
            'options': [
              {'code': 'A', 'text': 'Ohayou', 'romaji': 'OHAYOU'},
              {'code': 'B', 'text': 'Konbanwa', 'romaji': 'KONBANWA'},
              {'code': 'C', 'text': 'Konnichiwa', 'romaji': 'KONNICHIWA'},
              {'code': 'D', 'text': 'Arigatou', 'romaji': 'ARIGATOU'},
            ],
            'correctIndex': 2
          },
          {
            'type': 'multiple_choice',
            'question': 'Apa ucapan "Selamat tidur" dalam bahasa Jepang?',
            'japanese': 'おやすみなさい',
            'options': [
              {'code': 'A', 'text': 'Oyasuminasai', 'romaji': 'OYASUMINASAI'},
              {'code': 'B', 'text': 'Konbanwa', 'romaji': 'KONBANWA'},
              {'code': 'C', 'text': 'Okaeri', 'romaji': 'OKAERI'},
              {'code': 'D', 'text': 'Itadakimasu', 'romaji': 'ITADAKIMASU'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Apa arti kata "ありがとう" (Arigatou)?',
            'japanese': 'ありがとう',
            'options': [
              {'code': 'A', 'text': 'Maaf', 'romaji': 'GOMEN'},
              {'code': 'B', 'text': 'Terima kasih', 'romaji': 'TERIMA KASIH'},
              {'code': 'C', 'text': 'Permisi', 'romaji': 'SUMIMASEN'},
              {'code': 'D', 'text': 'Halo', 'romaji': 'MOSHI MOSHI'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Bagaimana menjawab pertanyaan kabar "お元気ですか" (Ogenki desu ka)?',
            'japanese': 'はい、元気です',
            'options': [
              {'code': 'A', 'text': 'Hai, genki desu (Ya, sehat)', 'romaji': 'HAI, GENKI DESU'},
              {'code': 'B', 'text': 'Iie (Tidak)', 'romaji': 'IIE'},
              {'code': 'C', 'text': 'Gomen nasai (Maaf)', 'romaji': 'GOMEN NASAI'},
              {'code': 'D', 'text': 'Sayounara', 'romaji': 'SAYOUNARA'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Ucapan "Selamat malam" saat bertemu seseorang adalah...',
            'japanese': 'こんばんは',
            'options': [
              {'code': 'A', 'text': 'Konnichiwa', 'romaji': 'KONNICHIWA'},
              {'code': 'B', 'text': 'Konbanwa', 'romaji': 'KONBANWA'},
              {'code': 'C', 'text': 'Oyasumi', 'romaji': 'OYASUMI'},
              {'code': 'D', 'text': 'Mata ashita', 'romaji': 'MATA ASHITA'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Saat masuk ke rumah/kamar orang lain, kita mengucapkan...',
            'japanese': 'お邪魔します',
            'options': [
              {'code': 'A', 'text': 'Okaeri', 'romaji': 'OKAERI'},
              {'code': 'B', 'text': 'Tadaima', 'romaji': 'TADAIMA'},
              {'code': 'C', 'text': 'Ojamashimasu', 'romaji': 'OJAMASHIMASU'},
              {'code': 'D', 'text': 'Ittashai', 'romaji': 'ITTERASSHAI'},
            ],
            'correctIndex': 2
          },
          {
            'type': 'multiple_choice',
            'question': 'Apa yang diucapkan seseorang saat kembali ke rumahnya sendiri?',
            'japanese': 'ただいま',
            'options': [
              {'code': 'A', 'text': 'Tadaima', 'romaji': 'TADAIMA'},
              {'code': 'B', 'text': 'Okaeri', 'romaji': 'OKAERI'},
              {'code': 'C', 'text': 'Itekimasu', 'romaji': 'ITTEKIMASU'},
              {'code': 'D', 'text': 'Irashaimase', 'romaji': 'IRASSHAIMASE'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Balasan yang tepat untuk orang yang mengucapkan "Tadaima" adalah...',
            'japanese': 'おかえりなさい',
            'options': [
              {'code': 'A', 'text': 'Itekimasu', 'romaji': 'ITTEKIMASU'},
              {'code': 'B', 'text': 'Okaerinasai', 'romaji': 'OKAERINASAI'},
              {'code': 'C', 'text': 'Ojamashimasu', 'romaji': 'OJAMASHIMASU'},
              {'code': 'D', 'text': 'Arigatou', 'romaji': 'ARIGATOU'},
            ],
            'correctIndex': 1
          },
        ];
      } else if (difficulty == 'medium') {
        return [
          {
            'type': 'multiple_choice',
            'question': 'Bagaimana cara menanyakan kabar seseorang secara formal?',
            'japanese': 'お元気ですか',
            'options': [
              {'code': 'A', 'text': 'Genki?', 'romaji': 'GENKI?'},
              {'code': 'B', 'text': 'Ogenki desu ka?', 'romaji': 'OGENKI DESU KA?'},
              {'code': 'C', 'text': 'Konnichiwa', 'romaji': 'KONNICHIWA'},
              {'code': 'D', 'text': 'Sumimasen', 'romaji': 'SUMIMASEN'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Menu dalam bahasa Jepang disebut...',
            'japanese': 'メニュー',
            'options': [
              {'code': 'A', 'text': 'Menyuu', 'romaji': 'MENYUU'},
              {'code': 'B', 'text': 'Gohan', 'romaji': 'GOHAN'},
              {'code': 'C', 'text': 'Mizu', 'romaji': 'MIZU'},
              {'code': 'D', 'text': 'Ocha', 'romaji': 'OCHA'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Cara meminta menu kepada pelayan toko:',
            'japanese': 'メニューをください',
            'options': [
              {'code': 'A', 'text': 'Menyuu o kudasai', 'romaji': 'MENYUU O KUDASAI'},
              {'code': 'B', 'text': 'Kore wa nan desu ka', 'romaji': 'KORE WA NAN DESU KA'},
              {'code': 'C', 'text': 'Okaikei kudasai', 'romaji': 'OKAIKEI KUDASAI'},
              {'code': 'D', 'text': 'Irashaimase', 'romaji': 'IRASSHAIMASE'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Arti dari "これをお願いします" (Kore o onegai shimasu) saat memesan makanan:',
            'japanese': 'Kore o onegai shimasu',
            'options': [
              {'code': 'A', 'text': 'Tolong yang ini', 'romaji': 'TOLONG YANG INI'},
              {'code': 'B', 'text': 'Minta air putih', 'romaji': 'MINTA AIR PUTIH'},
              {'code': 'C', 'text': 'Berapa harganya?', 'romaji': 'BERAPA HARGANYA?'},
              {'code': 'D', 'text': 'Tidak enak', 'romaji': 'TIDAK ENAK'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Kata penunjuk untuk memesan "Satu porsi" barang/makanan:',
            'japanese': 'ひとつ',
            'options': [
              {'code': 'A', 'text': 'Hitotsu', 'romaji': 'HITOTSU'},
              {'code': 'B', 'text': 'Futatsu', 'romaji': 'FUTATSU'},
              {'code': 'C', 'text': 'Mittsu', 'romaji': 'MITTSU'},
              {'code': 'D', 'text': 'Yottsu', 'romaji': 'YOTTSU'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Memesan Sushi 2 porsi: "Sushi o ... kudasai"',
            'japanese': 'ふたつ',
            'options': [
              {'code': 'A', 'text': 'Hitotsu', 'romaji': 'HITOTSU'},
              {'code': 'B', 'text': 'Futatsu', 'romaji': 'FUTATSU'},
              {'code': 'C', 'text': 'Mittsu', 'romaji': 'MITTSU'},
              {'code': 'D', 'text': 'Yottsu', 'romaji': 'YOTTSU'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Kata yang dipakai pelayan untuk menyambut konsumen masuk restoran:',
            'japanese': 'いらっしゃいませ',
            'options': [
              {'code': 'A', 'text': 'Arigatou gozaimasu', 'romaji': 'ARIGATOU GOZAIMASU'},
              {'code': 'B', 'text': 'Irashaimase', 'romaji': 'IRASSHAIMASE'},
              {'code': 'C', 'text': 'Gomen nasai', 'romaji': 'GOMEN NASAI'},
              {'code': 'D', 'text': 'Konnichiwa', 'romaji': 'KONNICHIWA'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Bahasa Jepang dari kata "Air Putih (Dingin)":',
            'japanese': 'お水',
            'options': [
              {'code': 'A', 'text': 'O-mizu', 'romaji': 'O-MIZU'},
              {'code': 'B', 'text': 'O-cha', 'romaji': 'O-CHA'},
              {'code': 'C', 'text': 'Koohii', 'romaji': 'KOOHII'},
              {'code': 'D', 'text': 'Juusu', 'romaji': 'JUUSU'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Bagasi ungkapan "Permisi" saat ingin memanggil pelayan restoran:',
            'japanese': 'すみません',
            'options': [
              {'code': 'A', 'text': 'Arigatou', 'romaji': 'ARIGATOU'},
              {'code': 'B', 'text': 'Gomen', 'romaji': 'GOMEN'},
              {'code': 'C', 'text': 'Sumimasen', 'romaji': 'SUMIMASEN'},
              {'code': 'D', 'text': 'Sayounara', 'romaji': 'SAYOUNARA'},
            ],
            'correctIndex': 2
          },
          {
            'type': 'multiple_choice',
            'question': 'Ekspresi ungkapan terima kasih yang sangat kasual/santai adalah...',
            'japanese': 'どうも',
            'options': [
              {'code': 'A', 'text': 'Doumo', 'romaji': 'DOUMO'},
              {'code': 'B', 'text': 'Arigatou gozaimasu', 'romaji': 'ARIGATOU GOZAIMASU'},
              {'code': 'C', 'text': 'Sumimasen', 'romaji': 'SUMIMASEN'},
              {'code': 'D', 'text': 'Ogenki desu ka', 'romaji': 'OGENKI DESU KA'},
            ],
            'correctIndex': 0
          },
        ];
      } else {
        // HARD (Mix Pilihan Ganda & Essay)
        return [
          {
            'type': 'multiple_choice',
            'question': 'Sebelum mulai menyantap makanan, orang Jepang mengucapkan...',
            'japanese': 'いただきます',
            'options': [
              {'code': 'A', 'text': 'Gochisousama', 'romaji': 'GOCHISOUSAMA'},
              {'code': 'B', 'text': 'Itadakimasu', 'romaji': 'ITADAKIMASU'},
              {'code': 'C', 'text': 'Oishii desu', 'romaji': 'OISHII DESU'},
              {'code': 'D', 'text': 'Kore o kudasai', 'romaji': 'KORE O KUDASAI'},
            ],
            'correctIndex': 1
          },
          {
            'type': 'multiple_choice',
            'question': 'Setelah selesai makan, ungkapan rasa syukur yang diucapkan adalah...',
            'japanese': 'ごちそうさまでした',
            'options': [
              {'code': 'A', 'text': 'Itadakimasu', 'romaji': 'ITADAKIMASU'},
              {'code': 'B', 'text': 'Oishii desu', 'romaji': 'OISHII DESU'},
              {'code': 'C', 'text': 'Gochisousama deshita', 'romaji': 'GOCHISOUSAMA DESHITA'},
              {'code': 'D', 'text': 'Okaikei kudasai', 'romaji': 'OKAIKEI KUDASAI'},
            ],
            'correctIndex': 2
          },
          {
            'type': 'multiple_choice',
            'question': 'Bagaimana cara meminta nota/total tagihan pembayaran (Bill)?',
            'japanese': 'お会計をお願いします',
            'options': [
              {'code': 'A', 'text': 'Okaikei o onegai shimasu', 'romaji': 'OKAIKEI O ONEGAI SHIMASU'},
              {'code': 'B', 'text': 'Menyuu o kudasai', 'romaji': 'MENYUU O KUDASAI'},
              {'code': 'C', 'text': 'Mizu o kudasai', 'romaji': 'MIZU O KUDASAI'},
              {'code': 'D', 'text': 'Kore wa nan desu ka', 'romaji': 'KORE WA NAN DESU KA'},
            ],
            'correctIndex': 0
          },
          {
            'type': 'multiple_choice',
            'question': 'Arti kata rasa kuliner "おいしい" (Oishii) adalah...',
            'japanese': 'おいしい',
            'options': [
              {'code': 'A', 'text': 'Pahit', 'romaji': 'NIGAI'},
              {'code': 'B', 'text': 'Manis', 'romaji': 'AMAI'},
              {'code': 'C', 'text': 'Enak / Lezat', 'romaji': 'ENAK / LEZAT'},
              {'code': 'D', 'text': 'Pedas', 'romaji': 'KARAI'},
            ],
            'correctIndex': 2
          },
          {
            'type': 'multiple_choice',
            'question': 'Jika ingin bertanya "Ini makanan apa?", kalimatnya adalah...',
            'japanese': 'これは何ですか',
            'options': [
              {'code': 'A', 'text': 'Kore wa nan desu ka', 'romaji': 'KORE WA NAN DESU KA'},
              {'code': 'B', 'text': 'Kore o kudasai', 'romaji': 'KORE O KUDASAI'},
              {'code': 'C', 'text': 'Okaikei desu ka', 'romaji': 'OKAIKEI DESU KA'},
              {'code': 'D', 'text': 'Ikura desu ka', 'romaji': 'IKURA DESU KA'},
            ],
            'correctIndex': 0
          },
          // SOAL ESSAY (Kunci jawaban lowercase tanpa spasi berlebih)
          {
            'type': 'essay',
            'question': 'Ketik Romaji dari ucapan selamat pagi formal Jepang:',
            'japanese': 'おはようございます',
            'answer': 'ohayou gozaimasu'
          },
          {
            'type': 'essay',
            'question': 'Ketik Romaji ungkapan sebelum makan:',
            'japanese': 'いただきます',
            'answer': 'itadakimasu'
          },
          {
            'type': 'essay',
            'question': 'Ketik Romaji kata dari arti kata "Enak / Lezat":',
            'japanese': 'おいしい',
            'answer': 'oishii'
          },
          {
            'type': 'essay',
            'question': 'Ketik Romaji dari ungkapan permisi / maaf saat memanggil pelayan:',
            'japanese': 'すみません',
            'answer': 'sumimasen'
          },
          {
            'type': 'essay',
            'question': 'Ketik Romaji untuk sistem hitungan "Satu Buah / Satu Porsi":',
            'japanese': 'ひとつ',
            'answer': 'hitotsu'
          },
        ];
      }
    } else {
      // UNIT 2 & SETERUSNYA (Katakana / Angka)
      if (difficulty == 'basic') {
        return List.generate(10, (index) => {
          'type': 'multiple_choice',
          'question': 'Unit 2 - Pertanyaan Kategori Dasar tentang Katakana Ke-${index + 1}:',
          'japanese': 'アメリカ',
          'options': [
            {'code': 'A', 'text': 'Amerika', 'romaji': 'AMERIKA'},
            {'code': 'B', 'text': 'Inggris', 'romaji': 'INGGRIS'},
            {'code': 'C', 'text': 'Jepang', 'romaji': 'NIHON'},
            {'code': 'D', 'text': 'Prancis', 'romaji': 'FURANSU'},
          ],
          'correctIndex': 0
        });
      } else if (difficulty == 'medium') {
        return List.generate(10, (index) => {
          'type': 'multiple_choice',
          'question': 'Unit 2 - Pertanyaan Kategori Menengah tentang Kosakata Ke-${index + 1}:',
          'japanese': 'カメラ',
          'options': [
            {'code': 'A', 'text': 'Televisi', 'romaji': 'TEREBI'},
            {'code': 'B', 'text': 'Kamera', 'romaji': 'KAMERA'},
            {'code': 'C', 'text': 'Radio', 'romaji': 'RAJIO'},
            {'code': 'D', 'text': 'Komputer', 'romaji': 'PASOKON'},
          ],
          'correctIndex': 1
        });
      } else {
        return List.generate(10, (index) => index < 5 ? {
          'type': 'multiple_choice',
          'question': 'Unit 2 - Tantangan Campuran Ke-${index + 1}:',
          'japanese': 'ホテル',
          'options': [
            {'code': 'A', 'text': 'Restoran', 'romaji': 'RESUTORAN'},
            {'code': 'B', 'text': 'Toko', 'romaji': 'MISE'},
            {'code': 'C', 'text': 'Hotel', 'romaji': 'HOTERU'},
            {'code': 'D', 'text': 'Stasiun', 'romaji': 'EKI'},
          ],
          'correctIndex': 2
        } : {
          'type': 'essay',
          'question': 'Ketik romaji dari kata Katakana berikut:',
          'japanese': 'トイレ',
          'answer': 'toire'
        });
      }
    }
  }
}