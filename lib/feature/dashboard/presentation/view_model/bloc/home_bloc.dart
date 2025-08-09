import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/feature/dashboard/domain/repo/repo.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_event.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo homeRepo;

  HomeBloc({required this.homeRepo}) : super(HomeState.initial()) {
    on<GetProfile>(sted);
    on<UpdateShopStatus>(updateShopStatus);
    on<GetShopDetails>(getShopDetails);
    on<SearchShop>(searchShop);
    on<ShopDetails>(shopDetail);
  }

  Future<void> sted(GetProfile event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final String? token = await SharedPrefHelper.getToken();
    try {
      print("khz $token");
      if (token == null) {
        emit(state.copyWith(isLoading: false, error: "Token not found"));
        print("token is empty");
        return;
      }

      final response = await homeRepo.getProfile(token);

      response.fold(
        (err) {
          print("khzxyz $token");
          emit(state.copyWith(isLoading: false, error: err));
        },
        (ads) {
          // add(
          //                         GetShopDetails(context:context),
          // );
          print("khzxy $token");
          print(ads.toJson());
          emit(
            state.copyWith(isLoading: false, profile: [ads], isLoaded: true),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> shopDetail(ShopDetails event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final String? token = await SharedPrefHelper.getToken();
    try {
      print("khz $token");
      if (token == null) {
        emit(state.copyWith(isLoading: false, error: "Token not found"));
        print("token is empty");
        return;
      }

      final response = await homeRepo.getShopDetails(token, event.barberId);

      response.fold(
        (err) {
          print("khzxyz $token");
          emit(state.copyWith(isLoading: false, error: err));
        },
        (ads) {
         emit(state.copyWith(isLoading: false, shopdetails: [ads], isLoaded: true));
          print("ggxx ${state.shopdetails}");
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> searchShop(SearchShop event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final String? token = await SharedPrefHelper.getToken();
    try {
      print("khz $token");
      if (token == null) {
        emit(state.copyWith(isLoading: false, error: "Token not found"));
        print("token is empty");
        return;
      }

      final response = await homeRepo.searchShope(token, event.searchText);

      response.fold(
        (err) {
          print("khzxyz $token");
          emit(state.copyWith(isLoading: false, error: err));
        },
        (ads) {
          emit(state.copyWith(isLoading: false, shops: ads, isLoaded: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> getShopDetails(
    GetShopDetails event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final String? token = await SharedPrefHelper.getToken();
    try {
      print("khz $token");
      if (token == null) {
        emit(state.copyWith(isLoading: false, error: "Token not found"));
        print("token is empty");
        return;
      }

      final response = await homeRepo.getShop(token);

      response.fold(
        (err) {
          print("khzxyz $token");
          emit(state.copyWith(isLoading: false, error: err));
        },
        (ads) {
          print("khzxy $token");
          emit(state.copyWith(isLoading: false, isLoaded: true, shops: ads));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateShopStatus(
    UpdateShopStatus event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: false, error: null));

    try {
      final tokens = await SharedPrefHelper.getToken();
      final response = await homeRepo.updateShopStatus(tokens!, event.status);

      response.fold((err) {
        emit(state.copyWith(isLoading: false, error: err));
      }, (ads) {});
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
