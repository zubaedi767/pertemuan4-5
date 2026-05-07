import 'package:flutter/material.dart';

class Pertemuan6Page extends StatefulWidget {
  const Pertemuan6Page({super.key});

  @override
  State<Pertemuan6Page> createState() => _Pertemuan6PageState();
}

class _Pertemuan6PageState extends State<Pertemuan6Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // 1. STANDARD CHECKBOX LIST
  final List<CheckboxItem> _basicItems = [
    CheckboxItem(
      title: 'Flutter Fundamentals',
      subtitle: 'Memahami dasar-dasar Flutter & Dart',
      isChecked: false,
      icon: Icons.flutter_dash,
    ),
    CheckboxItem(
      title: 'Widget Dasar',
      subtitle: 'Stateless & Stateful Widget',
      isChecked: false,
      icon: Icons.widgets,
    ),
    CheckboxItem(
      title: 'Layout System',
      subtitle: 'Row, Column, Stack, Container',
      isChecked: false,
      icon: Icons.dashboard,
    ),
  ];

  // 2. CUSTOM ANIMATED CHECKBOX
  final List<CheckboxItem> _customItems = [
    CheckboxItem(
      title: 'Navigation & Routing',
      subtitle: 'Navigasi antar halaman dengan Navigator',
      isChecked: false,
      icon: Icons.route,
    ),
    CheckboxItem(
      title: 'State Management',
      subtitle: 'setState, Provider, Riverpod, BLoC',
      isChecked: false,
      icon: Icons.sync,
    ),
    CheckboxItem(
      title: 'Form & Input',
      subtitle: 'TextFormField, Validasi, Radio, Checkbox',
      isChecked: false,
      icon: Icons.input,
    ),
  ];

  // 3. TOGGLE/SWITCH ITEMS
  final List<ToggleItem> _toggleItems = [
    ToggleItem(
      title: 'Mode Gelap',
      subtitle: 'Aktifkan dark mode untuk kenyamanan',
      icon: Icons.dark_mode,
      isToggled: false,
    ),
    ToggleItem(
      title: 'Notifikasi',
      subtitle: 'Dapatkan update materi terbaru',
      icon: Icons.notifications_active,
      isToggled: true,
    ),
    ToggleItem(
      title: 'Auto Save',
      subtitle: 'Simpan progress secara otomatis',
      icon: Icons.save,
      isToggled: true,
    ),
  ];

  // 4. CHECKLIST CARD (Multi-select)
  final List<String> _topics = [
    'API Integration',
    'Firebase Setup',
    'Local Storage',
    'Animation',
    'Testing',
    'Deployment',
  ];
  final List<String> _selectedTopics = [];

  bool _selectAllBasic = false;
  bool _selectAllCustom = false;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
    super.dispose();
  }

  int _getBasicCheckedCount() =>
      _basicItems.where((item) => item.isChecked).length;
  int _getCustomCheckedCount() =>
      _customItems.where((item) => item.isChecked).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text(
          'Pertemuan 6 - Checkbox',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4F46E5).withOpacity(0.1),
                  const Color(0xFF7C3AED).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 16, color: Color(0xFF4F46E5)),
                const SizedBox(width: 4),
                Text(
                  '${_getBasicCheckedCount() + _getCustomCheckedCount() + _selectedTopics.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Tab Selector
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildTab('Basic', 0, Icons.check_box_outlined),
                  _buildTab('Custom', 1, Icons.check_box_outline_blank),
                  _buildTab('Cards', 2, Icons.style),
                  _buildTab('Toggle', 3, Icons.toggle_off),
                ],
              ),
            ),

            // Content based on tab
            Expanded(
              child: IndexedStack(
                index: _currentTab,
                children: [
                  _buildBasicCheckboxList(),
                  _buildCustomCheckboxList(),
                  _buildChecklistCards(),
                  _buildToggleList(),
                ],
              ),
            ),

            // Bottom Action Bar
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index, IconData icon) {
    final isSelected = _currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======= TAB 1: BASIC CHECKBOX LIST =======
  Widget _buildBasicCheckboxList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSelectAllCard(
          'Materi Dasar Flutter',
          _selectAllBasic,
          _basicItems.length,
          _getBasicCheckedCount(),
          () {
            setState(() {
              _selectAllBasic = !_selectAllBasic;
              for (var item in _basicItems) {
                item.isChecked = _selectAllBasic;
              }
            });
          },
        ),
        const SizedBox(height: 12),
        ..._basicItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildBasicCheckboxTile(item, index);
        }),
      ],
    );
  }

  Widget _buildSelectAllCard(
    String title,
    bool isSelected,
    int total,
    int checked,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4F46E5).withOpacity(0.05),
            const Color(0xFF7C3AED).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4F46E5).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4F46E5)
                      : Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4F46E5).withOpacity(0.3),
                          blurRadius: 8,
                        )
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF1A2C3E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pilih Semua',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$checked / $total',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F46E5),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicCheckboxTile(CheckboxItem item, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: item.isChecked
            ? Border.all(
                color: const Color(0xFF4F46E5).withOpacity(0.1),
                width: 1,
              )
            : null,
      ),
      child: CheckboxListTile(
        value: item.isChecked,
        onChanged: (value) {
          setState(() {
            item.isChecked = value ?? false;
            _updateSelectAllBasic();
          });
        },
        activeColor: const Color(0xFF4F46E5),
        checkColor: Colors.white,
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: item.isChecked
                ? const Color(0xFF8E9AAE)
                : const Color(0xFF1A2C3E),
            decoration:
                item.isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: item.isChecked
                ? const Color(0xFFCBD5E1)
                : const Color(0xFF8E9AAE),
            decoration:
                item.isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.isChecked
                ? const Color(0xFF4F46E5).withOpacity(0.1)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item.icon,
            size: 20,
            color: item.isChecked
                ? const Color(0xFF4F46E5)
                : Colors.grey,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  void _updateSelectAllBasic() {
    if (_getBasicCheckedCount() == _basicItems.length) {
      _selectAllBasic = true;
    } else if (_getBasicCheckedCount() < _basicItems.length && _selectAllBasic) {
      _selectAllBasic = false;
    }
  }

  // ======= TAB 2: CUSTOM CHECKBOX LIST =======
  Widget _buildCustomCheckboxList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSelectAllCard(
          'Materi Lanjutan',
          _selectAllCustom,
          _customItems.length,
          _getCustomCheckedCount(),
          () {
            setState(() {
              _selectAllCustom = !_selectAllCustom;
              for (var item in _customItems) {
                item.isChecked = _selectAllCustom;
              }
            });
          },
        ),
        const SizedBox(height: 12),
        ..._customItems.map((item) => _buildCustomCheckboxTile(item)),
      ],
    );
  }

  Widget _buildCustomCheckboxTile(CheckboxItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isChecked = !item.isChecked;
          _updateSelectAllCustom();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: item.isChecked
              ? Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                  width: 2,
                )
              : null,
        ),
        child: Row(
          children: [
            // Custom Animated Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.isChecked
                    ? const Color(0xFF10B981)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                boxShadow: item.isChecked
                    ? [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.3),
                          blurRadius: 12,
                        )
                      ]
                    : null,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: item.isChecked
                    ? const Icon(Icons.check_rounded,
                        key: ValueKey('check'),
                        color: Colors.white,
                        size: 28)
                    : Icon(Icons.circle_outlined,
                        key: ValueKey('empty'),
                        color: Colors.grey.shade400,
                        size: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: item.isChecked
                          ? const Color(0xFF8E9AAE)
                          : const Color(0xFF1A2C3E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8E9AAE),
                    ),
                  ),
                ],
              ),
            ),
            if (item.isChecked)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _updateSelectAllCustom() {
    if (_getCustomCheckedCount() == _customItems.length) {
      _selectAllCustom = true;
    } else if (_getCustomCheckedCount() < _customItems.length &&
        _selectAllCustom) {
      _selectAllCustom = false;
    }
  }

  // ======= TAB 3: CHECKLIST CARDS (Multi-select grid) =======
  Widget _buildChecklistCards() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF59E0B).withOpacity(0.1),
                const Color(0xFFEF4444).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF59E0B).withOpacity(0.3),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb, color: Color(0xFFF59E0B)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Pilih topik yang ingin dipelajari selanjutnya',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2C3E),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _topics.map((topic) {
            final isSelected = _selectedTopics.contains(topic);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedTopics.remove(topic);
                  } else {
                    _selectedTopics.add(topic);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: (MediaQuery.of(context).size.width - 64) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? const Color(0xFF4F46E5).withOpacity(0.3)
                          : Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4F46E5)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : const Color(0xFF4F46E5).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _getTopicIcon(topic),
                            size: 20,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF4F46E5),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle,
                              color: Colors.white, size: 24),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      topic,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : const Color(0xFF1A2C3E),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getTopicIcon(String topic) {
    switch (topic) {
      case 'API Integration':
        return Icons.api;
      case 'Firebase Setup':
        return Icons.cloud;
      case 'Local Storage':
        return Icons.storage;
      case 'Animation':
        return Icons.animation;
      case 'Testing':
        return Icons.bug_report;
      case 'Deployment':
        return Icons.rocket_launch;
      default:
        return Icons.topic;
    }
  }

  // ======= TAB 4: TOGGLE LIST =======
  Widget _buildToggleList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: _toggleItems.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.isToggled
                      ? const Color(0xFF8B5CF6).withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.isToggled
                      ? const Color(0xFF8B5CF6)
                      : Colors.grey,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF1A2C3E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8E9AAE),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: item.isToggled,
                onChanged: (value) {
                  setState(() {
                    item.isToggled = value;
                  });
                },
                activeColor: const Color(0xFF8B5CF6),
                activeTrackColor: const Color(0xFF8B5CF6).withOpacity(0.3),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ======= BOTTOM BAR =======
  Widget _buildBottomBar() {
    final totalChecked = _getBasicCheckedCount() +
        _getCustomCheckedCount() +
        _selectedTopics.length;
    final totalItems = _basicItems.length +
        _customItems.length +
        _topics.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Bar
          if (totalChecked > 0) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: totalChecked / totalItems,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$totalChecked dari $totalItems item selesai (${((totalChecked / totalItems) * 100).toInt()}%)',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8E9AAE),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: totalChecked > 0 ? () => _showResultDialog(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: totalChecked > 0 ? 4 : 0,
                disabledBackgroundColor: Colors.grey.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Simpan Progress',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  if (totalChecked > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$totalChecked',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    final completedBasic =
        _basicItems.where((item) => item.isChecked).toList();
    final completedCustom =
        _customItems.where((item) => item.isChecked).toList();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxHeight: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4F46E5).withOpacity(0.1),
                      const Color(0xFF7C3AED).withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Color(0xFF4F46E5),
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Progress Tersimpan! 🎉',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2C3E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kamu telah menyelesaikan ${completedBasic.length + completedCustom.length} materi dan memilih ${_selectedTopics.length} topik',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF8E9AAE)),
              ),
              const SizedBox(height: 20),
              // Completed Items
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (completedBasic.isNotEmpty) ...[
                        const Text(
                          '✅ Materi Dasar:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF1A2C3E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...completedBasic.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      size: 16, color: Color(0xFF10B981)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(item.title,
                                        style: const TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 12),
                      ],
                      if (completedCustom.isNotEmpty) ...[
                        const Text(
                          '🔥 Materi Lanjutan:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF1A2C3E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...completedCustom.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      size: 16, color: Color(0xFF10B981)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(item.title,
                                        style: const TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            )),
                      ],
                      if (_selectedTopics.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          '📚 Topik Dipilih:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF1A2C3E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _selectedTopics.map((topic) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4F46E5)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  topic,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF4F46E5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _basicItems.forEach((item) => item.isChecked = false);
                          _customItems.forEach((item) => item.isChecked = false);
                          _selectedTopics.clear();
                          _selectAllBasic = false;
                          _selectAllCustom = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======= DATA MODELS =======
class CheckboxItem {
  final String title;
  final String subtitle;
  final IconData icon;
  bool isChecked;

  CheckboxItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isChecked,
  });
}

class ToggleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  bool isToggled;

  ToggleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isToggled,
  });
}