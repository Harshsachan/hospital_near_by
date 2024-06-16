// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hospital_near_by/bloc/auth_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class HomePage extends StatelessWidget {
//   final User user;
//
//   const HomePage({Key? key, required this.user}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome ${user.displayName}'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               context.read<AuthBloc>().add(AuthLoggedOut());
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (user.photoURL != null)
//               CircleAvatar(
//                 backgroundImage: NetworkImage(user.photoURL!),
//                 radius: 50,
//               ),
//             SizedBox(height: 20),
//             Text('Name: ${user.displayName}'),
//             Text('Email: ${user.email}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_near_by/bloc/auth_bloc.dart';
import 'package:hospital_near_by/pages/hospital_locator.dart';
import 'package:hospital_near_by/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static  List<Widget> _pages = <Widget>[
    HospitalLocator(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        centerTitle: true,
        title: Text(_selectedIndex == 0 ? 'Hospital Locator' : 'Profile'),
        actions: [
          if (_selectedIndex == 1)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLoggedOut());
              },
            ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital Locator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
