class SaveKaryawanResponse {
  bool? status;
  String? pesan;

  SaveKaryawanResponse({
    this.status,
    this.pesan,
  });

  factory SaveKaryawanResponse.fromJson(Map<String, dynamic> json) =>
      SaveKaryawanResponse(
        status: json["status"],
        pesan: json["pesan"],
      );
}