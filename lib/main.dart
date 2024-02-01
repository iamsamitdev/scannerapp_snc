import 'package:flutter/material.dart';
import 'package:scannerapp/home.dart';
import 'package:scannerapp/login.dart';
import 'package:scannerapp/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

// สร้างตัวแปร global ไว้เก็บค่า username ที่ login สำเร็จ
var username = '';

void main() async {

  // ต้องการให้แอพทำงานหลังจากที่อ่าน SharedPreferences เสร็จแล้ว
  WidgetsFlutterBinding.ensureInitialized();

  // อ่านข้อมูลจาก SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // อ่านค่า username จาก SharedPreferences
  username = prefs.getString('pref_username') ?? '';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: username == '' ? const LoginScreen() : const HomeScreen(),
    );
  }
}