import 'package:flutter/cupertino.dart';

class ReadKaryawanResponse {

  ReadKaryawanResponse({
    this.karyawan,
  });

  List<Karyawan>? karyawan;

  factory ReadKaryawanResponse.fromJson(Map<String, dynamic> json) => ReadKaryawanResponse(
    karyawan: List<Karyawan>.from(json["karyawan"].map((x) => Karyawan.fromJson(x))),
  );

}
class Karyawan {
  Karyawan({
    this.nik,
    this.nama,
  });

  String? nik;
  String? nama;

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
    nik: json["nik"],
    nama: json["nama"],
  );
}