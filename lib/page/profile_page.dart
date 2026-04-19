import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, String> data;

  const ProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Profil Publik",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: data["nama"] == null || data["nama"]!.isEmpty
          ? _buildEmptyState(context)
          : ListView(
              padding: const EdgeInsets.only(bottom: 30),
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 20),
                _buildStatsCard(),
                const SizedBox(height: 20),
                _buildDetailsList(),
              ],
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "Belum Ada Data Profil",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Silakan isi data diri terlebih dahulu",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Kembali ke Beranda"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HEADER DENGAN LOGIKA IMAGE SOURCE ---
  Widget _buildHeaderSection() {
    // Logika untuk menentukan sumber gambar
    String fotoPath = data["foto"] ?? "";
    ImageProvider profileImage;

    if (fotoPath.startsWith('http')) {
      // Jika dari internet
      profileImage = NetworkImage(fotoPath);
    } else if (fotoPath.isNotEmpty && File(fotoPath).existsSync()) {
      // Jika dari galeri lokal
      profileImage = FileImage(File(fotoPath));
    } else {
      // Jika kosong atau error, gunakan placeholder
      profileImage = const NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/149/149071.png");
    }

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=1470&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileImage,
                  onBackgroundImageError: (exception, stackTrace) {
                    // Fallback jika image error
                  },
                  child: fotoPath.isEmpty
                      ? Icon(Icons.person, size: 50, color: Colors.grey[600])
                      : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Text(
          data["nama"] ?? "Nama Tidak Diketahui",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            data["pekerjaan"] ?? "Pekerjaan Tidak Diketahui",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 14, color: Colors.grey.shade500),
            const SizedBox(width: 4),
            Text(
              data["lokasi"] ?? "Lokasi Tidak Diketahui",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- WIDGET KARTU STATISTIK ---
  Widget _buildStatsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                Icons.folder_copy_outlined,
                "Project",
                data["project"] ?? "0",
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey[300],
              ),
              _buildStatItem(
                Icons.people_alt_outlined,
                "Followers",
                data["followers"] ?? "0",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // --- WIDGET DETAIL LIST ---
  Widget _buildDetailsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.info_outline, color: Colors.blue.shade700),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Informasi Lengkap",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildListTile(
              icon: Icons.person_outline,
              title: "Nama Lengkap",
              subtitle: data["nama"] ?? "-",
            ),
            const Divider(height: 1, thickness: 1),
            _buildListTile(
              icon: Icons.work_outline,
              title: "Pekerjaan",
              subtitle: data["pekerjaan"] ?? "-",
            ),
            const Divider(height: 1, thickness: 1),
            _buildListTile(
              icon: Icons.location_on_outlined,
              title: "Lokasi",
              subtitle: data["lokasi"] ?? "-",
            ),
            const Divider(height: 1, thickness: 1),
            _buildListTile(
              icon: Icons.article_outlined,
              title: "Deskripsi Diri",
              subtitle: data["deskripsi"] ?? "Belum ada deskripsi.",
              multiLine: true,
            ),
            const Divider(height: 1, thickness: 1),
            _buildListTile(
              icon: Icons.folder_outlined,
              title: "Total Project",
              subtitle: data["project"] ?? "0",
            ),
            const Divider(height: 1, thickness: 1),
            _buildListTile(
              icon: Icons.people_outline,
              title: "Total Followers",
              subtitle: data["followers"] ?? "0",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool multiLine = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment:
            multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: multiLine ? 5 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}