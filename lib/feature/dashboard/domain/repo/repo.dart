import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';

abstract class HomeRepo {
  EitherResponse<ProfileResponseModel> getProfile(String token);
}
