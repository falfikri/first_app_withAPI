import 'dart:convert';
import 'package:crud_api/model/register_admin_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormRegisterScreen extends StatefulWidget {
  const FormRegisterScreen({Key? key}) : super(key: key);
  @override
  _FormRegisterAdminState createState() => _FormRegisterAdminState();
}

class _FormRegisterAdminState extends State<FormRegisterScreen> {
  final TextEditingController? _controllerTxtUsername = TextEditingController();
  final TextEditingController? _controllerTxtPassword = TextEditingController();

Future<void> savekaryawan(String username, String password) async {
    String? pesan;
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=registerAdmin');
      final response = await client.post(url, body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        RegisterAdminResponse registerAdminResponse = RegisterAdminResponse.fromJson(json.decode(response.body.toString()));
        if(registerAdminResponse.status==true){
          pesan = registerAdminResponse.pesan.toString();
        }else{
          pesan = "Gagal menyimpan data register";
        }
      } else {
        pesan = "Gagal menyimpan data register";
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
          "Form Register",
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
                    controller: _controllerTxtUsername,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Username",
                    ),
                  ),

                  TextFormField(
                    controller: _controllerTxtPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String? username = _controllerTxtUsername!.text.toString();
                      String? password = _controllerTxtPassword!.text.toString();
                      savekaryawan(username, password);
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