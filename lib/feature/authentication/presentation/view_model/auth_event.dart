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
