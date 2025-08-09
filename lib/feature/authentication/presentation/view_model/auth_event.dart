import 'package:flutter/widgets.dart';

abstract class AuthenticationEvent {}

class LoginRequested extends AuthenticationEvent {
  final String username;
  final String password;
  final BuildContext context;

  LoginRequested({
    required this.username,
    required this.password,
    required this.context,
  });
}
class ChangePassword extends AuthenticationEvent {
  final String currentPassword;
  final String newPassword;
  final BuildContext context;

  ChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.context,
  });
}
class UpdateProfileRequest extends AuthenticationEvent {
  final BuildContext context;
  final int userId;
  final String username;
  final String email;
  final String phoneNumber;
  final String shopName;
  final String licenseNumber;
  final String shopAddress;
  final String imageUrl;

  UpdateProfileRequest({
    required this.context,
    required this.userId,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.shopName,
    required this.licenseNumber,
    required this.shopAddress,
    required this.imageUrl,
  });
}
class Logout extends AuthenticationEvent {
  final BuildContext context;

  Logout({
    required this.context,
  });
}

class SignUpRequest extends AuthenticationEvent {
  final String username;
  final String password;
  final String email;
  final String phone_number;
  final String firstName;
  final String lastName;
  final bool is_barber;
  final String shop_name;
  final String shop_address;
  final String licensceNumber;
  final String shop_image_url;
  final BuildContext context;

  SignUpRequest({
    required this.username,
    required this.password,
        required this.email,
            required this.phone_number,
          required  this.firstName,
              required this.lastName,
              this.is_barber=false,
                  required this.shop_name,
                  required this.shop_address,
                  required this.licensceNumber,
                      required this.shop_image_url,






    required this.context,
  });
}
