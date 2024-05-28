// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List mhsdata = [];
  Future<void> baca_data() async {
    String uri = "http://192.168.1.14/akademik/dbkoneksi.php";
    try {
      //perintah untuk koneksi server
      final respon = await http.get(Uri.parse(uri));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          mhsdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    baca_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text(
            'CRUD MAHASISWA',
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        body: ListView.builder(
          itemCount: mhsdata.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(mhsdata[index]['nim']),
              subtitle: Text(mhsdata[index]['nama_mhs']),
            );
          },
        ),
      ),
    );
  }
}
