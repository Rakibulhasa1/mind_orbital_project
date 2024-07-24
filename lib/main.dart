import 'package:auth_bloc/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart';
import 'repositories/user_repository.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/account_page.dart';
import 'pages/todo_page.dart';
import 'blocs/todo_bloc.dart';
void main() {
  final UserRepository userRepository = UserRepository();

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistrationPage(),
          '/account': (context) => AccountPage(),
          '/todo': (context) => TodoPage(),
          '/edit': (context) => EditProfilePage(),
        },
      ),
    );
  }
}
