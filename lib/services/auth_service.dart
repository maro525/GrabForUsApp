import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient;

  AuthService(this._supabaseClient);

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return response.user?.id;
    } catch (error) {
      throw Exception('サインアップに失敗しました: $error');
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user?.id;
    } catch (error) {
      throw Exception('サインインに失敗しました: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (error) {
      throw Exception('サインアウトに失敗しました: $error');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(email);
    } catch (error) {
      throw Exception('パスワードリセットメールの送信に失敗しました: $error');
    }
  }

  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }

  Stream<AuthState> authStateChanges() {
    return _supabaseClient.auth.onAuthStateChange;
  }
}
