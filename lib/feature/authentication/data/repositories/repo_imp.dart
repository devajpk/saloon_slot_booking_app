import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/data/data_source/remote_data_sorce.dart';
import 'package:project_k/feature/authentication/domain/repository/repo.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final RemoteAuthDataSource remoteDataSoruce;

  AuthenticationRepoImpl({required this.remoteDataSoruce});

  @override
  EitherResponse<SignUpResponseModel> signUp({
   required  String password,
   required  String username,
   required String email,
   required String phone_number,
   required String firstName,
   required String lastName,
   required bool is_barber,
  required  String shop_name,
   required String shop_address,
   required String licensceNumber,
   required String shop_image_url,
 } ) async {
    return remoteDataSoruce.signUp(
      password,
      username,
      email,
      phone_number,
      firstName,
      lastName,
      is_barber,
      shop_name,
      shop_address,
      licensceNumber,
      shop_image_url,

    );
  }

  @override
  EitherResponse<LoginResponseModel> loginFnc({
    required String phone,
    required String password,
  }) {
    return remoteDataSoruce.login(phone, password);
  }
}
