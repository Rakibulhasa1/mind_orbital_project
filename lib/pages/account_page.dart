import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../models/user.dart';

class AccountPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Orbital'),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {},
          ),
        ],
      ),
      drawer: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            return _buildDrawer(context, state.user.firstname, state.user.lastname);
          } else {
            return _buildDrawer(context, '', '');
          }
        },
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello, ${state.user.firstname} ${state.user.lastname}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

    );
  }
}

Widget _buildDrawer(BuildContext context, String firstname, String lastname) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0d2a63), Color(0xFF00aaed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 8),
              Text(
                '$firstname $lastname',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Todo'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/todo');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Edit Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/edit');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(AuthLogout());
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          },
        ),
      ],
    ),
  );
}
