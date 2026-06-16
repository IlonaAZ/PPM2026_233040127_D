import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  // Profile Data State
  String name = 'Ilona AZ';
  String role = 'Mobile Developer Enthusiast';
  String about = 'Saya mahasiswa Teknik Informatika.';
  String education = 'Universitas Pasundan';
  String location = 'Bandung, Jawa Barat';
  String contact = 'iloncans@example.com\n+62 812-912-313-275';
  List<String> skills = ['Flutter', 'Dart', 'Git', 'UI/UX'];
  String? profileImagePath;

  // Experience Data State
  String? experienceImagePath;
  String experienceTitle = 'Project Manager';
  String experienceDescription = 'Memimpin pengembangan aplikasi mobile fantastis.';

  // Helper untuk menampilkan gambar (Cross-platform)
  ImageProvider _getProfileImage(String? path) {
    if (path != null) {
      if (kIsWeb) {
        return NetworkImage(path);
      } else {
        return FileImage(File(path));
      }
    }
    // Placeholder menggunakan URL transparan agar tidak error saat aset tidak ada
    return const NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: const Text('Menu Utama', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GalleryHome()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Upload Pengalaman'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UploadExperiencePage(
                      currentTitle: experienceTitle,
                      currentDescription: experienceDescription,
                      currentImagePath: experienceImagePath,
                      onSave: (newTitle, newDesc, newPath) {
                        setState(() {
                          experienceTitle = newTitle;
                          experienceDescription = newDesc;
                          experienceImagePath = newPath;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Fitur pengaturan belum tersedia.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _getProfileImage(profileImagePath),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(role, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: _StatBox(label: 'Post', value: '25')),
                Expanded(child: _StatBox(label: 'Followers', value: '1.5K')),
                Expanded(child: _StatBox(label: 'Following', value: '450')),
              ],
            ),
            const SizedBox(height: 24),
            _SectionCard(icon: Icons.info_outline, title: 'Tentang Saya', content: about),
            _SectionCard(icon: Icons.school, title: 'Pendidikan', content: education),
            _SectionCard(icon: Icons.location_on, title: 'Lokasi', content: location),
            _SectionCard(
              icon: Icons.star,
              title: 'Skills',
              contentWidget: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: skills.map((s) => Chip(label: Text(s))).toList(),
              ),
            ),
            _SectionCard(icon: Icons.email, title: 'Kontak', content: contact),
            _SectionCard(
              icon: Icons.work,
              title: 'Pengalaman',
              contentWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (experienceImagePath != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: kIsWeb 
                          ? Image.network(experienceImagePath!, height: 150, width: double.infinity, fit: BoxFit.cover)
                          : Image.file(File(experienceImagePath!), height: 150, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                  Text(experienceTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(experienceDescription),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfilePage(
                initialName: name,
                initialAbout: about,
                initialEducation: education,
                initialLocation: location,
                initialImagePath: profileImagePath,
                onSave: (newName, newAbout, newEdu, newLoc, newPath) {
                  setState(() {
                    name = newName;
                    about = newAbout;
                    education = newEdu;
                    location = newLoc;
                    profileImagePath = newPath;
                  });
                },
              ),
            ),
          );
        },
        label: const Text('Edit Profil'),
        icon: const Icon(Icons.edit),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? contentWidget;
  const _SectionCard({required this.icon, required this.title, this.content, this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  if (content != null) Text(content!, style: const TextStyle(height: 1.4)),
                  if (contentWidget != null) contentWidget!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialAbout;
  final String initialEducation;
  final String initialLocation;
  final String? initialImagePath;
  final Function(String, String, String, String, String?) onSave;
  const EditProfilePage({super.key, required this.initialName, required this.initialAbout, required this.initialEducation, required this.initialLocation, this.initialImagePath, required this.onSave});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController, _aboutController, _eduController, _locController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _aboutController = TextEditingController(text: widget.initialAbout);
    _eduController = TextEditingController(text: widget.initialEducation);
    _locController = TextEditingController(text: widget.initialLocation);
    _imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _imagePath = pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imagePath != null 
                  ? (kIsWeb ? NetworkImage(_imagePath!) : FileImage(File(_imagePath!)) as ImageProvider)
                  : const NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                child: const Align(alignment: Alignment.bottomRight, child: CircleAvatar(backgroundColor: Colors.blue, radius: 15, child: Icon(Icons.camera_alt, size: 18, color: Colors.white))),
              ),
            ),
            TextButton(onPressed: _pickImage, child: const Text('Ganti Foto')),
            const SizedBox(height: 16),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _aboutController, maxLines: 3, decoration: const InputDecoration(labelText: 'Bio', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _eduController, decoration: const InputDecoration(labelText: 'Pendidikan', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _locController, decoration: const InputDecoration(labelText: 'Lokasi', border: OutlineInputBorder())),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  widget.onSave(_nameController.text, _aboutController.text, _eduController.text, _locController.text, _imagePath);
                  Navigator.pop(context);
                },
                child: const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadExperiencePage extends StatefulWidget {
  final String currentTitle, currentDescription;
  final String? currentImagePath;
  final Function(String, String, String?) onSave;
  const UploadExperiencePage({super.key, required this.currentTitle, required this.currentDescription, this.currentImagePath, required this.onSave});

  @override
  State<UploadExperiencePage> createState() => _UploadExperiencePageState();
}

class _UploadExperiencePageState extends State<UploadExperiencePage> {
  late TextEditingController _titleController, _descController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.currentTitle);
    _descController = TextEditingController(text: widget.currentDescription);
    _imagePath = widget.currentImagePath;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _imagePath = pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Pengalaman')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180, width: double.infinity,
                decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.purple.shade100)),
                child: _imagePath != null 
                  ? ClipRRect(borderRadius: BorderRadius.circular(12), child: kIsWeb ? Image.network(_imagePath!, fit: BoxFit.cover) : Image.file(File(_imagePath!), fit: BoxFit.cover))
                  : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate, size: 50, color: Colors.purple.shade300), const Text('Tambah Foto')]),
              ),
            ),
            const SizedBox(height: 16),
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Judul', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _descController, maxLines: 4, decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder())),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  widget.onSave(_titleController.text, _descController.text, _imagePath);
                  Navigator.pop(context);
                },
                child: const Text('Simpan Pengalaman'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});
  @override
  Widget build(BuildContext context) {
    final categories = [('Display', Icons.image, Colors.blue), ('Input', Icons.edit, Colors.green), ('Button', Icons.smart_button, Colors.orange), ('Feedback', Icons.notifications, Colors.purple), ('Layout', Icons.dashboard, Colors.teal)];
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];
          return Card(child: ListTile(leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)), title: Text(name), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryPage(name: name)))));
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;
  const CategoryPage({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    final body = switch (name) { 'Display' => const _DisplayDemo(), 'Input' => const _InputDemo(), 'Button' => const _ButtonDemo(), 'Feedback' => const _FeedbackDemo(), 'Layout' => const _LayoutDemo(), _ => const Center(child: Text('?')) };
    return Scaffold(appBar: AppBar(title: Text(name)), body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: body));
  }
}

