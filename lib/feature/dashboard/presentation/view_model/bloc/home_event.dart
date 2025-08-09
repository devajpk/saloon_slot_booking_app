import 'package:flutter/material.dart';

abstract class HomeEvent {}

class GetProfile extends HomeEvent {
  GetProfile({required BuildContext context});
}

class GetShopDetails extends HomeEvent {
  GetShopDetails({required BuildContext context});
}

class SearchShop extends HomeEvent {
  String searchText;
  SearchShop({required BuildContext context,required this.searchText});
}
class ShopDetails extends HomeEvent {
  int barberId;
  ShopDetails({required BuildContext context,required this.barberId});
}
class UpdateShopStatus extends HomeEvent {
  bool status;
  UpdateShopStatus({required BuildContext context, required this.status});
}
