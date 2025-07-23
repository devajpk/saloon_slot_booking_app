class LoginResponseModel {
  final String accessToken;
  final String tokenType;
  final String role;
  final int userId;
  final String? shopImageUrl;

  LoginResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.role,
    required this.userId,
    this.shopImageUrl,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final result = json['result'];
    return LoginResponseModel(
      accessToken: result['access_token'],
      tokenType: result['token_type'],
      role: result['role'],
      userId: result['user_id'],
      shopImageUrl: result['shop_image_url'],
    );
  }
}
