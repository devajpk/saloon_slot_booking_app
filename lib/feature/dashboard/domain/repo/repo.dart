import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/login_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/shop_details.dart';
import 'package:project_k/feature/dashboard/presentation/model/shops_model.dart';

abstract class HomeRepo {
  EitherResponse<ProfileResponseModel> getProfile(String token);
   EitherResponse<List<ShopModel>> getShop(String token);
   EitherResponse<ShopDetails> getShopDetails(String token,int barberId);
    EitherResponse<List<ShopModel>> searchShope(String token,searchText);
   EitherResponse<void> updateShopStatus(String token,bool newStatus);
   
}
