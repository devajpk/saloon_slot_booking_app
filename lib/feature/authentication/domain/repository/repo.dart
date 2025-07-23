import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';

abstract class AuthenticationRepo {
  EitherResponse<LoginResponseModel> loginFnc({
    required String phone,
    required String password,
  });

  EitherResponse<SignUpResponseModel> signUp({
   required  String password,
   required String username,
   required  String email,
   required  String phone_number,
   required  String firstName,
   required  String lastName,
   required  bool is_barber,
   required  String shop_name,
   required  String shop_address,
   required  String licensceNumber,
  required   String shop_image_url,
  });
}
