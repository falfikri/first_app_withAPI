import 'dart:convert';
import 'package:crud_api/model/login_response.dart';
import 'package:crud_api/ui/form_register.dart';
import 'package:crud_api/ui/view_data_karyawan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormLoginScreen extends StatefulWidget {
  const FormLoginScreen({Key? key}) : super(key: key);
  @override
  _FormLoginScreenKaryawanState createState() => _FormLoginScreenKaryawanState();
}

class _FormLoginScreenKaryawanState extends State<FormLoginScreen> {

  final TextEditingController? _controllerTxtUsername = TextEditingController();
  final TextEditingController? _controllerTxtPassword = TextEditingController();
  Future<void> login(String username, String password) async {
    String? pesan;
    bool? nextScreen = false;
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.174.183:80/api/rest_api.php?action=loginAdmin');
      final response = await client.post(url, body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(json.decode(response.body.toString()));
        if(loginResponse.statuslogin==true){
          pesan = loginResponse.pesan.toString();
          nextScreen = true;
        }else{
          pesan = "Login admin gagal";
        }
      } else {
        pesan = "Login admin gagal";
      }
      }catch(e){
      pesan = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan!)));
    if(nextScreen==true){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewDataKaryawanScreen()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Admin",
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
                      login(username, password);
                    },
                    child: const Text('Login'),
                  ),
                  Container(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FormRegisterScreen()),
                      );
                    },
                    child: const Text('Register'),
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