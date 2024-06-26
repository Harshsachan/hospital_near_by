import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_near_by/screens/auth_checker.dart';
import 'package:hospital_near_by/services/google_auth.dart';
import 'package:hospital_near_by/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(FirebaseServices())..add(AuthStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospital Near Me',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(body: AuthChecker()),
        // home: HospitalLocator(),
      ),
    );
  }
}
