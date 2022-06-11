class UpdateKaryawanResponse {
  bool? status;
  String? pesan;

  UpdateKaryawanResponse({
    this.status,
    this.pesan,
  });

  factory UpdateKaryawanResponse.fromJson(Map<String, dynamic> json) =>
      UpdateKaryawanResponse(
        status: json["status"],
        pesan: json["pesan"],
      );
}