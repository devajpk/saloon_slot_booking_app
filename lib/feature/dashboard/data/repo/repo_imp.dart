import 'package:either_dart/either.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';
import 'package:project_k/feature/dashboard/data/data_sorce/remote_data_Source.dart';
import 'package:project_k/feature/dashboard/domain/repo/repo.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';
class HomeRepoImpl implements HomeRepo {
  final RemoteHomeDataSource dataSource;

  HomeRepoImpl({required this.dataSource});

  @override
  EitherResponse<ProfileResponseModel> getProfile(String token) {
    // TODO: implement getAdvertisements
    return dataSource.getProductsFavorites(token);
  }

}
