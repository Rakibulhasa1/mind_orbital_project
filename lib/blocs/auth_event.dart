import '../models/user.dart';

abstract class AuthEvent {}

class AuthRegister extends AuthEvent {
  final User user;
  AuthRegister(this.user);
}

class AuthLogin extends AuthEvent {
  final String username;
  final String password;
  AuthLogin(this.username, this.password);
}

class AuthUpdate extends AuthEvent {
  final User user;
  AuthUpdate(this.user);
}

class AuthLogout extends AuthEvent {}