class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();
  @override
  Widget build(BuildContext context) {
    return const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Card', style: TextStyle(fontWeight: FontWeight.bold)),
      Card(child: ListTile(leading: Icon(Icons.album), title: Text('Judul Item'), subtitle: Text('Sub-judul'))),
      SizedBox(height: 16),
      Text('Chip', style: TextStyle(fontWeight: FontWeight.bold)),
      Wrap(spacing: 8, children: [Chip(label: Text('Flutter')), Chip(label: Text('Dart'))]),
      SizedBox(height: 16),
      Divider(thickness: 2),
    ]);
  }
}

class _InputDemo extends StatefulWidget {
  const _InputDemo();
  @override
  State<_InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<_InputDemo> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama')),
      CheckboxListTile(title: const Text('Checkbox'), value: _checked, onChanged: (v) => setState(() => _checked = v ?? false)),
    ]);
  }
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
      const SizedBox(height: 8),
      FilledButton(onPressed: () {}, child: const Text('Filled')),
    ]);
  }
}

class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Halo!'))), child: const Text('SnackBar')),
      const SizedBox(height: 12),
      const LinearProgressIndicator(value: 0.6),
    ]);
  }
}

class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Stack'),
      SizedBox(height: 100, child: Stack(children: [Container(color: Colors.blue[100]), const Positioned(top: 10, left: 10, child: Icon(Icons.star, size: 50))])),
    ]);
  }
}
