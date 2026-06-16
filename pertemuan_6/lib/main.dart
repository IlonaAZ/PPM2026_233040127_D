import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'catatan.dart';
import 'api_client.dart';

void main() {
  runApp(const MyApp());
}

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8E97FD)),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF6F5FF),
          elevation: 0,
          titleTextStyle: TextStyle(color: Color(0xFF5B5FC7), fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Catatan>> _futureCatatan;
  String _filterKategori = 'Semua';

  @override
  void initState() {
    super.initState();
    _muatUlangData();
  }

  void _muatUlangData() {
    setState(() {
      _futureCatatan = ApiClient.instance.getAll();
    });
  }

  Future<void> _hapusCatatan(Catatan catatan) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan?'),
        content: Text('Apakah Anda yakin ingin menghapus catatan "${catatan.judul}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (yakin == true) {
      try {
        await ApiClient.instance.delete(catatan.id!);
        _muatUlangData();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil dihapus'), backgroundColor: Color(0xFF323232)),
        );
      } on ApiException catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: ${e.message}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Digital'),
        leading: IconButton(
          icon: const Icon(Icons.refresh, color: Color(0xFF5B5FC7)),
          onPressed: () {
            _muatUlangData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('🔄 Menyelaraskan data...'), backgroundColor: Color(0xFF323232), duration: Duration(seconds: 1)),
            );
          },
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _filterKategori,
              items: ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _filterKategori = v!),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: FutureBuilder<List<Catatan>>(
        future: _futureCatatan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          if (snapshot.hasError) {
            final e = snapshot.error;
            final pesan = e is ApiException ? e.message : '$e';
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(pesan, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  FilledButton(onPressed: _muatUlangData, child: const Text('Coba lagi')),
                ],
              ),
            );
          }

          var data = snapshot.data ?? [];
          if (_filterKategori != 'Semua') data = data.where((c) => c.kategori == _filterKategori).toList();
          if (data.isEmpty) return const Center(child: Text('Belum ada catatan'));

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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFD6D9FF),
                      child: Text(c.judul[0].toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5B5FC7))),
                    ),
                    title: Text(c.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text('${c.kategori} • ${DateFormat('dd/MM/yyyy').format(c.dibuatPada)}'),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent), onPressed: () => _hapusCatatan(c)),
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailCatatanPage(catatan: c)));
                      _muatUlangData();
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
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahCatatanPage()));
          _muatUlangData();
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatan;
  const TambahCatatanPage({super.key, this.catatan});
  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulCtrl, _isiCtrl, _emailCtrl;
  String _kategori = 'Kuliah';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _judulCtrl = TextEditingController(text: widget.catatan?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatan?.isi ?? '');
    _emailCtrl = TextEditingController(text: widget.catatan?.email ?? '');
    _kategori = widget.catatan?.kategori ?? 'Kuliah';
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('⚠️ Mohon lengkapi data!'), backgroundColor: Colors.redAccent));
      return;
    }
    setState(() => _loading = true);
    try {
      final c = Catatan(
        id: widget.catatan?.id,
        judul: _judulCtrl.text.trim(),
        isi: _isiCtrl.text.trim(),
        kategori: _kategori,
        email: _emailCtrl.text.trim(),
        dibuatPada: widget.catatan?.dibuatPada ?? DateTime.now(),
      );

      if (widget.catatan != null) await ApiClient.instance.update(c);
      else await ApiClient.instance.insert(c);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil disimpan'), backgroundColor: Color(0xFF323232)));
      Navigator.pop(context);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message), backgroundColor: Colors.redAccent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.catatan == null ? 'Tambah Catatan' : 'Edit Catatan')),
      body: _loading ? const Center(child: CircularProgressIndicator()) : Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildField(_judulCtrl, 'Judul', Icons.title),
            const SizedBox(height: 20),
            _buildField(_emailCtrl, 'Email', Icons.email, isEmail: true),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _kategori,
              decoration: _inputDeco('Kategori', Icons.category),
              items: ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => _kategori = v!,
            ),
            const SizedBox(height: 20),
            _buildField(_isiCtrl, 'Isi', Icons.notes, maxLines: 5),
            const SizedBox(height: 30),
            FilledButton(onPressed: _simpan, style: FilledButton.styleFrom(backgroundColor: const Color(0xFF8E97FD), padding: const EdgeInsets.all(16)), child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String l, IconData i) => InputDecoration(
    labelText: l, prefixIcon: Icon(i), filled: true, fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
    errorStyle: const TextStyle(fontWeight: FontWeight.bold),
  );

  Widget _buildField(TextEditingController c, String l, IconData i, {int maxLines = 1, bool isEmail = false}) => TextFormField(
    controller: c, maxLines: maxLines, decoration: _inputDeco(l, i),
    validator: (v) => (v == null || v.isEmpty) ? '⚠️ $l kosong' : (isEmail && !v.contains('@') ? '⚠️ Email salah' : null),
  );
}

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TambahCatatanPage(catatan: catatan)))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(catatan.judul, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5B5FC7))),
          const SizedBox(height: 16),
          Wrap(spacing: 10, children: [
            Chip(label: Text(catatan.kategori), backgroundColor: const Color(0xFFE7E9FF)),
            Chip(label: Text(catatan.email), avatar: const Icon(Icons.email, size: 16)),
          ]),
          const SizedBox(height: 12),
          Text('Dibuat: ${DateFormat('dd/MM/yyyy HH:mm').format(catatan.dibuatPada)}', style: const TextStyle(color: Colors.grey)),
          const Divider(height: 40),
          Text(catatan.isi, style: const TextStyle(fontSize: 16, height: 1.6)),
        ],
      ),
    );
  }
}
