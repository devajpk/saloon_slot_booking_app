class SignUpResponseModel {
  final String code;
  final String status;
  final String message;
  final SignUpResult result;

  SignUpResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.result,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      result: SignUpResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'result': result.toJson(),
    };
  }
}

class SignUpResult {
  final String accessToken;
  final String tokenType;
  final String role;
  final int userId;
  final String? shopImageUrl;

  SignUpResult({
    required this.accessToken,
    required this.tokenType,
    required this.role,
    required this.userId,
    this.shopImageUrl,
  });

  factory SignUpResult.fromJson(Map<String, dynamic> json) {
    return SignUpResult(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      role: json['role'],
      userId: json['user_id'],
      shopImageUrl: json['shop_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'role': role,
      'user_id': userId,
      'shop_image_url': shopImageUrl,
    };
  }
}
