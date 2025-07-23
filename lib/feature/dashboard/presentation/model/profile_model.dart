class ProfileResponseModel {
  final int? userId;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final bool? isBarber;
  final String? shopName;
  final String? shopAddress;
  final String? shopImageUrl;
  final String? licenseNumber;

  ProfileResponseModel({
    this.userId,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isBarber,
    this.shopName,
    this.shopAddress,
    this.shopImageUrl,
    this.licenseNumber,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['result'] ?? json;
    return ProfileResponseModel(
      userId: data['user_id'],
      username: data['username'],
      email: data['email'],
      phoneNumber: data['phone_number'],
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      isBarber: data['is_barber'],
      shopName: data['shop_name'],
      shopAddress: data['shop_address'],
      shopImageUrl: data['shop_image_url'],
      licenseNumber: data['license_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'is_barber': isBarber,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'shop_image_url': shopImageUrl,
      'license_number': licenseNumber,
    };
  }
}
