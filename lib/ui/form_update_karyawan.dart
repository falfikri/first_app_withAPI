import 'dart:convert';
import 'package:crud_api/model/read_karyawan_response.dart';
import 'package:crud_api/model/update_karyawan_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormUpdateKaryawanScreen extends StatefulWidget {
  final Karyawan? data;

  const FormUpdateKaryawanScreen({Key? key, this.data}) : super(key: key);
  @override
  _FormUpdateScreenKaryawanState createState() => _FormUpdateScreenKaryawanState();
}
class _FormUpdateScreenKaryawanState extends State<FormUpdateKaryawanScreen> {

  final TextEditingController? _controllerTxtNik = TextEditingController();
  final TextEditingController? _controllerTxtNama = TextEditingController();

  Future<void> updatekaryawan(String nik, String nama) async {
    String? pesan;
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=updateKaryawan');
      final response = await client.post(url, body: {"nik": nik, "nama": nama});
      if (response.statusCode == 200) {
        UpdateKaryawanResponse updateKaryawanResponse = UpdateKaryawanResponse.fromJson(json.decode(response.body.toString()));
        if(updateKaryawanResponse.status==true){
          pesan = updateKaryawanResponse.pesan.toString();
        }else{
          pesan = "Gagal mengupdate data karyawan";
        }
      } else {
        pesan = "Gagal mengupdate data karyawan";
      }
    }catch(e){
      pesan = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan!)));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.data != null){
      _controllerTxtNik!.text = widget.data!.nik!;
      _controllerTxtNama!.text = widget.data!.nama!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Update Karyawan",
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
                    readOnly: true,
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
                      updatekaryawan(nik, nama);
                    },
                    child: const Text('Update'),
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
