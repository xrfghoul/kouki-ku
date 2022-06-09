part of 'authentication_cubit.dart';

@immutable
class AuthenticationState {
  final User? currentUser;
  final bool isLoggedIn;

  const AuthenticationState(
      {required this.currentUser, required this.isLoggedIn});
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial(
      {required User? currentUser, required bool isLoggedIn})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class AuthenticationSuccess extends AuthenticationState {
  final String message;

  const AuthenticationSuccess(
      {required User? currentUser,
      required bool isLoggedIn,
      required this.message})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class AuthenticationFailure extends AuthenticationState {
  final String error;
  const AuthenticationFailure(
      {required User? currentUser,
      required bool isLoggedIn,
      required this.error})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class RegisterSuccess extends AuthenticationState {
  final String message;

  const RegisterSuccess(
      {required User? currentUser,
      required bool isLoggedIn,
      required this.message})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class RegisterFailure extends AuthenticationState {
  final String error;
  const RegisterFailure(
      {required User? currentUser,
      required bool isLoggedIn,
      required this.error})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading(
      {required User? currentUser, required bool isLoggedIn})
      : super(currentUser: currentUser, isLoggedIn: isLoggedIn);
}

class LogoutSuccess extends AuthenticationState {
  const LogoutSuccess() : super(currentUser: null, isLoggedIn: false);
}
