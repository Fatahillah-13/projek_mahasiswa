// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    home: EntryMahasiswa(),
  ));
}

class EntryMahasiswa extends StatefulWidget {
  const EntryMahasiswa({super.key});

  @override
  State<EntryMahasiswa> createState() => _EntryMahasiswaState();
}

class _EntryMahasiswaState extends State<EntryMahasiswa> {
  TextEditingController xnim = TextEditingController();
  TextEditingController xnama = TextEditingController();
  TextEditingController xjurus = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Input Data Siswa'),
          backgroundColor: Colors.blue[200],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xnim,
                decoration: InputDecoration(
                    label: Text('Masukkan NIM'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xnama,
                decoration: InputDecoration(
                    label: Text('Masukkan Nama'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xjurus,
                decoration: InputDecoration(
                    label: Text('Masukkan Jurusan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    simpanData();
                  },
                  child: Text('Simpan')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> simpanData() async {
    String uri = "http://192.168.1.2/akademik/simpan_mhs.php";
    try {
      final respon = await http.post(Uri.parse(uri), body: {
        'xnim': xnim.text,
        'xnama': xnama.text,
        'xjurus': xjurus.text
      });
      if (respon.statusCode == 200) {
        print('Simpan Berhasil');
      }
    } catch (e) {
      print(e);
    }
  }
}
