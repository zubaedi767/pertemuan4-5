import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  
  // Menggunakan nullable atau inisialisasi di initState dengan benar
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Controllers
  final _emailController = TextEditingController();
  final _pekerjaanController = TextEditingController();
  final _pengalamanController = TextEditingController();
  final _ttlController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alamatController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _bioController = TextEditingController();
  final _namaController = TextEditingController();

  // State
  String? _selectedGender;
  String? _selectedPendidikan;
  List<String> _selectedSkills = [];
  bool _isLoading = false;

  // Data
  final List<String> _pendidikanList = ['SMA/Sederajat', 'D3', 'S1', 'S2', 'S3'];
  final List<String> _skillsList = [
    'Flutter', 'React', 'Node.js', 'Python', 'UI/UX Design',
    'Project Management', 'Database', 'Cloud Computing', 'DevOps', 'Machine Learning'
  ];

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi controller terlebih dahulu
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Baru inisialisasi animasi turunannya
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Mulai animasi
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _pekerjaanController.dispose();
    _pengalamanController.dispose();
    _ttlController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _bioController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Form(
            key: _formKey,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5)))
                : _buildListView(),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 24),
        _buildSectionHeader('Informasi Personal', Icons.person, const Color(0xFF4F46E5)),
        const SizedBox(height: 12),
        _buildPersonalCard(),
        const SizedBox(height: 24),
        _buildSectionHeader('Kontak & Sosial Media', Icons.link, const Color(0xFF06B6D4)),
        const SizedBox(height: 12),
        _buildContactCard(),
        const SizedBox(height: 24),
        _buildSectionHeader('Pekerjaan & Pendidikan', Icons.work, const Color(0xFFF59E0B)),
        const SizedBox(height: 12),
        _buildWorkEducationCard(),
        const SizedBox(height: 24),
        _buildSectionHeader('Skills', Icons.star, const Color(0xFF10B981)),
        const SizedBox(height: 12),
        _buildSkillsCard(),
        const SizedBox(height: 24),
        _buildSectionHeader('Tentang Saya', Icons.edit_note, const Color(0xFF8B5CF6)),
        const SizedBox(height: 12),
        _buildBioCard(),
        const SizedBox(height: 32),
        _buildActionButtons(),
        const SizedBox(height: 32),
      ],
    );
  }

  // --- REUSABLE COMPONENT HELPERS ---

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF4F46E5), size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  // --- UI SECTIONS ---

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=User&background=7C3AED&color=fff'),
          ),
          const SizedBox(height: 16),
          const Text('Lengkapi Profil Anda', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildPersonalCard() {
    return _buildCard(children: [
      _buildModernTextField(controller: _namaController, label: 'Nama Lengkap', icon: Icons.person),
      const SizedBox(height: 16),
      _buildModernTextField(controller: _ttlController, label: 'Tempat, Tanggal Lahir', icon: Icons.cake),
    ]);
  }

  Widget _buildContactCard() {
    return _buildCard(children: [
      _buildModernTextField(controller: _emailController, label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress),
      const SizedBox(height: 16),
      _buildModernTextField(controller: _phoneController, label: 'Nomor Telepon', icon: Icons.phone, keyboardType: TextInputType.phone),
    ]);
  }

  Widget _buildWorkEducationCard() {
    return _buildCard(children: [
      _buildModernTextField(controller: _pekerjaanController, label: 'Pekerjaan', icon: Icons.work),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _selectedPendidikan,
        decoration: const InputDecoration(labelText: 'Pendidikan', prefixIcon: Icon(Icons.school)),
        items: _pendidikanList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => setState(() => _selectedPendidikan = v),
      ),
    ]);
  }

  Widget _buildSkillsCard() {
    return _buildCard(children: [
      Wrap(
        spacing: 8,
        children: _skillsList.map((skill) {
          final isSelected = _selectedSkills.contains(skill);
          return FilterChip(
            label: Text(skill),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                selected ? _selectedSkills.add(skill) : _selectedSkills.remove(skill);
              });
            },
          );
        }).toList(),
      ),
    ]);
  }

  Widget _buildBioCard() {
    return _buildCard(children: [
      _buildModernTextField(controller: _bioController, label: 'Bio', icon: Icons.edit, maxLines: 3),
    ]);
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F46E5)),
            child: const Text('Simpan Profile', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil Berhasil Diperbarui!')),
        );
      });
    }
  }
}