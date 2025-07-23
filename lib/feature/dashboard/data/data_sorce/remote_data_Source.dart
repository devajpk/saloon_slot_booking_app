import 'dart:convert';

import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';

class RemoteHomeDataSource {
  EitherResponse<ProfileResponseModel> getProductsFavorites(String token) {
    return NetworkService.fetchEither<
      Map<String, dynamic>,
      ProfileResponseModel
    >(
      endPoint: AppUrl.profile,
      jsonTransform: (json) => ProfileResponseModel.fromJson(json),
      useAuthToken: true,
    );
  }
}
