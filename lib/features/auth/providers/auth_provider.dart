import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/auth_service.dart';
import '../../../services/supabase_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = AuthService(SupabaseService.instance.client);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final user = _authService.getCurrentUser();
    if (user != null) {
      state = AuthState.authenticated(user);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> signIn(String email, String password) async {
    state = AuthState.loading();
    try {
      final userId =
          await _authService.signIn(email: email, password: password);
      if (userId != null) {
        final user = _authService.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = AuthState.error('User not found after sign in');
        }
      } else {
        state = AuthState.error('Sign in failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    state = AuthState.loading();
    try {
      final userId =
          await _authService.signUp(email: email, password: password);
      if (userId != null) {
        state = AuthState.unauthenticated(); // ユーザー確認が必要な場合
      } else {
        state = AuthState.error('Sign up failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      state = AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

class AuthState {
  final bool isAuthenticated;
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    required this.isAuthenticated,
    this.user,
    required this.isLoading,
    this.errorMessage,
  });

  factory AuthState.initial() =>
      AuthState(isAuthenticated: false, isLoading: true);
  factory AuthState.authenticated(User user) =>
      AuthState(isAuthenticated: true, user: user, isLoading: false);
  factory AuthState.unauthenticated() =>
      AuthState(isAuthenticated: false, isLoading: false);
  factory AuthState.loading() =>
      AuthState(isAuthenticated: false, isLoading: true);
  factory AuthState.error(String message) => AuthState(
      isAuthenticated: false, isLoading: false, errorMessage: message);
}
