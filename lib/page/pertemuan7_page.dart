import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  State<RadiobuttonPage> createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  // Controller
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _emailController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _tempatLahirController = TextEditingController();

  // State variables
  String? _selectedGender;
  String? _selectedJob;
  String? _selectedPendidikan;
  String? _selectedStatus;
  DateTime? _selectedDate;
  bool _isWargaNegara = true;
  final List<String> _selectedHobbies = [];
  String? _selectedAgama;
  String? _selectedGolonganDarah;
  int _currentStep = 0;

  // Data lists
  final List<String> _pendidikanList = [
    'SD/Sederajat',
    'SMP/Sederajat',
    'SMA/Sederajat',
    'D3',
    'S1/D4',
    'S2',
    'S3'
  ];

  final List<String> _agamaList = [
    'Islam',
    'Kristen Protestan',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu'
  ];

  final List<String> _golonganDarahList = ['A', 'B', 'AB', 'O'];

  final List<String> _hobbyList = [
    'Olahraga',
    'Membaca',
    'Musik',
    'Traveling',
    'Fotografi',
    'Memasak',
    'Gaming',
    'Menulis'
  ];

  // Format tanggal manual
  String _formatTanggal(DateTime tanggal) {
    final List<String> namaBulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${tanggal.day} ${namaBulan[tanggal.month - 1]} ${tanggal.year}';
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _namaController.dispose();
    _umurController.dispose();
    _emailController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    _tempatLahirController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Formulir Data Diri',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF00897B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _fadeAnimation == null
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: _fadeAnimation!,
              child: _buildBody(),
            ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Indicators
            _buildStepIndicators(),
            const SizedBox(height: 24),

            // Form Content based on step
            if (_currentStep == 0) _buildStepPersonal(),
            if (_currentStep == 1) _buildStepTambahan(),
            if (_currentStep == 2) _buildStepPreferensi(),

            const SizedBox(height: 32),

            // Navigation Buttons
            _buildNavigationButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicators() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStepCircle(1, 'Personal', 0),
              _buildStepLine(0),
              _buildStepCircle(2, 'Tambahan', 1),
              _buildStepLine(1),
              _buildStepCircle(3, 'Lainnya', 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int number, String label, int step) {
    final isActive = step <= _currentStep;
    final isCompleted = step < _currentStep;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF00695C) : Colors.grey.shade200,
            border: Border.all(
              color: isActive ? const Color(0xFF00695C) : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    '$number',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? const Color(0xFF00695C) : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: step < _currentStep ? const Color(0xFF00695C) : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _currentStep--),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: Color(0xFF00695C)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Color(0xFF00695C)),
                  SizedBox(width: 8),
                  Text('Kembali', style: TextStyle(color: Color(0xFF00695C))),
                ],
              ),
            ),
          ),
        if (_currentStep > 0) const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _currentStep < 2
                ? () => setState(() => _currentStep++)
                : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_currentStep < 2 ? Icons.arrow_forward : Icons.save),
                const SizedBox(width: 8),
                Text(
                  _currentStep < 2 ? 'Selanjutnya' : 'Simpan Data',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // STEP 0: PERSONAL
  Widget _buildStepPersonal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informasi Pribadi', Icons.person_outline),
        const SizedBox(height: 12),
        _buildCard([
          _buildTextField(
            controller: _namaController,
            label: 'Nama Lengkap',
            icon: Icons.person_outline,
            hint: 'Masukkan nama lengkap',
            validator: (v) {
              if (v == null || v.isEmpty) return 'Nama tidak boleh kosong';
              if (v.length < 3) return 'Nama minimal 3 karakter';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _umurController,
            label: 'Umur',
            icon: Icons.cake_outlined,
            hint: 'Masukkan umur',
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Umur wajib diisi';
              final umur = int.tryParse(v);
              if (umur == null) return 'Harus berupa angka';
              if (umur < 0 || umur > 150) return 'Umur tidak valid';
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildGenderOption('Laki-laki', Icons.male, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _buildGenderOption('Perempuan', Icons.female, Colors.pink)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _tempatLahirController,
            label: 'Tempat Lahir',
            icon: Icons.location_on_outlined,
            hint: 'Kota tempat lahir',
            validator: (v) => v == null || v.isEmpty ? 'Tempat lahir wajib diisi' : null,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade50,
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, color: Color(0xFF00695C)),
                  const SizedBox(width: 12),
                  Text(
                    _selectedDate == null ? 'Pilih Tanggal Lahir' : _formatTanggal(_selectedDate!),
                    style: TextStyle(color: _selectedDate == null ? Colors.grey : Colors.black, fontSize: 14),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  // STEP 1: TAMBAHAN
  Widget _buildStepTambahan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informasi Tambahan', Icons.more_outlined),
        const SizedBox(height: 12),
        _buildCard([
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            hint: 'contoh@email.com',
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email wajib diisi';
              if (!v.contains('@')) return 'Format email tidak valid';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _noTelpController,
            label: 'Nomor Telepon',
            icon: Icons.phone_outlined,
            hint: '08xxxxxxxxxx',
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.isEmpty) return 'No. telepon wajib diisi';
              if (v.length < 10) return 'Minimal 10 digit';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _alamatController,
            label: 'Alamat Lengkap',
            icon: Icons.home_outlined,
            hint: 'Masukkan alamat lengkap',
            maxLines: 3,
            validator: (v) => v == null || v.isEmpty ? 'Alamat wajib diisi' : null,
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Pendidikan Terakhir',
            value: _selectedPendidikan,
            items: _pendidikanList,
            icon: Icons.school_outlined,
            onChanged: (v) => setState(() => _selectedPendidikan = v),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Pekerjaan',
            value: _selectedJob,
            items: ['Programmer', 'Desainer', 'Guru', 'Dokter', 'Wirausaha', 'Lainnya'],
            icon: Icons.work_outline,
            onChanged: (v) => setState(() => _selectedJob = v),
          ),
        ]),
      ],
    );
  }

  // STEP 2: PREFERENSI
  Widget _buildStepPreferensi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Preferensi & Lainnya', Icons.favorite_outline),
        const SizedBox(height: 12),
        _buildCard([
          const Text('Status Pernikahan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          _buildStatusSelector(),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Agama',
            value: _selectedAgama,
            items: _agamaList,
            icon: Icons.mosque_outlined,
            onChanged: (v) => setState(() => _selectedAgama = v),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Golongan Darah',
            value: _selectedGolonganDarah,
            items: _golonganDarahList,
            icon: Icons.bloodtype_outlined,
            onChanged: (v) => setState(() => _selectedGolonganDarah = v),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Warga Negara Indonesia'),
            subtitle: Text(_isWargaNegara ? 'WNI' : 'WNA', style: TextStyle(color: Colors.grey.shade600)),
            value: _isWargaNegara,
            onChanged: (v) => setState(() => _isWargaNegara = v),
            activeColor: const Color(0xFF00695C),
          ),
          const SizedBox(height: 12),
          const Text('Hobi', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _hobbyList.map((hobby) {
              final isSelected = _selectedHobbies.contains(hobby);
              return FilterChip(
                label: Text(hobby),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedHobbies.add(hobby);
                    } else {
                      _selectedHobbies.remove(hobby);
                    }
                  });
                },
                selectedColor: const Color(0xFF00695C).withOpacity(0.1),
                checkmarkColor: const Color(0xFF00695C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: isSelected ? const Color(0xFF00695C) : Colors.grey.shade300),
                ),
              );
            }).toList(),
          ),
        ]),
      ],
    );
  }

  Widget _buildStatusSelector() {
    final statuses = ['Belum Menikah', 'Menikah', 'Cerai'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: statuses.map((status) {
          final isSelected = _selectedStatus == status;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedStatus = status),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF00695C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // WIDGET COMPONENTS
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF00695C).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF00695C), size: 22),
        ),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF00695C))),
      ],
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00695C), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildGenderOption(String value, IconData icon, Color color) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.05) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 32),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: isSelected ? color : Colors.grey.shade600, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
          border: InputBorder.none,
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedGender == null || _selectedJob == null || _selectedPendidikan == null || 
        _selectedStatus == null || _selectedAgama == null || _selectedDate == null || _selectedHobbies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Mohon lengkapi semua data!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Print data
    debugPrint('=== DATA DIRI ===');
    debugPrint('Nama: ${_namaController.text}');
    debugPrint('Umur: ${_umurController.text}');
    debugPrint('Gender: $_selectedGender');
    debugPrint('TTL: ${_tempatLahirController.text}, ${_formatTanggal(_selectedDate!)}');
    debugPrint('Email: ${_emailController.text}');
    debugPrint('No. Telp: ${_noTelpController.text}');
    debugPrint('Alamat: ${_alamatController.text}');
    debugPrint('Pendidikan: $_selectedPendidikan');
    debugPrint('Pekerjaan: $_selectedJob');
    debugPrint('Status: $_selectedStatus');
    debugPrint('Agama: $_selectedAgama');
    debugPrint('Golongan Darah: ${_selectedGolonganDarah ?? "-"}');
    debugPrint('Kewarganegaraan: ${_isWargaNegara ? "WNI" : "WNA"}');
    debugPrint('Hobi: ${_selectedHobbies.join(", ")}');

    // Tampilkan dialog sukses
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ Data Berhasil Disimpan'),
        content: Text('Halo ${_namaController.text}, data Anda sudah masuk ke sistem.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _namaController.clear();
      _umurController.clear();
      _emailController.clear();
      _noTelpController.clear();
      _alamatController.clear();
      _tempatLahirController.clear();
      _selectedGender = null;
      _selectedJob = null;
      _selectedPendidikan = null;
      _selectedStatus = null;
      _selectedDate = null;
      _selectedAgama = null;
      _selectedGolonganDarah = null;
      _selectedHobbies.clear();
      _isWargaNegara = true;
      _currentStep = 0;
    });
  }
}