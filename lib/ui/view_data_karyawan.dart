import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:crud_api/model/delete_karyawan_response.dart';
import 'package:crud_api/model/read_karyawan_response.dart';
import 'package:crud_api/ui/form_update_karyawan.dart';
import 'form_add_karyawan.dart';

class ViewDataKaryawanScreen extends StatefulWidget {
  const ViewDataKaryawanScreen({Key? key}) : super(key: key);
  @override
  _ViewDataScreenKaryawanState createState() => _ViewDataScreenKaryawanState();
}
class _ViewDataScreenKaryawanState extends State<ViewDataKaryawanScreen> {

  Future<List<Karyawan>?> readkaryawan() async {
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=readKaryawan');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        ReadKaryawanResponse readKaryawanResponse = ReadKaryawanResponse.fromJson(json.decode(response.body.toString()));
        return readKaryawanResponse.karyawan!;
      } else {
        return null;
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }
  Future<void> deletekaryawan(String nik) async {
    String? pesan;
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=deleteKaryawan');
      final response = await client.post(url, body: {"nik": nik});
      if (response.statusCode == 200) {
        DeleteKaryawanResponse deleteKaryawanResponse = DeleteKaryawanResponse.fromJson(json.decode(response.body.toString()));
        if(deleteKaryawanResponse.status==true){
          pesan = deleteKaryawanResponse.pesan.toString();
        }else{
          pesan = "Gagal delete data karyawan";
        }
      } else {
        pesan = "Gagal delete data karyawan";
      }
    }catch(e){
      pesan = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan!)));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Data Karyawan",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormAddKaryawanScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Karyawan>?>(
          future: readkaryawan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Karyawan karyawan = snapshot.data[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: Text(karyawan.nik!),
                        subtitle: Text(karyawan.nama!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red,),
                          onPressed: () {
                            deletekaryawan(karyawan.nik!);
                          },
                        ),
                        onLongPress: () async{
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormUpdateKaryawanScreen(data: karyawan,)),
                          );
                          if (result != null) {
                            if (result == true) {
                              setState(() {});
                            }
                          }
                        },
                      ),
                    );
                  });
            } else {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
          },
        ),
      ),
    );
  }
}