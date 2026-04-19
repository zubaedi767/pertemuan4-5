import 'package:flutter/material.dart';
import 'package:pertemuan4/page/beranda_page.dart';
import 'package:pertemuan4/page/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  Map<String, String> dataProfil = {
    "nama": "Muhamad Zubaedi",
    "pekerjaan": "ANDROID DEVELOPER",
    "deskripsi": "Saya adalah pengembang aplikasi mobile pemula yang antusias belajar Flutter dan ekosistem Android.",
    "foto": "https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=1470&auto=format&fit=crop",
    "project": "12",
    "followers": "1.2K",
    "lokasi": "Jakarta, Indonesia",
  };

  void updateProfil(Map<String, String> dataBaru) {
    setState(() {
      dataProfil = dataBaru;
    });
  }

  void hapusProfil() {
    setState(() {
      dataProfil = {
        "nama": "Akun Dihapus",
        "pekerjaan": "-",
        "deskripsi": "Data telah dihapus. Silahkan isi kembali melalui menu edit.",
        "foto": "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        "project": "0",
        "followers": "0",
        "lokasi": "-",
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // List halaman
    final List<Widget> _pages = [
      BerandaPage(
        dataAwal: dataProfil, 
        onUpdate: updateProfil,
        onDelete: hapusProfil, 
      ),
      ProfilePage(data: dataProfil),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ), // Tutup BoxShadow
            ], // Tutup List boxShadow
          ), // Tutup BoxDecoration
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SalomonBottomBar(
                currentIndex: currentPage,
                onTap: (i) => setState(() => currentPage = i),
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home_rounded),
                    title: const Text("Beranda"),
                    selectedColor: Colors.blueAccent,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.person_rounded),
                    title: const Text("Profile"),
                    selectedColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}