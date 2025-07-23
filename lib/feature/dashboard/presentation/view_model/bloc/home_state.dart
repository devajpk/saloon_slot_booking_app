import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';

class HomeState {
  final bool isLoading;
  final String error;
  final String token;
  final List<ProfileResponseModel> profile;

  HomeState({
    required this.isLoading,
    required this.error,
    required this.token,
    required this.profile,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: '',
      token: '',
      profile: [],
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? error,
    String? token,
    List<ProfileResponseModel>? profile,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
      profile: profile ?? this.profile,
    );
  }

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, error: $error, token: $token, profile: $profile)';
}

