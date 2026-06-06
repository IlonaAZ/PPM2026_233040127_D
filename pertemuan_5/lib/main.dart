import 'package:flutter/material.dart';
import 'db_helper.dart'; // Pastikan file db_helper.dart milikmu/temanmu sudah ada di folder lib

void main() async {
  // Memastikan binding Flutter siap sebelum inisialisasi asynchronous (DB)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// ================= MODEL =================

class Catatan {
  final int? id; // Ditambahkan ID untuk kebutuhan Database SQLite
  String judul;
  String isi;
  String kategori;
  String email;
  DateTime dibuatPada;

  Catatan({
    this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });

  // Mengubah objek Catatan ke Map untuk disimpan ke SQLite
  Map<String, Object?> toMap() => {
    if (id != null) 'id': id,
    'judul': judul,
    'isi': isi,
    'kategori': kategori,
    'email': email,
    'dibuat_pada': dibuatPada.millisecondsSinceEpoch,
  };

  // Mengubah Map dari SQLite kembali menjadi objek Catatan
  static Catatan fromMap(Map<String, Object?> m) => Catatan(
    id: m['id'] as int?,
    judul: m['judul'] as String,
    isi: m['isi'] as String,
    kategori: m['kategori'] as String,
    email: m['email'] as String,
    dibuatPada:
    DateTime.fromMillisecondsSinceEpoch(m['dibuat_pada'] as int),
  );
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
  // Data sekarang diambil secara asynchronous dari SQLite
  late Future<List<Catatan>> _futureCatatan;
  String _filterKategori = 'Semua';

  final List<String> _kategoriFilter = [
    'Semua',
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _muatUlangData();
  }

  // Fungsi untuk memuat ulang data dari SQLite (Berguna juga untuk tombol Refresh)
  void _muatUlangData() {
    setState(() {
      _futureCatatan = DbHelper.instance.getAll().then((maps) {
        return maps.map((m) => Catatan.fromMap(m)).toList();
      });
    });
  }

  Future<void> _tambahCatatan() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TambahCatatanPage(),
      ),
    );

    if (hasil != null && hasil is Catatan) {
      await DbHelper.instance.insert(hasil.toMap());
      _muatUlangData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" berhasil ditambahkan')),
      );
    }
  }

  Future<void> _editCatatan(Catatan catatan) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahCatatanPage(catatan: catatan),
      ),
    );

    if (hasil != null && hasil is Catatan) {
      // Membuat objek catatan baru dengan ID yang sama untuk diupdate
      final catatanUpdate = Catatan(
        id: catatan.id,
        judul: hasil.judul,
        isi: hasil.isi,
        kategori: hasil.kategori,
        email: hasil.email,
        dibuatPada: catatan.dibuatPada,
      );

      await DbHelper.instance.update(catatanUpdate.toMap());
      _muatUlangData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" berhasil diupdate')),
      );
    }
  }

  void _hapusCatatan(Catatan catatan) {
    final judul = catatan.judul;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan?'),
        content: Text('Apakah Anda yakin ingin menghapus catatan "$judul"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            onPressed: () async {
              await DbHelper.instance.delete(catatan.id!);
              Navigator.pop(ctx);
              _muatUlangData();

              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Catatan "$judul" dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
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
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh Database',
          onPressed: _muatUlangData, // SPESIFIKASI: Tombol Refresh manual saat debugging
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
      body: FutureBuilder<List<Catatan>>(
        future: _futureCatatan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          var data = snapshot.data ?? [];

          // Logika Filter Kategori
          if (_filterKategori != 'Semua') {
            data = data.where((c) => c.kategori == _filterKategori).toList();
          }

          if (data.isEmpty) {
            return const _EmptyState();
          }

          return ListView.builder(
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
                      backgroundColor: const Color(0xFFD6D9FF),
                      child: Text(
                        c.judul.isNotEmpty ? c.judul[0].toUpperCase() : '?',
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7E9FF),
                              borderRadius: BorderRadius.circular(20),
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
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => _hapusCatatan(c),
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailCatatanPage(
                            catatan: c,
                            onEdit: () => _editCatatan(c),
                          ),
                        ),
                      );
                      _muatUlangData(); // Muat ulang seandainya ada data berubah dari halaman detail
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8E97FD),
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

// ================= TAMBAH / EDIT PAGE =================

class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const TambahCatatanPage({
    super.key,
    this.catatan,
  });

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
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

    _judulCtrl = TextEditingController(text: widget.catatan?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatan?.isi ?? '');
    _emailCtrl = TextEditingController(text: widget.catatan?.email ?? '');
    _kategori = widget.catatan?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _validEmail(String email) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatanHasil = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(),
      dibuatPada: widget.catatan?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, catatanHasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Catatan' : 'Tambah Catatan'),
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
                prefixIcon: const Icon(Icons.title),
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
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Pengirim',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
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
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              items: _kategoriList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
                prefixIcon: const Icon(Icons.notes),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _simpan,
              icon: Icon(isEdit ? Icons.save : Icons.add_task),
              label: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Catatan'),
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
    return '${date.day}/${date.month}/${date.year} pukul ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.pop(context); // Tutup halaman detail terlebih dahulu
              onEdit(); // Picu alur edit di HomePage
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            catatan.judul,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5B5FC7),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E9FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  catatan.kategori,
                  style: const TextStyle(
                    color: Color(0xFF5B5FC7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email_outlined, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      catatan.email,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Dibuat pada: ${_formatTanggal(catatan.dibuatPada)}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.black12),
          ),
          Text(
            catatan.isi,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}