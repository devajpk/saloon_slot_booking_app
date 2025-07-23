import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/comman/utilse/utilse.dart';
import 'package:project_k/comman/widget/bottom_naviagator.dart';
import 'package:project_k/feature/authentication/domain/repository/repo.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_state.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepo authRepo;
  AuthenticationBloc({required this.authRepo})
    : super(AuthenticationState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequest>(_signUpRequest);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await authRepo.loginFnc(
        phone: event.username,
        password: event.password,
      );

      response.fold(
        (err) {
          emit(state.copyWith(isLoading: false, error: err));
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        (token) async {
          emit(state.copyWith(isLoading: false));
          await SharedPrefHelper.saveToken(token.accessToken);
          await SharedPrefHelper.saveRole(token.role);
          final tokens = await SharedPrefHelper.getToken();
          NetworkService.initAuthToken(() => tokens!);
          event.context.read<HomeBloc>().add(GetProfile());
          Navigator.push(
            event.context,
            MaterialPageRoute(builder: (context) => ScreenParentNavigation()),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      print("object");
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Text("Login faild"),
          backgroundColor: Colors.red, // or Colors.green, Colors.blue, etc.
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _signUpRequest(
    SignUpRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Set loading before request

    final response = await authRepo.signUp(
      licensceNumber: event.licensceNumber,
      username: event.username,
      password: event.password,
      email: event.email,
      phone_number: event.phone_number,
      firstName: event.firstName,
      lastName: event.lastName,
      is_barber: event.is_barber,
      shop_name: event.shop_name,
      shop_address: event.shop_address,
      shop_image_url: event.shop_image_url,
    );

    response.fold(
      (err) {
        emit(state.copyWith(isLoading: false, error: err)); // ❗ Corrected here
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text(err),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      (token) async {
        emit(state.copyWith(isLoading: false)); // Stop loader on success
        await SharedPrefHelper.saveToken(token.result.accessToken);
        await SharedPrefHelper.saveRole(token.result.role);
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => ScreenParentNavigation()),
        );
      },
    );
  }
}
