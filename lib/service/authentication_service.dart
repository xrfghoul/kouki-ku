import 'dart:typed_data';

import 'package:kokiku/model/user.dart';

abstract class AuthenticationApi {
  Future<User?> signIn({required String email, required String password});
  Future<User?> silentLogin();
  Future<String?> signOut();
  Future<User?> register(User user,
      {required String password, Uint8List? image});
}
