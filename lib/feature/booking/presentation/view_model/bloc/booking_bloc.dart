import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/feature/booking/domain/repo/repo.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';
import 'package:project_k/feature/dashboard/domain/repo/repo.dart';

class BookingBloc extends Bloc<Booking, BookingState> {
  final BookingRepo bookingrepo;

  BookingBloc({required this.bookingrepo}) : super(BookingState.initial()) {
    on<CreateBooking>(createBooking);
    on<GetSlote>(getMySlote);
  }

  Future<void> createBooking(
    CreateBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final tokens = await SharedPrefHelper.getToken();
      final response = await bookingrepo.createBooking(
        token: tokens!,
        startingAt: event.startingTime,
        endingAt: event.endingTime,
        date: event.data,
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
        (data) {
          print(" hdh $data");
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> getMySlote(GetSlote event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    print("getSlote 1");
    try {
      final tokens = await SharedPrefHelper.getToken();
      final response = await bookingrepo.GetSlote(
        token: tokens!,
        startingAt: event.startingTime,
        endingAt: event.endingTime,
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
        (data) {
          print(" hdh $data");
          emit(state.copyWith(isLoading: false, mySlote: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
