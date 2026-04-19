import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Silahkan edit teks di bawah ini sesuai keinginan
    const String summary = 
        "Seorang pengembang aplikasi mobile yang berfokus pada teknologi Flutter. "
        "Memiliki ketertarikan kuat dalam membangun UI yang bersih dan fungsional.";

    const List<Map<String, String>> experienceList = [
      {
        "year": "2023 - Sekarang",
        "title": "Mahasiswa Sistem Informasi",
        "company": "Google",
        "keterangan" : "- Membuat aplikasi manajemen perpustakaan terhadap persediaan buku dan juga aplikasi online kasir sederhana untuk pelanggan  memesan buku pada perpustakaan tertentu/terdekat",
        "keterangan 1" : "- Membuat Alert dan Toast pada sebuah aplikasi untuk pengguna."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              summary,
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 32),
            const Text(
              "Experience",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Loop untuk menampilkan list pengalaman
            ...experienceList.map((exp) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp["year"]!,
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp["title"]!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          exp["keterangan"]!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          exp["keterangan 1"]!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        Text(
                          exp["company"]!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}