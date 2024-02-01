// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scannerapp/login.dart';
import 'package:scannerapp/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // ฟังก์ชันหาวันเวลาปัจจุบันของเครื่อง
  String getCurrentDateTime() {
    DateTime now = DateTime.now(); // วันเวลาปัจจุบัน
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm a').format(now); // กำหนด format วันเวลา
    return formattedDate; // ส่งค่ากลับ
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text('MENU', style: TextStyle(fontSize: 18),),
            actions: [
              // show current date and time format dd/MM/yyyy HH:mm pm or am
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text(
                  getCurrentDateTime(), 
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {

                  // Clear SharedPreferences
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );

                },
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Basic'.toUpperCase(),),
                Tab(text: 'Purchase'.toUpperCase(),),
                Tab(text: 'Prod'.toUpperCase(),),
                Tab(text: 'Invent'.toUpperCase(),),
                Tab(text: 'Sales'.toUpperCase(),),
                Tab(text: 'Other'.toUpperCase(),),
              ]
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bghome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: TabBarView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                            ),
                          ),
                          child: const Text('Load Item Onhand', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                            ),
                          ),
                          child: const Text('Take (Online)', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                            ),
                          ),
                          child: const Text('Sync To AX2012', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Purchase Recieve', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const Product()),
                            );
                          },
                          child: const Text('Picking list (ตัดเบิก)', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Picking list (รับคืน)', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Report as finished', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Transfer Item.', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Transfer Journal.', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Movement Journal.', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Movement Journal Spare part', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Counting Journal.', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Picking list registration', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Confirm PackingSlip', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Check On-Hand', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ]
                  ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}
