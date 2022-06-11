class RegisterAdminResponse {
  bool? status;
  String? pesan;

  RegisterAdminResponse({
    this.status,
    this.pesan,
  });

  factory RegisterAdminResponse.fromJson(Map<String, dynamic> json) =>
      RegisterAdminResponse(
        status: json["status"],
        pesan: json["pesan"],
      );
}