import 'package:flutter/material.dart';
import 'package:pertemuan4/page/main_page.dart';
import 'package:intl/date_symbol_data_local.dart'; // Sudah benar diimpor
import 'package:intl/intl.dart';

// UBAH BAGIAN INI MENJADI ASYNC
void main() async {
  // 1. Wajib tambahkan ini agar Flutter siap mengeksekusi kode async sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi format tanggal (misal 'id_ID' untuk Indonesia)
  // Anda bisa mengosongkan tanda kurung () jika ingin menginisialisasi semua bahasa bawaan
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 4',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF3F6F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const MainPage(),
    );
  }
}