import 'package:flutter/material.dart';
import 'update_profile_page.dart';
import 'pertemuan6_page.dart';
import 'pertemuan7_page.dart'; 

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang,",
              style: TextStyle(
                color: Color(0xFF8E9AAE),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Zubaedi",
              style: TextStyle(
                color: Color(0xFF1A2C3E),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined, size: 20),
              color: const Color(0xFF5A6B7C),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildStatCard(), // Progress card diperbarui di bawah
            const SizedBox(height: 28),
            const Text(
              "Menu Utama",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF1A2C3E),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
                children: [
                  _buildModernCard(
                    context,
                    title: "Pertemuan 5",
                    subtitle: "Update Profile",
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFF4F46E5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdateProfilePage()),
                      );
                    },
                  ),
                  _buildModernCard(
                    context,
                    title: "Pertemuan 6",
                    subtitle: "Form Checkbox",
                    icon: Icons.checklist_rounded,
                    color: const Color(0xFF10B981),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Pertemuan6Page()),
                      );
                    },
                  ),
                  _buildModernCard(
                    context,
                    title: "Pertemuan 7",
                    subtitle: "Form RadioButton", // Diganti dari "Coming Soon"
                    icon: Icons.radio_button_checked_rounded, // Ikon lebih relevan
                    color: const Color(0xFF00695C), // Warna Teal sesuai source code
                    onTap: () {
                      Navigator.push(
                        context,
                        // Cari baris ini di beranda_page.dart
MaterialPageRoute(builder: (context) => const RadiobuttonPage()), // Gunakan RadiobuttonPage,
                      );
                    },
                  ),
                  _buildModernCard(
                    context,
                    title: "Pertemuan 8",
                    subtitle: "Terkunci",
                    icon: Icons.lock_outline_rounded,
                    color: const Color(0xFF94A3B8),
                    onTap: () => _message(context, "Pertemuan 8 Terkunci"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard() {
    // Update progress: 3 dari 8 = 0.375
    double progress = 3 / 8; 

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Color(0xFF4F46E5),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Progress Belajar",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E9AAE),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFFE2E8F0),
                    color: const Color(0xFF4F46E5),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${(progress * 100).toInt()}% • 3 dari 8 pertemuan",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8E9AAE),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildModernCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A2C3E),
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}