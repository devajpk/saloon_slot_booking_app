class AuthenticationState {
  final bool isLoading;
  final String error;
  final String token;

  AuthenticationState({
    required this.isLoading,
    required this.error,
    required this.token,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(isLoading: false, error: '', token: '');
  }

  AuthenticationState copyWith({
    bool? isLoading,
    String? error,
    String? token,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
    );
  }

  @override
  String toString() =>
      'AuthenticationState(isLoading: $isLoading, error: $error, token: $token)';
}
