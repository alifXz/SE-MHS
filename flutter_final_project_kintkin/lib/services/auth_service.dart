import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  static String get currentRole {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.appMetadata['role'] ?? 'user';
  }

  static bool get isAdmin => currentRole == 'admin';

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required int age,
    required String phoneNumber,
  }) async {

    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('User creation failed');
    }

    await supabase.from('users').insert({
      'id': user.id,
      'name': name,
      'email': email,
      'age': age,
      'phone_number': phoneNumber,
    });
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  Future<String> getUserName(String userId) async {
    final response = await supabase
        .from('users')
        .select('name')
        .eq('id', userId)
        .single();

    return response['name'] ?? 'Guest';
  }
}