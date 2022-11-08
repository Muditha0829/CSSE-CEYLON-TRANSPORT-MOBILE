import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

final AuthService _auth = AuthService();

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: const Text('Profile'),
    ),
    body: Center(child: Column(
      children: <Widget>[
        Text('Profile'),
        Text('Full Name'),
        Text('NIC'),
        Text('Email'),
        Text('Phone Number'),
        ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.getUserData();
            print(result);
          },
          child: Text('Sign In' ),
        ),
      ],
    ))
    );
  }
}
