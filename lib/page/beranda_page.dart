// ==================== BERANDA PAGE (Simplified & Responsive) ====================
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

class BerandaPage extends StatefulWidget {
  final Map<String, String> dataAwal;
  final Function(Map<String, String>) onUpdate;
  final VoidCallback onDelete;

  const BerandaPage({
    super.key,
    required this.dataAwal,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _jobController;
  late TextEditingController _descController;
  late TextEditingController _photoController;
  late TextEditingController _projectController;
  late TextEditingController _locationController;
  late TextEditingController _followersController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.dataAwal["nama"] ?? '');
    _jobController = TextEditingController(text: widget.dataAwal["pekerjaan"] ?? '');
    _descController = TextEditingController(text: widget.dataAwal["deskripsi"] ?? '');
    _photoController = TextEditingController(text: widget.dataAwal["foto"] ?? '');
    _projectController = TextEditingController(text: widget.dataAwal["project"] ?? '');
    _locationController = TextEditingController(text: widget.dataAwal["lokasi"] ?? '');
    _followersController = TextEditingController(text: widget.dataAwal["followers"] ?? '0');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _descController.dispose();
    _photoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _followersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Beranda",
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.blue,
        toolbarHeight: 60,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(constraints.maxWidth > 600 ? 32 : 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Input Data
                  _buildInputButton(constraints),
                  const SizedBox(height: 16),
                  
                  // Tombol Delete Data
                  _buildDeleteButton(constraints),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Tombol Input Data - Responsive & Lebih Kecil
  Widget _buildInputButton(BoxConstraints constraints) {
    double buttonWidth = constraints.maxWidth > 600 ? 400 : double.infinity;
    
    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: _showInputDataDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit_note, size: 22),
              const SizedBox(width: 8),
              const Text(
                "Input Data",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tombol Delete Data - Responsive & Lebih Kecil
  Widget _buildDeleteButton(BoxConstraints constraints) {
    double buttonWidth = constraints.maxWidth > 600 ? 400 : double.infinity;
    
    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: OutlinedButton(
          onPressed: _showDeleteConfirmation,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Colors.red.shade300, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever, size: 22, color: Colors.red.shade600),
              const SizedBox(width: 8),
              Text(
                "Delete Data",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Menampilkan Form Dialog
  void _showInputDataDialog() {
    // Reset controller ke data terbaru
    _nameController.text = widget.dataAwal["nama"] ?? '';
    _jobController.text = widget.dataAwal["pekerjaan"] ?? '';
    _descController.text = widget.dataAwal["deskripsi"] ?? '';
    _photoController.text = widget.dataAwal["foto"] ?? '';
    _projectController.text = widget.dataAwal["project"] ?? '';
    _locationController.text = widget.dataAwal["lokasi"] ?? '';
    _followersController.text = widget.dataAwal["followers"] ?? '0';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.edit_note, color: Colors.blue.shade700, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Form Data Diri",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  
                  // Form Fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _nameController,
                              label: "Nama Lengkap",
                              icon: Icons.person_outline,
                              hint: "Masukkan nama lengkap",
                            ),
                            const SizedBox(height: 14),
                            
                            _buildTextField(
                              controller: _jobController,
                              label: "Pekerjaan",
                              icon: Icons.work_outline,
                              hint: "Masukkan pekerjaan",
                            ),
                            const SizedBox(height: 14),
                            
                            _buildTextField(
                              controller: _descController,
                              label: "Deskripsi",
                              icon: Icons.description_outlined,
                              hint: "Masukkan deskripsi diri",
                              maxLines: 3,
                            ),
                            const SizedBox(height: 14),
                            
                            _buildTextField(
                              controller: _locationController,
                              label: "Lokasi",
                              icon: Icons.location_on_outlined,
                              hint: "Masukkan lokasi/alamat",
                            ),
                            const SizedBox(height: 14),
                            
                            // Foto Profil
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTextField(
                                  controller: _photoController,
                                  label: "Foto Profil",
                                  icon: Icons.photo_outlined,
                                  hint: "URL foto atau pilih dari gallery",
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final XFile? image = await _picker.pickImage(
                                        source: ImageSource.gallery
                                      );
                                      if (image != null) {
                                        setDialogState(() {
                                          _photoController.text = image.path;
                                        });
                                        if (context.mounted) {
                                          CherryToast.success(
                                            title: const Text("Foto berhasil dipilih"),
                                            action: const Text("OK"),
                                          ).show(context);
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.upload_file, size: 18),
                                    label: const Text("Pilih dari Gallery"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade100,
                                      foregroundColor: Colors.blue.shade700,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_photoController.text.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: _buildPreviewImage(_photoController.text),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            
                            _buildTextField(
                              controller: _projectController,
                              label: "Jumlah Project",
                              icon: Icons.folder_outlined,
                              hint: "Masukkan jumlah project",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 14),
                            
                            _buildTextField(
                              controller: _followersController,
                              label: "Jumlah Followers",
                              icon: Icons.people_outline,
                              hint: "Masukkan jumlah followers",
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Tombol Batal & Simpan
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Batal", style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_validateForm()) {
                              Navigator.pop(context);
                              _showSaveConfirmation();
                            } else {
                              CherryToast.error(
                                title: const Text("Semua field harus diisi!"),
                                action: const Text("OK"),
                              ).show(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Simpan", style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue.shade600, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
      ),
    );
  }

  Widget _buildPreviewImage(String photoPath) {
    if (photoPath.startsWith('http')) {
      return Image.network(
        photoPath, 
        height: 100, 
        width: 100, 
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image, size: 40),
          );
        },
      );
    } else {
      if (File(photoPath).existsSync()) {
        return Image.file(
          File(photoPath), 
          height: 100, 
          width: 100, 
          fit: BoxFit.cover,
        );
      } else {
        return Container(
          height: 100,
          width: 100,
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image, size: 40),
        );
      }
    }
  }

  bool _validateForm() {
    if (_nameController.text.trim().isEmpty) return false;
    if (_jobController.text.trim().isEmpty) return false;
    if (_descController.text.trim().isEmpty) return false;
    if (_photoController.text.trim().isEmpty) return false;
    if (_projectController.text.trim().isEmpty) return false;
    if (_locationController.text.trim().isEmpty) return false;
    if (_followersController.text.trim().isEmpty) return false;
    return true;
  }

  // Dialog Konfirmasi sebelum menyimpan
  void _showSaveConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.question_mark, color: Colors.orange, size: 24),
            SizedBox(width: 10),
            Text("Konfirmasi Simpan Data"),
          ],
        ),
        content: const Text(
          "Apakah Anda yakin ingin menyimpan data ini?",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _saveData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text("Ya, Simpan"),
          ),
        ],
      ),
    );
  }

  void _saveData() {
    widget.onUpdate({
      "nama": _nameController.text.trim(),
      "pekerjaan": _jobController.text.trim(),
      "deskripsi": _descController.text.trim(),
      "foto": _photoController.text.trim(),
      "project": _projectController.text.trim(),
      "lokasi": _locationController.text.trim(),
      "followers": _followersController.text.trim(),
    });
    
    if (mounted) {
      CherryToast.success(
        title: const Text("✅ Data berhasil disimpan!"),
        action: const Text("OK"),
      ).show(context);
      setState(() {});
    }
  }

  // Konfirmasi Delete
  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
            SizedBox(width: 10),
            Text("Hapus Semua Data?"),
          ],
        ),
        content: const Text(
          "Data yang dihapus tidak dapat dikembalikan.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onDelete();
              _resetForm();
              Navigator.pop(context);
              if (mounted) {
                CherryToast.info(
                  title: const Text("🗑️ Semua data berhasil dihapus"),
                  action: const Text("OK"),
                ).show(context);
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Ya, Hapus"),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _nameController.clear();
    _jobController.clear();
    _descController.clear();
    _photoController.clear();
    _projectController.clear();
    _locationController.clear();
    _followersController.clear();
  }
}