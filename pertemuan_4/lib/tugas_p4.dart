import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= MODEL =================

class Catatan {
  String judul;
  String isi;
  String kategori;
  String email;
  DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
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
      home: const HomePage(),
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
      isi: 'Mempelajari StatefulWidget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'ilona@example.com',
      dibuatPada: DateTime.now(),
    ),
  ];

  String _filterKategori = 'Semua';

  final List<String> _kategoriFilter = [
    'Semua',
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  List<Catatan> get _filteredCatatan {
    if (_filterKategori == 'Semua') {
      return _catatan;
    }

    return _catatan
        .where((c) => c.kategori == _filterKategori)
        .toList();
  }

  Future<void> _tambahCatatan() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TambahCatatanPage(),
      ),
    );

    if (hasil != null && hasil is Catatan) {
      setState(() {
        _catatan.add(hasil);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Catatan "${hasil.judul}" berhasil ditambahkan',
          ),
        ),
      );
    }
  }

  Future<void> _editCatatan(
      Catatan catatan,
      int index,
      ) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahCatatanPage(
          catatan: catatan,
        ),
      ),
    );

    if (hasil != null && hasil is Catatan) {
      setState(() {
        _catatan[index] = hasil;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Catatan "${hasil.judul}" berhasil diupdate',
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
        content: Text(
          'Catatan "$judul" dihapus',
        ),
      ),
    );
  }

  String _formatTanggal(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final data = _filteredCatatan;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Mahasiswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _filterKategori,
                borderRadius: BorderRadius.circular(16),
                items: _kategoriFilter.map((kategori) {
                  return DropdownMenuItem(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    _filterKategori = v!;
                  });
                },
              ),
            ),
          ),
        ],
      ),

      body: data.isEmpty
          ? const _EmptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, i) {
          final c = data[i];

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
                  backgroundColor:
                  const Color(0xFFD6D9FF),
                  child: Text(
                    c.judul[0].toUpperCase(),
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
                  padding:
                  const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFE7E9FF),
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          c.kategori,
                          style: const TextStyle(
                            color:
                            Color(0xFF5B5FC7),
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        _formatTanggal(
                          c.dibuatPada,
                        ),
                        style: TextStyle(
                          color:
                          Colors.grey.shade600,
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

                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailCatatanPage(
                            catatan: c,
                            onEdit: () =>
                                _editCatatan(c, i),
                          ),
                    ),
                  );

                  setState(() {});
                },
              ),
            ),
          );
        },
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor:
        const Color(0xFF8E97FD),
        foregroundColor: Colors.white,
        onPressed: _tambahCatatan,
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
        mainAxisAlignment:
        MainAxisAlignment.center,
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

// ================= TAMBAH / EDIT PAGE =================

class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const TambahCatatanPage({
    super.key,
    this.catatan,
  });

  @override
  State<TambahCatatanPage> createState() =>
      _TambahCatatanPageState();
}

class _TambahCatatanPageState
    extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _judulCtrl;
  late TextEditingController _isiCtrl;
  late TextEditingController _emailCtrl;

  String _kategori = 'Kuliah';

  final List<String> _kategoriList = [
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  bool get isEdit => widget.catatan != null;

  @override
  void initState() {
    super.initState();

    _judulCtrl = TextEditingController(
      text: widget.catatan?.judul ?? '',
    );

    _isiCtrl = TextEditingController(
      text: widget.catatan?.isi ?? '',
    );

    _emailCtrl = TextEditingController(
      text: widget.catatan?.email ?? '',
    );

    _kategori =
        widget.catatan?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _validEmail(String email) {
    return RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(email);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatanBaru = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(),
      dibuatPada: DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Edit Catatan'
              : 'Tambah Catatan',
        ),
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
                prefixIcon:
                const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
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

            TextFormField(
              controller: _emailCtrl,
              keyboardType:
              TextInputType.emailAddress,

              decoration: InputDecoration(
                labelText: 'Email Pengirim',
                filled: true,
                fillColor: Colors.white,
                prefixIcon:
                const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),

              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email wajib diisi';
                }

                if (!_validEmail(v.trim())) {
                  return 'Format email tidak valid';
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
                prefixIcon:
                const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),

              items: _kategoriList
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
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
                prefixIcon:
                const Icon(Icons.notes),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
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
                backgroundColor:
                const Color(0xFF8E97FD),
                padding:
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),

              onPressed: _simpan,

              icon: const Icon(Icons.save),

              label: Text(
                isEdit
                    ? 'Update Catatan'
                    : 'Simpan Catatan',
                style:
                const TextStyle(fontSize: 16),
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
  final VoidCallback onEdit;

  const DetailCatatanPage({
    super.key,
    required this.catatan,
    required this.onEdit,
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
            borderRadius:
            BorderRadius.circular(28),
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                catatan.judul,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Chip(
                    backgroundColor:
                    const Color(0xFFE7E9FF),

                    label: Text(
                      catatan.kategori,
                      style: const TextStyle(
                        color: Color(0xFF5B5FC7),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    _formatTanggal(
                      catatan.dibuatPada,
                    ),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5FF),
                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.email),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(catatan.email),
                    ),
                  ],
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
                    backgroundColor:
                    const Color(0xFF8E97FD),
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                    onEdit();
                  },

                  icon: const Icon(Icons.edit),

                  label: const Text(
                    'Edit Catatan',
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