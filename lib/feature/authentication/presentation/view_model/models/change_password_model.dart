class ChangePasswordResponse {
  final String code;
  final String status;
  final String message;

  ChangePasswordResponse({
    required this.code,
    required this.status,
    required this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      code: json['code'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
