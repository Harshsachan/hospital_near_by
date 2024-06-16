import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_near_by/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('No user logged in'));
    }

    return Center(
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
          SizedBox(height: 20),
          Container(
            width: width*0.5,
            height: height*0.05,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLoggedOut());
                },
                 child: Text("Logout",style: TextStyle(color: Colors.white),)),
          )
        ],
      ),
    );
  }
}
