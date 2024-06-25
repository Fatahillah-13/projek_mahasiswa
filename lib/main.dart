// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_formmhs.dart';
import 'form_entry.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List mhsdata = [];
  Future<void> baca_data() async {
    String uri = "http://192.168.1.13/akademik/dbkoneksi.php";
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

  Future<void> hapus_datamhs(String xnim) async {
    String uri = "http://192.168.1.13/akademik/hapus_mhs.php";
    try {
      //perintah untuk koneksi server
      final respon = await http.post(Uri.parse(uri), body: {"xnim": xnim});
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
        body: Column(
          children: [
            Container(
              height: 600,
              width: double.infinity,
              child: ListView.builder(
                itemCount: mhsdata.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => form_editmhs(
                              mhsdata,
                              mhsListData: {
                                "xnim": mhsdata[index]['nim'],
                                "xnama": mhsdata[index]['nama_mhs'],
                                "xjurus": mhsdata[index]['jurusan'],
                              },
                            ),
                          ));
                    },
                    title: Text(mhsdata[index]['nim'] +
                        "\n" +
                        mhsdata[index]['nama_mhs']),
                    subtitle: Text(mhsdata[index]['jurusan']),
                    trailing: IconButton(
                      onPressed: () {
                        hapus_datamhs(mhsdata[index]['nim']);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntryMahasiswa(),
                      ));
                },
                child: Text('Tambah'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
