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
  }

  Future<void> sted(GetProfile event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final String? token = await SharedPrefHelper.getToken();
      print("kh $token");
      if (token == null) {
        emit(state.copyWith(isLoading: false, error: "Token not found"));
        return;
      }

      final response = await homeRepo.getProfile(token);

      response.fold(
        (err) {
          emit(state.copyWith(isLoading: false, error: err));
        },
        (ads) {
          print(ads.toJson());
          emit(state.copyWith(isLoading: false, profile: [ads]));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
