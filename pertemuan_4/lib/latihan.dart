import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= MODEL =================

class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });
}

// ================= APP =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F5FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E97FD),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF6F5FF),
          elevation: 0,
        ),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomePage(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            return MaterialPageRoute(
              builder: (_) => const TambahCatatanPage(),
            );

          case '/detail':
            final catatan = settings.arguments as Catatan;

            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(
                catatan: catatan,
              ),
            );
        }

        return null;
      },
    );
  }
}

// ================= HOME PAGE =================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      dibuatPada: DateTime.now(),
    ),
  ];

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(
      context,
      '/tambah',
    );

    if (hasil is Catatan) {
      setState(() {
        _catatan.add(hasil);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Catatan "${hasil.judul}" ditambahkan',
          ),
        ),
      );
    }
  }

  void _hapusCatatan(int index) {
    final judul = _catatan[index].judul;

    setState(() {
      _catatan.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan "$judul" dihapus'),
      ),
    );
  }

  String _formatTanggal(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: _catatan.isEmpty
          ? const _EmptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _catatan.length,
        itemBuilder: (context, i) {
          final c = _catatan[i];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              elevation: 2,
              shadowColor: Colors.black12,
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),

                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFD6D9FF),
                  child: Text(
                    c.judul[0],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B5FC7),
                    ),
                  ),
                ),

                title: Text(
                  c.judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E9FF),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          c.kategori,
                          style: const TextStyle(
                            color: Color(0xFF5B5FC7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        _formatTanggal(c.dibuatPada),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    _hapusCatatan(i);
                  },
                ),

                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: c,
                  );
                },
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8E97FD),
        foregroundColor: Colors.white,
        onPressed: _bukaTambahCatatan,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

// ================= EMPTY STATE =================

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 16),

          Text(
            'Belum ada catatan',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= TAMBAH PAGE =================

class TambahCatatanPage extends StatefulWidget {
  const TambahCatatanPage({super.key});

  @override
  State<TambahCatatanPage> createState() =>
      _TambahCatatanPageState();
}

class _TambahCatatanPageState
    extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  final _judulCtrl = TextEditingController();
  final _isiCtrl = TextEditingController();

  String _kategori = 'Kuliah';

  final _kategoriOpsi = const [
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final catatanBaru = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      dibuatPada: DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _judulCtrl,

              decoration: InputDecoration(
                labelText: 'Judul',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),

              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }

                if (v.trim().length < 3) {
                  return 'Minimal 3 karakter';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _kategori,

              decoration: InputDecoration(
                labelText: 'Kategori',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),

              items: _kategoriOpsi
                  .map(
                    (k) => DropdownMenuItem(
                  value: k,
                  child: Text(k),
                ),
              )
                  .toList(),

              onChanged: (v) {
                setState(() {
                  _kategori = v!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,

              decoration: InputDecoration(
                labelText: 'Isi Catatan',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),

              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Isi wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF8E97FD),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),

              onPressed: _simpan,

              icon: const Icon(Icons.save),

              label: const Text(
                'Simpan Catatan',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= DETAIL PAGE =================

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;

  const DetailCatatanPage({
    super.key,
    required this.catatan,
  });

  String _formatTanggal(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                catatan.judul,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Chip(
                backgroundColor: const Color(0xFFE7E9FF),
                label: Text(
                  catatan.kategori,
                  style: const TextStyle(
                    color: Color(0xFF5B5FC7),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Dibuat pada: ${_formatTanggal(catatan.dibuatPada)}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const Divider(height: 40),

              Text(
                catatan.isi,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.6,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,

                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF8E97FD),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(Icons.arrow_back),

                  label: const Text(
                    'Kembali',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}