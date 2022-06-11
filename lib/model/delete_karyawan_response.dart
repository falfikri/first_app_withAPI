class DeleteKaryawanResponse {
  bool? status;
  String? pesan;

  DeleteKaryawanResponse({
    this.status,
    this.pesan,
  });

  factory DeleteKaryawanResponse.fromJson(Map<String, dynamic> json) =>
      DeleteKaryawanResponse(
        status: json["status"],
        pesan: json["pesan"],
      );
}