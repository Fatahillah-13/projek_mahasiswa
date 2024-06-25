// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class form_editmhs extends StatefulWidget {
  final Map mhsListData;
  const form_editmhs(mhsdata, {super.key, required this.mhsListData});

  @override
  State<form_editmhs> createState() => _form_editmhsState();
}

class _form_editmhsState extends State<form_editmhs> {
  TextEditingController xnimedit = TextEditingController();

  TextEditingController xnama_mhsedit = TextEditingController();

  TextEditingController xjurusanedit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    xnimedit.text = widget.mhsListData['xnim'];
    xnama_mhsedit.text = widget.mhsListData['xnama'];
    xjurusanedit.text = widget.mhsListData['xjurus'];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Data Siswa'),
          backgroundColor: Colors.blue[200],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xnimedit,
                decoration: InputDecoration(
                    label: Text('Masukkan NIM'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xnama_mhsedit,
                decoration: InputDecoration(
                    label: Text('Masukkan Nama'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: xjurusanedit,
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
                    updateData();
                  },
                  child: Text('Update')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    String uri = "http://192.168.1.13/akademik/update_datamhs.php";
    try {
      final respon = await http.post(Uri.parse(uri), body: {
        'xnim': xnimedit.text,
        'xnama': xnama_mhsedit.text,
        'xjurus': xjurusanedit.text
      });
      if (respon.statusCode == 200) {
        print('Update Berhasil');
      }
    } catch (e) {
      print(e);
    }
  }
}
