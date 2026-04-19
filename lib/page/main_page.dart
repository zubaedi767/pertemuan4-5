import 'package:flutter/material.dart';
import 'package:pertemuan4/page/beranda_page.dart';
import 'package:pertemuan4/page/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  // Data Profil Default
  Map<String, String> dataProfil = {
    "nama": "Muhamad Zubaedi",
    "pekerjaan": "ANDROID DEVELOPER",
    "deskripsi": "Deskripsi singkat mengenai pengalaman atau bio kamu.",
    "foto": "https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=1470&auto=format&fit=crop",
    "project": "0",
    "followers": "0",
    "lokasi": "Jakarta, Indonesia",
  };

  // Fungsi untuk memperbarui data
  void updateProfil(Map<String, String> dataBaru) {
    setState(() {
      dataProfil = dataBaru;
    });
  }

  // Fungsi untuk menghapus/reset data (Sesuai permintaan tombol delete)
  void deleteProfil() {
    setState(() {
      dataProfil = {
        "nama": "Data Dihapus",
        "pekerjaan": "-",
        "deskripsi": "Silahkan isi kembali data profil anda.",
        "foto": "https://cdn-icons-png.flaticon.com/512/149/149071.png", // Avatar default
        "project": "0",
        "followers": "0",
        "lokasi": "-",
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // List halaman dengan passing data dan fungsi callback
    final List<Widget> pages = [
      BerandaPage(
        dataAwal: dataProfil, 
        onUpdate: updateProfil,
        onDelete: deleteProfil, // Menghubungkan tombol delete di Beranda
      ),
      ProfilePage(data: dataProfil),
    ];

    return Scaffold(
      // IndexedStack menjaga posisi scroll dan state saat pindah tab
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SalomonBottomBar(
              currentIndex: currentPage,
              onTap: (i) => setState(() => currentPage = i),
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.dashboard_rounded),
                  title: const Text("Beranda"),
                  selectedColor: Colors.blueAccent,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person_rounded),
                  title: const Text("Profil"),
                  selectedColor: Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}