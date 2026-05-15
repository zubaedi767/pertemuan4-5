import 'package:flutter/material.dart';

class Pertemuan8Page extends StatefulWidget {
  const Pertemuan8Page({super.key});

  @override
  State<Pertemuan8Page> createState() => _Pertemuan8PageState();
}

class _Pertemuan8PageState extends State<Pertemuan8Page>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Controllers
  final _namaController = TextEditingController();
  final _catatanController = TextEditingController();

  // State variables
  String? _selectedMenu;
  String? _selectedMinuman;
  String? _selectedLevelPedas;
  String? _selectedPorsi;
  String? _selectedPembayaran;
  int _quantity = 1;
  bool _pakaiSendok = true;
  bool _pakaiTisu = false;
  bool _extraTopping = false;

  // Daftar Menu
  final List<Map<String, dynamic>> _menuMakanan = [
    {
      'nama': 'Nasi Goreng Spesial',
      'harga': 25000,
      'emoji': '🍛',
      'kategori': 'Makanan Berat',
    },
    {
      'nama': 'Mie Ayam Jamur',
      'harga': 20000,
      'emoji': '🍜',
      'kategori': 'Makanan Berat',
    },
    {
      'nama': 'Sate Ayam Madura',
      'harga': 30000,
      'emoji': '🍢',
      'kategori': 'Makanan Berat',
    },
    {
      'nama': 'Ayam Bakar Taliwang',
      'harga': 35000,
      'emoji': '🍗',
      'kategori': 'Makanan Berat',
    },
    {
      'nama': 'Bakso Lava',
      'harga': 18000,
      'emoji': '🍲',
      'kategori': 'Makanan Berat',
    },
    {
      'nama': 'Salad Buah Segar',
      'harga': 15000,
      'emoji': '🥗',
      'kategori': 'Makanan Ringan',
    },
  ];

  final List<Map<String, dynamic>> _menuMinuman = [
    {'nama': 'Es Teh Manis', 'harga': 5000, 'emoji': '🍹'},
    {'nama': 'Es Jeruk', 'harga': 7000, 'emoji': '🍊'},
    {'nama': 'Jus Alpukat', 'harga': 12000, 'emoji': '🥑'},
    {'nama': 'Milkshake Coklat', 'harga': 15000, 'emoji': '🥤'},
    {'nama': 'Air Mineral', 'harga': 3000, 'emoji': '💧'},
  ];

  final List<String> _levelPedas = [
    'Tidak Pedas',
    'Sedikit Pedas',
    'Pedas Sedang',
    'Pedas',
    'Sangat Pedas 🔥',
  ];

  final List<String> _porsiList = [
    'Regular',
    'Large (+Rp 5.000)',
    'Jumbo (+Rp 10.000)',
  ];

  final List<String> _pembayaranList = [
    'Cash',
    'QRIS',
    'GoPay',
    'OVO',
    'DANA',
    'Transfer Bank',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _namaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  int _calculateTotal() {
    int total = 0;
    
    // Harga menu makanan
    if (_selectedMenu != null) {
      final menu = _menuMakanan.firstWhere(
        (m) => m['nama'] == _selectedMenu,
        orElse: () => {'harga': 0},
      );
      total += (menu['harga'] as int) * _quantity;
    }
    
    // Harga minuman
    if (_selectedMinuman != null) {
      final minuman = _menuMinuman.firstWhere(
        (m) => m['nama'] == _selectedMinuman,
        orElse: () => {'harga': 0},
      );
      total += minuman['harga'] as int;
    }
    
    // Tambahan porsi
    if (_selectedPorsi == 'Large (+Rp 5.000)') total += 5000;
    if (_selectedPorsi == 'Jumbo (+Rp 10.000)') total += 10000;
    
    // Extra topping
    if (_extraTopping) total += 8000;
    
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          '🍽️ Pesan Makanan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('🛒 Keranjang masih kosong'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                _buildHeaderCard(),
                const SizedBox(height: 20),

                // Form Section
                _buildSectionCard(
                  'Informasi Pemesan',
                  Icons.person_outline,
                  [
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama Pemesan',
                      icon: Icons.person,
                      hint: 'Masukkan nama Anda',
                      validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Menu Selection
                _buildSectionCard(
                  'Pilih Menu',
                  Icons.restaurant_menu,
                  [
                    _buildDropdownWithEmoji(
                      label: 'Menu Makanan',
                      value: _selectedMenu,
                      items: _menuMakanan.map((menu) {
                        return {
                          'value': menu['nama'] as String,
                          'label': '${menu['emoji']} ${menu['nama']} - Rp ${_formatRupiah(menu['harga'] as int)}',
                          'kategori': menu['kategori'] as String,
                        };
                      }).toList(),
                      icon: Icons.restaurant,
                      onChanged: (v) => setState(() => _selectedMenu = v),
                      validator: (v) => v == null ? 'Pilih menu makanan' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownWithEmoji(
                      label: 'Menu Minuman',
                      value: _selectedMinuman,
                      items: _menuMinuman.map((minuman) {
                        return {
                          'value': minuman['nama'] as String,
                          'label': '${minuman['emoji']} ${minuman['nama']} - Rp ${_formatRupiah(minuman['harga'] as int)}',
                        };
                      }).toList(),
                      icon: Icons.local_drink,
                      onChanged: (v) => setState(() => _selectedMinuman = v),
                    ),
                    if (_selectedMenu != null) ...[
                      const SizedBox(height: 16),
                      _buildQuantitySelector(),
                    ],
                  ],
                ),
                const SizedBox(height: 16),

                // Preferensi
                _buildSectionCard(
                  'Preferensi',
                  Icons.tune,
                  [
                    _buildDropdown(
                      label: 'Level Kepedasan',
                      value: _selectedLevelPedas,
                      items: _levelPedas,
                      icon: Icons.local_fire_department,
                      onChanged: (v) => setState(() => _selectedLevelPedas = v),
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Ukuran Porsi',
                      value: _selectedPorsi,
                      items: _porsiList,
                      icon: Icons.set_meal,
                      onChanged: (v) => setState(() => _selectedPorsi = v),
                    ),
                    const SizedBox(height: 16),
                    _buildSwitchTile(
                      'Extra Topping Keju (+Rp 8.000)',
                      _extraTopping,
                      (v) => setState(() => _extraTopping = v),
                      Icons.add_circle_outline, // Ganti icon cheese dengan add_circle_outline
                    ),
                    const SizedBox(height: 12),
                    _buildSwitchTile(
                      'Pakai Sendok & Garpu',
                      _pakaiSendok,
                      (v) => setState(() => _pakaiSendok = v),
                      Icons.restaurant,
                    ),
                    const SizedBox(height: 12),
                    _buildSwitchTile(
                      'Tambah Tisu',
                      _pakaiTisu,
                      (v) => setState(() => _pakaiTisu = v),
                      Icons.cleaning_services,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Pembayaran
                _buildSectionCard(
                  'Pembayaran',
                  Icons.payment,
                  [
                    _buildDropdown(
                      label: 'Metode Pembayaran',
                      value: _selectedPembayaran,
                      items: _pembayaranList,
                      icon: Icons.account_balance_wallet,
                      onChanged: (v) => setState(() => _selectedPembayaran = v),
                      validator: (v) => v == null ? 'Pilih metode pembayaran' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _catatanController,
                      label: 'Catatan Tambahan',
                      icon: Icons.note_add,
                      hint: 'Contoh: Tidak pakai sambal, dll.',
                      maxLines: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Order Summary
                if (_selectedMenu != null) _buildOrderSummary(),
                if (_selectedMenu != null) const SizedBox(height: 20),

                // Submit Button
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
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
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warung Makan Flutter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '⭐ 4.8 | 🕒 Buka 08:00 - 22:00',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoChip(Icons.delivery_dining, 'Free Ongkir', 'Min. 50k'),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildInfoChip(Icons.timer, '20-30 min', 'Estimasi'),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildInfoChip(Icons.discount, 'Disc 10%', 'First Order'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF00695C), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
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
        hint: Text('Pilih $label', style: TextStyle(color: Colors.grey.shade400)),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildDropdownWithEmoji({
    required String label,
    required String? value,
    required List<Map<String, String?>> items,
    required IconData icon,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
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
        hint: Text('Pilih $label', style: TextStyle(color: Colors.grey.shade400)),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['label']!,
                  style: const TextStyle(fontSize: 14),
                ),
                if (item['kategori'] != null)
                  Text(
                    item['kategori']!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        isExpanded: true,
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF00695C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00695C).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Jumlah Pesanan',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              _buildQuantityButton(
                Icons.remove,
                () {
                  if (_quantity > 1) {
                    setState(() => _quantity--);
                  }
                },
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00695C).withOpacity(0.3)),
                ),
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF00695C),
                  ),
                ),
              ),
              _buildQuantityButton(
                Icons.add,
                () {
                  if (_quantity < 10) {
                    setState(() => _quantity++);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: const Color(0xFF00695C),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontSize: 14)),
        secondary: Icon(icon, color: const Color(0xFF00695C)),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF00695C),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final total = _calculateTotal();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00695C).withOpacity(0.05),
            const Color(0xFF00897B).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00695C).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long, color: Color(0xFF00695C)),
              const SizedBox(width: 8),
              const Text(
                'Ringkasan Pesanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Text(
                '${_quantity}x',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00695C),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          if (_namaController.text.isNotEmpty)
            _buildSummaryRow('Pemesan', _namaController.text),
          if (_selectedMenu != null)
            _buildSummaryRow('Makanan', _selectedMenu!),
          if (_selectedMinuman != null)
            _buildSummaryRow('Minuman', _selectedMinuman!),
          if (_selectedLevelPedas != null)
            _buildSummaryRow('Pedas', _selectedLevelPedas!),
          if (_selectedPorsi != null)
            _buildSummaryRow('Porsi', _selectedPorsi!),
          if (_extraTopping)
            _buildSummaryRow('Extra Topping', '+Rp 8.000'),
          _buildSummaryRow('Quantity', '${_quantity}x'),
          if (_selectedPembayaran != null)
            _buildSummaryRow('Bayar via', _selectedPembayaran!),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${_formatRupiah(total)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00695C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submitOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00695C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          shadowColor: const Color(0xFF00695C).withOpacity(0.4),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout),
            SizedBox(width: 8),
            Text(
              'PESAN SEKARANG',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitOrder() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedMenu == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('⚠️ Silakan pilih menu makanan terlebih dahulu!'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Pesanan Berhasil! 🎉'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terima kasih ${_namaController.text}!'),
            const SizedBox(height: 8),
            Text('Pesanan $_selectedMenu Anda akan segera diproses.'),
            const SizedBox(height: 4),
            Text('Estimasi pengiriman: 20-30 menit'),
          ],
        ),
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
      _catatanController.clear();
      _selectedMenu = null;
      _selectedMinuman = null;
      _selectedLevelPedas = null;
      _selectedPorsi = null;
      _selectedPembayaran = null;
      _quantity = 1;
      _pakaiSendok = true;
      _pakaiTisu = false;
      _extraTopping = false;
    });
  }

  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}