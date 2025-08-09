import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';
import 'package:project_k/feature/dashboard/presentation/model/shop_details.dart';
import 'package:project_k/feature/dashboard/presentation/model/shops_model.dart';

class HomeState {
  final bool isLoading;
  final bool isLoaded;
  final String error;
  final String token;
  final List<ProfileResponseModel> profile;
    final List<ShopModel> shops;
     final List<ShopDetails> shopdetails;

  HomeState({
    required this.shopdetails,
    required this.shops,
     required this.isLoaded,
    required this.isLoading,
    required this.error,
    required this.token,
    required this.profile,
  });

  factory HomeState.initial() {
    return HomeState(isLoading: false, error: '', token: '', profile: [],isLoaded: false,shops: [],shopdetails: []);
  }

  HomeState copyWith({
    bool? isLoaded,
    bool? isLoading,
    String? error,
    String? token,
    List<ProfileResponseModel>? profile,
     List<ShopModel>? shops,
     List<ShopDetails>? shopdetails,
  }) {
    return HomeState(
      shops: shops??this.shops,
      isLoaded: isLoaded??this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
      profile: profile ?? this.profile,
      shopdetails: shopdetails??this.shopdetails
    );
  }

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, error: $error, token: $token, profile: $profile)';
}
