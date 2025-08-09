import 'package:either_dart/either.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';
import 'package:project_k/feature/dashboard/data/data_sorce/remote_data_Source.dart';
import 'package:project_k/feature/dashboard/domain/repo/repo.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/shop_details.dart';
import 'package:project_k/feature/dashboard/presentation/model/shops_model.dart';

class HomeRepoImpl implements HomeRepo {
  final RemoteHomeDataSource dataSource;

  HomeRepoImpl({required this.dataSource});

  @override
  EitherResponse<ProfileResponseModel> getProfile(String token) {
    // TODO: implement getAdvertisements
    return dataSource.getProductsFavorites(token);
  }

  @override
  EitherResponse<void> updateShopStatus(String token, bool newStatus) {
    return dataSource.UpdateShopStatus(token, newStatus);
  }

  @override
  EitherResponse<List<ShopModel>> getShop(String token) {
    // TODO: implement getShop
    return dataSource.getShop(token);
  }

  @override
  EitherResponse<List<ShopModel>> searchShope(String token, searchText) {
    return dataSource.searchShop(token, searchText);
  }

  @override
  EitherResponse<ShopDetails> getShopDetails(String token, int barberId) {
    return dataSource.shopDetails(token, barberId);
  }
}
