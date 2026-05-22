import 'package:flutter/material.dart';
import 'update_profile_page.dart';
import 'pertemuan6_page.dart';
import 'pertemuan7_page.dart'; 
import 'pertemuan8.dart';
import 'Pertemuan9.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  final List<String> _notifications = [
    '🎯 Tugas Pertemuan 5 sudah dinilai',
    '📚 Materi baru tersedia: Dropdown',
    '⭐ Anda mendapat badge "Rajin Belajar"',
  ];

  // Data modul pembelajaran
  final List<Map<String, dynamic>> _modules = [
    {
      'title': 'Profile Page',
      'subtitle': 'Pertemuan 5',
      'icon': Icons.person_rounded,
      'color': const Color(0xFF6366F1),
      'gradient': [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      'progress': 1.0,
      'badge': 'Selesai',
      'target': const UpdateProfilePage(),
    },
    {
      'title': 'Checkbox',
      'subtitle': 'Pertemuan 6',
      'icon': Icons.check_box_rounded,
      'color': const Color(0xFFF59E0B),
      'gradient': [const Color(0xFFF59E0B), const Color(0xFFF97316)],
      'progress': 0.8,
      'badge': 'Proses',
      'target': const Pertemuan6Page(),
    },
    {
      'title': 'Radio Button',
      'subtitle': 'Pertemuan 7',
      'icon': Icons.radio_button_checked,
      'color': const Color(0xFFEC4899),
      'gradient': [const Color(0xFFEC4899), const Color(0xFFF43F5E)],
      'progress': 0.6,
      'badge': 'Proses',
      'target': const RadiobuttonPage(),
    },
    {
      'title': 'Dropdown',
      'subtitle': 'Pertemuan 8',
      'icon': Icons.restaurant_menu_rounded,
      'color': const Color(0xFF10B981),
      'gradient': [const Color(0xFF10B981), const Color(0xFF059669)],
      'progress': 0.0,
      'badge': 'Baru',
      'target': const Pertemuan8Page(),
    },
    {
      'title': 'Form & Validasi',
      'subtitle': 'Pertemuan 9',
      'icon': Icons.description_rounded,
      'color': const Color(0xFF8B5CF6),
      'gradient': [const Color(0xFF8B5CF6), const Color(0xFF6366F1)],
      'progress': 0.0,
      'badge': 'Baru',
      'target': const Pertemuan9Page(),
    },
    {
      'title': 'Navigation',
      'subtitle': 'Pertemuan 10',
      'icon': Icons.navigation_rounded,
      'color': const Color(0xFF06B6D4),
      'gradient': [const Color(0xFF06B6D4), const Color(0xFF0EA5E9)],
      'progress': 0.0,
      'badge': 'Coming Soon',
      'target': null, // Coming Soon
    },
    {
      'title': 'API & JSON',
      'subtitle': 'Pertemuan 11',
      'icon': Icons.api_rounded,
      'color': const Color(0xFFF97316),
      'gradient': [const Color(0xFFF97316), const Color(0xFFF59E0B)],
      'progress': 0.0,
      'badge': 'Coming Soon',
      'target': null, // Coming Soon
    },
    {
      'title': 'Local Storage',
      'subtitle': 'Pertemuan 12',
      'icon': Icons.storage_rounded,
      'color': const Color(0xFFEF4444),
      'gradient': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      'progress': 0.0,
      'badge': 'Coming Soon',
      'target': null, // Coming Soon
    },
    {
      'title': 'State Management',
      'subtitle': 'Pertemuan 13',
      'icon': Icons.account_tree_rounded,
      'color': const Color(0xFF14B8A6),
      'gradient': [const Color(0xFF14B8A6), const Color(0xFF0D9488)],
      'progress': 0.0,
      'badge': 'Coming Soon',
      'target': null, // Coming Soon
    },
    {
      'title': 'Firebase',
      'subtitle': 'Pertemuan 14',
      'icon': Icons.cloud_rounded,
      'color': const Color(0xFF7C3AED),
      'gradient': [const Color(0xFF7C3AED), const Color(0xFF6D28D9)],
      'progress': 0.0,
      'badge': 'Coming Soon',
      'target': null, // Coming Soon
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0F4F8),
              Color(0xFFE2E8F0),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar Modern
              SliverToBoxAdapter(
                child: _buildModernAppBar(),
              ),
              
              // Search Bar
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildSearchBar(),
                ),
              ),
              
              // Stats Cards
              SliverToBoxAdapter(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildStatsCards(),
                ),
              ),
              
              // Quick Actions
              SliverToBoxAdapter(
                child: _buildQuickActions(),
              ),
              
              // Learning Modules Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Modul Pembelajaran",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Pilih materi yang ingin dipelajari",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF00695C).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.filter_list, color: Color(0xFF00695C)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Fitur filter coming soon!'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Module List View
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final module = _modules[index];
                      return _buildModuleListItem(
                        title: module['title'] as String,
                        subtitle: module['subtitle'] as String,
                        icon: module['icon'] as IconData,
                        color: module['color'] as Color,
                        gradient: module['gradient'] as List<Color>,
                        progress: module['progress'] as double,
                        badge: module['badge'] as String,
                        target: module['target'] as Widget?,
                        index: index,
                      );
                    },
                    childCount: _modules.length,
                  ),
                ),
              ),
              
              // Activity Section
              SliverToBoxAdapter(
                child: _buildActivitySection(),
              ),
              
              // Bottom Padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Avatar dengan animasi pulse
              TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0.95, end: 1.05),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00695C),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00695C).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF00695C),
                    child: Text(
                      "Z",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Halo, Zubaedi! 👋",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getGreeting(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              // Notification Button dengan badge
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Color(0xFF334155)),
                      onPressed: () => _showNotifications(),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Settings Button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.settings_outlined, color: Color(0xFF334155)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Pengaturan coming soon!'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00695C).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari materi pembelajaran...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF00695C)),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00695C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune_rounded, color: Color(0xFF00695C)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Mencari: $value'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.school_rounded,
              value: "4/14",
              label: "Modul Selesai",
              color: const Color(0xFF6366F1),
              gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.timer_rounded,
              value: "12h",
              label: "Waktu Belajar",
              color: const Color(0xFFF59E0B),
              gradient: const [Color(0xFFF59E0B), Color(0xFFF97316)],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.stars_rounded,
              value: "85%",
              label: "Nilai Rata-rata",
              color: const Color(0xFF10B981),
              gradient: const [Color(0xFF10B981), Color(0xFF059669)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required List<Color> gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'icon': Icons.assignment_rounded,
        'label': 'Tugas',
        'color': const Color(0xFF6366F1),
      },
      {
        'icon': Icons.quiz_rounded,
        'label': 'Quiz',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.forum_rounded,
        'label': 'Diskusi',
        'color': const Color(0xFFEC4899),
      },
      {
        'icon': Icons.emoji_events_rounded,
        'label': 'Achievement',
        'color': const Color(0xFF10B981),
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Akses Cepat",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: actions.map((action) {
                return _buildActionButton(
                  icon: action['icon'] as IconData,
                  label: action['label'] as String,
                  color: action['color'] as Color,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label coming soon!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk list item module
  Widget _buildModuleListItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<Color> gradient,
    required double progress,
    required String badge,
    required Widget? target,
    required int index,
  }) {
    final isComingSoon = target == null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          if (isComingSoon) {
            // Tampilkan SnackBar untuk Coming Soon
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('$title - $subtitle akan segera hadir! 🚀'),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: color,
                duration: const Duration(seconds: 2),
              ),
            );
          } else {
            // Navigasi ke halaman yang tersedia
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => target!),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isComingSoon 
                    ? Colors.grey.withOpacity(0.15)
                    : color.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: isComingSoon 
                    ? Colors.grey.withOpacity(0.1)
                    : color.withOpacity(0.1),
                highlightColor: isComingSoon 
                    ? Colors.grey.withOpacity(0.05)
                    : color.withOpacity(0.05),
                onTap: () {
                  if (isComingSoon) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.info_outline, color: Colors.white),
                            const SizedBox(width: 8),
                            Text('$title - $subtitle akan segera hadir! 🚀'),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: color,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => target!),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Icon Container
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isComingSoon 
                                ? [Colors.grey.shade400, Colors.grey.shade600]
                                : gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: isComingSoon 
                                  ? Colors.grey.withOpacity(0.3)
                                  : color.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isComingSoon 
                                          ? Colors.grey.shade500
                                          : const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                                // Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badge == "Baru"
                                        ? const Color(0xFF10B981).withOpacity(0.1)
                                        : badge == "Selesai"
                                            ? const Color(0xFF6366F1).withOpacity(0.1)
                                            : badge == "Proses"
                                                ? const Color(0xFFF59E0B).withOpacity(0.1)
                                                : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: badge == "Baru"
                                          ? const Color(0xFF10B981)
                                          : badge == "Selesai"
                                              ? const Color(0xFF6366F1)
                                              : badge == "Proses"
                                                  ? const Color(0xFFF59E0B)
                                                  : Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isComingSoon)
                                        Padding(
                                          padding: const EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.lock_outline,
                                            size: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      Text(
                                        badge,
                                        style: TextStyle(
                                          color: badge == "Baru"
                                              ? const Color(0xFF10B981)
                                              : badge == "Selesai"
                                                  ? const Color(0xFF6366F1)
                                                  : badge == "Proses"
                                                      ? const Color(0xFFF59E0B)
                                                      : Colors.grey.shade600,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 13,
                                color: isComingSoon 
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Progress Bar
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.grey.shade200,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        progress == 1.0
                                            ? const Color(0xFF10B981)
                                            : isComingSoon
                                                ? Colors.grey
                                                : color,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "${(progress * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isComingSoon ? Colors.grey : color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Arrow/Lock Icon
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isComingSoon 
                              ? Colors.grey.withOpacity(0.1)
                              : color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isComingSoon 
                              ? Icons.lock_outline
                              : Icons.arrow_forward_ios_rounded,
                          color: isComingSoon ? Colors.grey : color,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySection() {
    final activities = [
      {
        'icon': Icons.check_circle_rounded,
        'title': 'Profile Page selesai',
        'time': '2 jam yang lalu',
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.edit_rounded,
        'title': 'Mengerjakan tugas Checkbox',
        'time': '5 jam yang lalu',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.star_rounded,
        'title': 'Mendapat badge "Rajin Belajar"',
        'time': '1 hari yang lalu',
        'color': const Color(0xFF6366F1),
      },
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Aktivitas Terbaru",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Color(0xFF00695C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...activities.map((activity) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (activity['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      color: activity['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          activity['time'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Selamat Pagi, semangat belajar! ☀️';
    if (hour < 15) return 'Selamat Siang, tetap produktif! 🌤️';
    if (hour < 18) return 'Selamat Sore, jangan lupa istirahat! 🌅';
    return 'Selamat Malam, waktunya review materi! 🌙';
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notifikasi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Tutup"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._notifications.map((notification) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00695C).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF00695C),
                    ),
                  ),
                  title: Text(notification),
                  trailing: const Text(
                    "Baru",
                    style: TextStyle(
                      color: Color(0xFF00695C),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}