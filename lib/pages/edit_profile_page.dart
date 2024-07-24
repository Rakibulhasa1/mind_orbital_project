import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../models/user.dart';

class EditProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoggedIn) {
              _firstnameController.text = state.user.firstname;
              _lastnameController.text = state.user.lastname;
              _usernameController.text = state.user.username;

              return Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstnameController,
                        decoration: InputDecoration(labelText: 'Firstname'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your firstname';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        decoration: InputDecoration(labelText: 'Lastname'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your lastname';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthUpdate(User(
                                id: state.user.id,
                                firstname: _firstnameController.text,
                                lastname: _lastnameController.text,
                                username: _usernameController.text,
                                password: _passwordController.text.isEmpty
                                    ? state.user.password
                                    : _passwordController.text,
                              )),
                            );
                          }
                        },
                        child: Text('Update Profile'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Failed to load profile'));
            }
          },
        ),
      ),
    );
  }
}
