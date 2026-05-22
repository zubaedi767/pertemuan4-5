// pertemuan9_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pertemuan9Page extends StatefulWidget {
  const Pertemuan9Page({super.key});

  @override
  State<Pertemuan9Page> createState() => _Pertemuan9PageState();
}

class _Pertemuan9PageState extends State<Pertemuan9Page> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nomorIdentitasController = TextEditingController();
  
  // Selected Values
  String? _selectedStasiunAsal;
  String? _selectedStasiunTujuan;
  String? _selectedKelas;
  int _jumlahPenumpang = 1;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  // List Data
  final List<String> _stasiunList = [
    'Gambir - Jakarta',
    'Pasar Senen - Jakarta',
    'Bandung - Jawa Barat',
    'Yogyakarta - DIY',
    'Surabaya Gubeng - Jatim',
    'Semarang Tawang - Jateng',
    'Solo Balapan - Jateng',
    'Malang - Jawa Timur',
  ];
  
  final List<String> _kelasList = [
    'Ekonomi',
    'Bisnis',
    'Eksekutif',
    'Priority',
  ];
  
  final Map<String, int> _hargaPerKelas = {
    'Ekonomi': 150000,
    'Bisnis': 300000,
    'Eksekutif': 500000,
    'Priority': 750000,
  };
  
  final Map<String, IconData> _fasilitasIcons = {
    'Ekonomi': Icons.airline_seat_recline_normal,
    'Bisnis': Icons.airline_seat_recline_extra,
    'Eksekutif': Icons.airline_seat_flat,
    'Priority': Icons.airline_seat_individual_suite,
  };

  @override
  void dispose() {
    _namaController.dispose();
    _nomorIdentitasController.dispose();
    super.dispose();
  }

  // DatePicker Function
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00695C),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // TimePicker Function
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 8, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00695C),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Format Date
  String _formatDate(DateTime? date) {
    if (date == null) return 'Pilih Tanggal';
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  // Format Time
  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Pilih Jam';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute WIB';
  }

  // Calculate Total Price
  int _calculateTotal() {
    if (_selectedKelas == null) return 0;
    int hargaPerTiket = _hargaPerKelas[_selectedKelas] ?? 0;
    return hargaPerTiket * _jumlahPenumpang;
  }

  // Format Currency
  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Submit Form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedStasiunAsal == null) {
        _showErrorSnackBar('Silakan pilih stasiun asal');
        return;
      }
      if (_selectedStasiunTujuan == null) {
        _showErrorSnackBar('Silakan pilih stasiun tujuan');
        return;
      }
      if (_selectedStasiunAsal == _selectedStasiunTujuan) {
        _showErrorSnackBar('Stasiun asal dan tujuan tidak boleh sama');
        return;
      }
      if (_selectedKelas == null) {
        _showErrorSnackBar('Silakan pilih kelas kereta');
        return;
      }
      if (_selectedDate == null) {
        _showErrorSnackBar('Silakan pilih tanggal keberangkatan');
        return;
      }
      if (_selectedTime == null) {
        _showErrorSnackBar('Silakan pilih jam keberangkatan');
        return;
      }

      // Show Success Dialog
      _showSuccessDialog();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
            SizedBox(width: 8),
            Text(
              'Pemesanan Berhasil!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nama', _namaController.text),
              _buildDetailRow('No. Identitas', _nomorIdentitasController.text),
              const Divider(height: 24),
              _buildDetailRow('Stasiun Asal', _selectedStasiunAsal ?? ''),
              _buildDetailRow('Stasiun Tujuan', _selectedStasiunTujuan ?? ''),
              _buildDetailRow('Tanggal', _formatDate(_selectedDate)),
              _buildDetailRow('Jam', _formatTime(_selectedTime)),
              _buildDetailRow('Kelas', _selectedKelas ?? ''),
              _buildDetailRow('Jumlah Penumpang', '$_jumlahPenumpang orang'),
              const Divider(height: 24),
              _buildDetailRow(
                'Total Pembayaran',
                _formatCurrency(_calculateTotal()),
                isTotal: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('Pesan Lagi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 15 : 13,
                color: Colors.grey.shade600,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 16 : 13,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: isTotal ? const Color(0xFF00695C) : const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _formKey.currentState?.reset();
      _namaController.clear();
      _nomorIdentitasController.clear();
      _selectedStasiunAsal = null;
      _selectedStasiunTujuan = null;
      _selectedKelas = null;
      _jumlahPenumpang = 1;
      _selectedDate = null;
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text(
          'Pesan Tiket Kereta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF00897B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Banner
              _buildHeaderBanner(),
              
              // Form Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Data Pemesan Section
                    _buildSectionTitle('Data Pemesan', Icons.person_rounded),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama Lengkap',
                      hint: 'Masukkan nama lengkap',
                      icon: Icons.badge_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _nomorIdentitasController,
                      label: 'Nomor Identitas (KTP/SIM)',
                      hint: 'Masukkan nomor identitas',
                      icon: Icons.credit_card_rounded,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor identitas tidak boleh kosong';
                        }
                        if (value.length < 10) {
                          return 'Nomor identitas minimal 10 digit';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Detail Perjalanan Section
                    _buildSectionTitle('Detail Perjalanan', Icons.train_rounded),
                    const SizedBox(height: 12),
                    
                    // Stasiun Asal
                    _buildDropdown(
                      value: _selectedStasiunAsal,
                      label: 'Stasiun Asal',
                      icon: Icons.trip_origin_rounded,
                      items: _stasiunList,
                      hint: 'Pilih stasiun asal',
                      onChanged: (value) {
                        setState(() {
                          _selectedStasiunAsal = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Icon(
                        Icons.arrow_downward_rounded,
                        color: Color(0xFF00695C),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Stasiun Tujuan
                    _buildDropdown(
                      value: _selectedStasiunTujuan,
                      label: 'Stasiun Tujuan',
                      icon: Icons.trip_origin_rounded,
                      items: _stasiunList,
                      hint: 'Pilih stasiun tujuan',
                      onChanged: (value) {
                        setState(() {
                          _selectedStasiunTujuan = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Date & Time Picker Row
                    Row(
                      children: [
                        // Date Picker
                        Expanded(
                          child: _buildDateTimePicker(
                            label: 'Tanggal Berangkat',
                            value: _selectedDate != null ? _formatDate(_selectedDate) : null,
                            icon: Icons.calendar_month_rounded,
                            hint: 'Pilih Tanggal',
                            onTap: _selectDate,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Time Picker
                        Expanded(
                          child: _buildDateTimePicker(
                            label: 'Jam Berangkat',
                            value: _selectedTime != null ? _formatTime(_selectedTime) : null,
                            icon: Icons.access_time_rounded,
                            hint: 'Pilih Jam',
                            onTap: _selectTime,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Kelas Kereta
                    _buildDropdown(
                      value: _selectedKelas,
                      label: 'Kelas Kereta',
                      icon: Icons.confirmation_number_rounded,
                      items: _kelasList,
                      hint: 'Pilih kelas kereta',
                      onChanged: (value) {
                        setState(() {
                          _selectedKelas = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Jumlah Penumpang
                    _buildPenumpangCounter(),
                    
                    // Kelas Info Cards
                    if (_selectedKelas != null) ...[
                      const SizedBox(height: 16),
                      _buildKelasInfo(),
                    ],
                    
                    const SizedBox(height: 24),
                    
                    // Total Pembayaran
                    if (_selectedKelas != null) _buildTotalCard(),
                    
                    const SizedBox(height: 24),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00695C),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFF00695C).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.confirmation_number_rounded),
                            SizedBox(width: 8),
                            Text(
                              'Pesan Tiket Sekarang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF00897B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00695C).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.train_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesan Tiket Kereta',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mudah, Cepat, dan Nyaman',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF00695C).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF00695C), size: 20),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
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
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF00695C), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required IconData icon,
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        hint: Text(
          hint,
          style: TextStyle(color: Colors.grey.shade400),
        ),
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF00695C)),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required String? value,
    required IconData icon,
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
          border: value != null
              ? Border.all(color: const Color(0xFF00695C), width: 1.5)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  icon,
                  color: value != null
                      ? const Color(0xFF00695C)
                      : Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: value != null
                          ? const Color(0xFF1E293B)
                          : Colors.grey.shade400,
                      fontWeight: value != null ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPenumpangCounter() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00695C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.people_rounded,
              color: Color(0xFF00695C),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Jumlah Penumpang',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          // Minus Button
          InkWell(
            onTap: () {
              if (_jumlahPenumpang > 1) {
                setState(() {
                  _jumlahPenumpang--;
                });
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _jumlahPenumpang > 1
                    ? const Color(0xFF00695C).withOpacity(0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.remove_rounded,
                color: _jumlahPenumpang > 1
                    ? const Color(0xFF00695C)
                    : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Count Display
          Text(
            '$_jumlahPenumpang',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 16),
          // Plus Button
          InkWell(
            onTap: () {
              if (_jumlahPenumpang < 10) {
                setState(() {
                  _jumlahPenumpang++;
                });
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _jumlahPenumpang < 10
                    ? const Color(0xFF00695C).withOpacity(0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.add_rounded,
                color: _jumlahPenumpang < 10
                    ? const Color(0xFF00695C)
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKelasInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00695C).withOpacity(0.8),
                  const Color(0xFF00897B).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _fasilitasIcons[_selectedKelas] ?? Icons.airline_seat_recline_normal,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kelas $_selectedKelas',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatCurrency(_hargaPerKelas[_selectedKelas] ?? 0),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'per tiket',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF00695C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: Color(0xFF00695C), size: 16),
                SizedBox(width: 4),
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF00695C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF00897B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00695C).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatCurrency(_calculateTotal()),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '($_jumlahPenumpang tiket)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_offer_rounded, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Harga termasuk pajak',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}