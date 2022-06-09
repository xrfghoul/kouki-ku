import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:kokiku/model/user.dart';
import 'package:kokiku/service/authentication_service.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationApi _auth;
  AuthenticationCubit(this._auth)
      : super(
            const AuthenticationInitial(isLoggedIn: false, currentUser: null));

  void silentLogin() async {
    try {
      final user = await _auth.silentLogin();
      await Future.delayed(const Duration(seconds: 3));
      if (user == null) {
        emit(const AuthenticationFailure(
            currentUser: null, isLoggedIn: false, error: "Gagal Login"));
        return;
      }
      emit(AuthenticationSuccess(
          currentUser: user, isLoggedIn: false, message: "Sukses Login"));
    } catch (e) {
      emit(const AuthenticationFailure(
          currentUser: null, isLoggedIn: false, error: "Gagal Login"));
    }
  }

  void register(User user, {required String password, Uint8List? image}) async {
    try {
      final output =
          await _auth.register(user, password: password, image: image);
      emit(AuthenticationSuccess(
          currentUser: output, isLoggedIn: false, message: "Sukses Login"));
    } catch (e) {
      emit(const AuthenticationFailure(
          currentUser: null, isLoggedIn: false, error: "Gagal Login"));
    }
  }

  void loginWithEmail({required String email, required String password}) async {
    try {
      final user = await _auth.signIn(email: email, password: password);
      if (user == null) {
        emit(const AuthenticationFailure(
            currentUser: null, isLoggedIn: false, error: "Gagal Login"));
        return;
      }
      emit(AuthenticationSuccess(
          currentUser: user, isLoggedIn: false, message: "Sukses Login"));
    } catch (e) {
      emit(const AuthenticationFailure(
          currentUser: null, isLoggedIn: false, error: "Gagal Login"));
    }
  }

  void logOut() async {
    try {
      final message = await _auth.signOut();
      emit(const LogoutSuccess());
    } catch (e) {
      emit(AuthenticationFailure(
          currentUser: null, isLoggedIn: false, error: "Logout Failure : $e"));
    }
  }
}
