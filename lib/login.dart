// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scannerapp/home.dart';
import 'package:scannerapp/services/rest_api.dart';
import 'package:scannerapp/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปร formLoginKey ไว้ผูกกับ Form
  final formLoginKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า username และ password
  String username = '';
  String password = '';

  // สร้างตัวแปรไว้เก็บค่า version และ build number ของแอพ
  String? app_version;

  // สร้าง Method อ่านเวอร์ชั่นและ build number ของแอพ
  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print('app_version: ${packageInfo.version}');

    setState(() {
      app_version = packageInfo.version;
    });
  }

  // ให้เรียกใช้ Method อ่านเวอร์ชั่นและ build number ของแอพ
  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          // color: Color(0xFF5D4037),
          image: DecorationImage(
            image: AssetImage('assets/images/bghome.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formLoginKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอก username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          username = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอก password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // ตรวจสอบความถูกต้องของข้อมูลใน Form
                      if (formLoginKey.currentState!.validate() == false) {
                        return;
                      }
                      // เมื่อกดปุ่ม Login ให้ทำการดึงค่าจาก Form มาเก็บไว้ในตัวแปร
                      formLoginKey.currentState!.save();
                      // แสดงค่า username และ password ที่เก็บไว้ในตัวแปร
                      // print('username: $username');
                      // print('password: $password');

                      // เช็คว่ามีการเชื่อมต่อ Internet ไว้หรือไม่
                      if(await Utility.getInstance()!.checkNetwork() == 'none') {
                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: const Text('มีข้อผิดพลาด'),
                              content: const Text('ไม่มีการเชื่อมต่อ Internet'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text('Close')
                                ),
                              ],
                            );
                          }
                        );
                        return;
                      } else {        
                        // เรียกใช้งาน API Login เพื่อตรวจสอบ username และ password
                        var response = await CallAPI().loginAPI(
                          {
                            'username': username,
                            'password': password,
                          }
                        );
            
                        var body = jsonDecode(response.body);
            
                        // ถ้า username และ password ไม่ถูกต้องให้แสดง popup
                        if (body['status'] == 'fail') {
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text('มีข้อผิดพลาด'),
                                content: const Text('username หรือ password ไม่ถูกต้อง'),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      // clear ค่าใน form
                                      formLoginKey.currentState!.reset();
                                    }, 
                                    child: const Text('Close')
                                  ),
                                ],
                              );
                            }
                          );
                        } else {
                  
                          // เก็บข้อมูลลง shared_preferences
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                  
                          // เก็บค่า username ลง shared_preferences
                          await prefs.setString('pref_username', username);
                  
                          // Login สำเร็จ ไปหน้า Home
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen()
                            ),
                          );    
                        }
                      } // end else
                    }, 
                    child: const Text('LOGIN', style: TextStyle(fontSize: 20)),
                  ),
                ),
                    ]
                  )
                ),
               // Align text to bottom right
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Versionsssss: $app_version',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}