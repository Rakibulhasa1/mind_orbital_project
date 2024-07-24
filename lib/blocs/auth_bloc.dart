import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogin) {
      yield* _mapLoginToState(event);
    } else if (event is AuthLogout) {
      yield* _mapLogoutToState(event);
    } else if (event is AuthRegister) {
      yield* _mapRegisterToState(event);
    } else if (event is AuthUpdate) {
      yield* _mapUpdateToState(event);
    }
  }

  Stream<AuthState> _mapLoginToState(AuthLogin event) async* {
    try {
      // Simulate login process
      final response = await http.get(
        Uri.parse('https://669666110312447373c26117.mockapi.io/users'),
      );

      if (response.statusCode == 200) {
        final users = jsonDecode(response.body) as List;
        final user = users.firstWhere(
              (user) => user['username'] == event.username && user['password'] == event.password,
          orElse: () => null,
        );

        if (user != null) {
          yield AuthLoggedIn(user: User.fromJson(user));
        } else {
          yield AuthError(message: 'Invalid username or password');
        }
      } else {
        yield AuthError(message: 'Failed to login');
      }
    } catch (e) {
      yield AuthError(message: 'Login failed');
    }
  }

  Stream<AuthState> _mapLogoutToState(AuthLogout event) async* {
    yield AuthLoggedOut();
  }

  Stream<AuthState> _mapRegisterToState(AuthRegister event) async* {
    try {
      // Simulate registration process
      final response = await http.post(
        Uri.parse('https://669666110312447373c26117.mockapi.io/users'),
        body: event.user.toJson(),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        yield AuthLoggedIn(user: event.user);
      } else {
        yield AuthError(message: 'Registration failed');
      }
    } catch (e) {
      yield AuthError(message: 'Registration failed');
    }
  }

  Stream<AuthState> _mapUpdateToState(AuthUpdate event) async* {
    try {
      final response = await http.put(
        Uri.parse('https://669666110312447373c26117.mockapi.io/users/${event.user.id}'),
        body: jsonEncode(event.user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        yield AuthLoggedIn(user: event.user);
      } else {
        yield AuthError(message: 'Update failed');
      }
    } catch (e) {
      yield AuthError(message: 'Update failed');
    }
  }
}
