import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';

class BookingState {
  final bool isLoading;
  final String error;
  final String token;
  final List<MySloteModel> mySlote;

  BookingState({
    required this.isLoading,
    required this.error,
    required this.token,
    required this.mySlote,
  });

  factory BookingState.initial() {
    return BookingState(
      isLoading: false,
      error: '',
      token: '',
      mySlote: [],
    );
  }

  BookingState copyWith({
    bool? isLoading,
    String? error,
    String? token,
    List<MySloteModel>? mySlote,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
      mySlote: mySlote ?? this.mySlote,
    );
  }

  @override
  String toString() =>
      'BookingState(isLoading: $isLoading, error: $error, token: $token, mySlote: $mySlote)';
}
