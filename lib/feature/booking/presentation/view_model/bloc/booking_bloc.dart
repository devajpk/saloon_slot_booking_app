import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/feature/authentication/presentation/widget/custom_snack_bar.dart';
import 'package:project_k/feature/booking/domain/repo/repo.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';
import 'package:project_k/feature/dashboard/domain/repo/repo.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';

class BookingBloc extends Bloc<Booking, BookingState> {
  final BookingRepo bookingrepo;

  BookingBloc({required this.bookingrepo}) : super(BookingState.initial()) {
    on<CreateBooking>(createBooking);
    on<GetSlote>(getMySlote);
    on<DeteSlote>(deteSlote);
    on<GetMyBooking>(getMybooking);
    on<ConfirmStatus>(confirmStatus);
    on<Book>(book);
    on<MyBook>(myBook);
  }
  Future<void> myBook(MyBook event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final tokens = await SharedPrefHelper.getToken();
    final response = await bookingrepo.MyBook();

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
        emit(state.copyWith(isLoading: false, myBook: data));
      },
    );
  }

  Future<void> book(Book event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final tokens = await SharedPrefHelper.getToken();
    final response = await bookingrepo.Book(
      token: tokens!,
      slote_id: event.slote_id,
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
        AppleSnackBar.show(context: event.context, message: 'successfull');
        getMybooking(GetMyBooking(context: event.context), emit);
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> createBooking(
    CreateBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

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
        print(" ${state.isLoading}");
        AppleSnackBar.show(
          context: event.context,
          message: 'Slot successfully created!',
        );
        getMybooking(GetMyBooking(context: event.context), emit);
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> confirmStatus(
    ConfirmStatus event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final tokens = await SharedPrefHelper.getToken();
      final response = await bookingrepo.confirmBooking(
        token: tokens!,
        id: event.id,
        new_status: event.new_status,
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
          print("success");
          add(GetMyBooking(context: event.context));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> getMySlote(GetSlote event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    print("getSlote 1");
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
  }

  Future<void> getMybooking(
    GetMyBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    print("getSlote 1");
    final tokens = await SharedPrefHelper.getToken();
    final response = await bookingrepo.getMyBooking(token: tokens!);

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
        print("succes2");
        print(data);
        emit(state.copyWith(isLoading: false, booking: data));
      },
    );
  }

  Future<void> deteSlote(DeteSlote event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final tokens = await SharedPrefHelper.getToken();
      final response = await bookingrepo.deletSlote(
        token: tokens!,
        id: event.id,
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
          final updatedSlots =
              state.mySlote.where((slot) => slot.id != event.id).toList();
          emit(state.copyWith(isLoading: false, mySlote: updatedSlots));
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Slot deleted successfully'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
