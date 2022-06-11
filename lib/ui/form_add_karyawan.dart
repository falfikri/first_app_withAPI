import 'dart:convert';
import 'package:crud_api/model/save_karyawan_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormAddKaryawanScreen extends StatefulWidget {
  const FormAddKaryawanScreen({Key? key}) : super(key: key);
  @override
  _FormAddScreenKaryawanState createState() => _FormAddScreenKaryawanState();
}

class _FormAddScreenKaryawanState extends State<FormAddKaryawanScreen> {
  final TextEditingController? _controllerTxtNik = TextEditingController();
  final TextEditingController? _controllerTxtNama = TextEditingController();

Future<void> savekaryawan(String nik, String nama) async {
    String? pesan;
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=saveKaryawan');
      final response = await client.post(url, body: {"nik": nik, "nama": nama});
      if (response.statusCode == 200) {
        SaveKaryawanResponse saveKaryawanResponse = SaveKaryawanResponse.fromJson(json.decode(response.body.toString()));
        if(saveKaryawanResponse.status==true){
          pesan = saveKaryawanResponse.pesan.toString();
        }else{
          pesan = "Gagal menyimpan data karyawan";
        }
      } else {
        pesan = "Gagal menyimpan data karyawan";
      }
    }catch(e){
      pesan = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan!)));
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Add Karyawan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _controllerTxtNik,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "NIK Karyawan",
                    ),
                  ),

                  TextFormField(
                    controller: _controllerTxtNama,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Nama Karyawan",
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String? nik = _controllerTxtNik!.text.toString();
                      String? nama = _controllerTxtNama!.text.toString();
                      savekaryawan(nik, nama);
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}