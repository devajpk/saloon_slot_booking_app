import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';
import 'package:project_k/feature/booking/presentation/model/my_booking_model.dart';
import 'package:project_k/feature/booking/presentation/model/my_bookings_model.dart';

class BookingState {
  final bool isLoading;
  final String error;
  final String token;
  final List<MySloteModel> mySlote;
  final List<BookingModel> booking;
  final List<MyBookingModel> myBook;

  BookingState({
    required this.myBook,
    required this.isLoading,
    required this.error,
    required this.token,
    required this.mySlote,
    required this.booking,
  });

  factory BookingState.initial() {
    return BookingState(
      myBook: [],
      isLoading: false,
      error: '',
      token: '',
      mySlote: [],
      booking: [],
    );
  }

  BookingState copyWith({
    bool? isLoading,
    String? error,
    String? token,
    List<MySloteModel>? mySlote,
    List<BookingModel>? booking,
    List<MyBookingModel>? myBook
  }) {
    return BookingState(
      myBook: myBook??this.myBook,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
      mySlote: mySlote ?? this.mySlote,
      booking: booking ?? this.booking,
    );
  }

  @override
  String toString() =>
      'BookingState(isLoading: $isLoading, error: $error, token: $token, mySlote: $mySlote)';
}
