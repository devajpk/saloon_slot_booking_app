import 'dart:convert';

import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/shop_details.dart';
import 'package:project_k/feature/dashboard/presentation/model/shops_model.dart';

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

  EitherResponse<List<ShopModel>> getShop(String token) {
    return NetworkService.fetchEither<dynamic, List<ShopModel>>(
      endPoint: AppUrl.getShop,
      jsonTransform:
          (json) => (json as List).map((e) => ShopModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }

  EitherResponse<List<ShopModel>> searchShop(String token, String searchText) {
    return NetworkService.fetchEither<dynamic, List<ShopModel>>(
      queryParams: {'sort_by': searchText},
      endPoint: AppUrl.getShop,
      jsonTransform:
          (json) => (json as List).map((e) => ShopModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }

  EitherResponse<ShopDetails> shopDetails(String token, int barberId) {
    return NetworkService.fetchEither<dynamic, ShopDetails>(
      queryParams: {'barber_id': barberId.toString()},
      endPoint: AppUrl.getShopDetails + barberId.toString(),
      jsonTransform: (json) => ShopDetails.fromJson(json),
      useAuthToken: true,
    );
  }

  EitherResponse<void> UpdateShopStatus(String token, bool newStatus) async {
    return NetworkService.putEither<Map<String, dynamic>, void>(
      endPoint: AppUrl.updateShopStatus,
      queryParams: {"is_open": newStatus.toString().toLowerCase()},
      body: {"is_open": newStatus},
      jsonTransform: (json) {},
      useAuthToken: true,
    );
  }
}
