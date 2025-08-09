import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';

abstract class AuthenticationRepo {
  EitherResponse<LoginResponseModel> loginFnc({
    required String phone,
    required String password,
  });
  EitherResponse<void> logOut({required String token});
  EitherResponse<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  });
  EitherResponse<void> updateProfile({
    required String token,
    required int userId,
    required String username,
    required String email,
    required String phone,
    required String shopName,
    required String licenseNumber,
    required String address,
    required String imageUrl,
  });

  EitherResponse<SignUpResponseModel> signUp({
    required String password,
    required String username,
    required String email,
    required String phone_number,
    required String firstName,
    required String lastName,
    required bool is_barber,
    required String shop_name,
    required String shop_address,
    required String licensceNumber,
    required String shop_image_url,
  });
}
