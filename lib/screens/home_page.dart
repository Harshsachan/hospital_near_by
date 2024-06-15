import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_near_by/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.displayName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLoggedOut());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (user.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 50,
              ),
            SizedBox(height: 20),
            Text('Name: ${user.displayName}'),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
