import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_near_by/bloc/auth_bloc.dart';
import 'package:hospital_near_by/screens/home_page.dart';
import 'package:hospital_near_by/screens/sign_in.dart';

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccess) {
          return HomePage(user: state.user);
        } else {
          return SignInPage();
        }
      },
    );
  }
}
