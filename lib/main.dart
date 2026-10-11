import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  // ข้อ 24: จำเป็นต้องเรียกก่อน runApp เมื่อมีการใช้ฐานข้อมูล (sqflite)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}