class LoginResponse {
  bool? statuslogin;
  String? pesan;

  LoginResponse({
    this.statuslogin,
    this.pesan,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        statuslogin: json["statuslogin"],
        pesan: json["pesan"],
      );
}