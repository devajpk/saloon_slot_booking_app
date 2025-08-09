import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';

class RemoteAuthDataSource {
  RemoteAuthDataSource();

  EitherResponse<LoginResponseModel> login(
    String emailOrPhone,
    String password,
  ) async {
    return NetworkService.postEither<Map<String, dynamic>, LoginResponseModel>(
      endPoint: AppUrl.login,
      body: {"phone_number": emailOrPhone, "password": password},
      jsonTransform: (json) => LoginResponseModel.fromJson(json),
      useAuthToken: false,
    );
  }

  EitherResponse<void> logOut(String token) async {
    return NetworkService.postEither(
      useAuthToken: true,
      body: {"logout_all_devices": false},
      endPoint: AppUrl.logOut,
      jsonTransform: (json) {},
    );
  }
  EitherResponse<void> updateProfile({
    required int userId,
    required String username,
    required String email,
    required String phone,
    required String shopName,
    required String licenseNumber,
    required String address,
    required String imageUrl,
  }) {
    return NetworkService.putEither<Map<String, dynamic>, void>(
      endPoint: AppUrl.updateProfile,
      body: {
        'username': username,
        'email': email,
        'phone': phone,
        'shop_name': shopName,
        'license_number': licenseNumber,
        'address': address,
        'profile_image': imageUrl,
      },
      jsonTransform: (_) => null,
      useAuthToken: true,
    );
  }


  EitherResponse<void> changePassword(
    String token,
    String currentPassword,
    String newPassword,
  ) async {
    return NetworkService.postEither<Map<String, dynamic>, void>(
      endPoint: AppUrl.changePassword,
      body: {
        "current_password": currentPassword,
        "new_password": newPassword,
        "confirm_new_password": newPassword,
      },
      jsonTransform: (json) {
        return null;
      },
      useAuthToken: true,
    );
  }

  EitherResponse<SignUpResponseModel> signUp(
    String password,
    final String username,
    String email,
    String phone_number,
    String firstName,
    String lastName,
    bool is_barber,
    String shop_name,
    String shop_address,
    String licensceNumber,
    String shop_image_url,
  ) async {
    return NetworkService.postEither<Map<String, dynamic>, SignUpResponseModel>(
      endPoint: AppUrl.signUp,
      body: {
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phone_number,
        "first_name": firstName,
        "last_name": lastName,
        "is_barber": is_barber,
        "shop_name": shop_name,
        "shop_address": shop_address,
        "shop_image_url": shop_image_url,
      },
      jsonTransform: (json) => SignUpResponseModel.fromJson(json),
      useAuthToken: false,
    );
  }
}
