import 'package:equatable/equatable.dart';
import '../models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;

  const AuthLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
