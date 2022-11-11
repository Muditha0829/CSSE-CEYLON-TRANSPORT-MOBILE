import 'package:bus_ticketing_system/screens/home/profile.dart';
import 'package:bus_ticketing_system/screens/transaction/GenerateQr.dart';
import 'package:bus_ticketing_system/screens/transaction/ScanQr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../authenticate/email_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final AuthService _auth = AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: const Text('Home'),
        ),
        body:  Center(
          child: Text("Home"),
        ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
        DrawerHeader(
        decoration: const BoxDecoration(
        color: Colors.blueAccent,
        ),
        child: Center(child: Wrap(
          children: <Widget>[
            Column(
              children:  const [
                Text('Full Name',style: TextStyle(color: Colors.white)),
                Text('Email',style: TextStyle(color: Colors.white))
              ],
            )
          ],
        ))
      ),
             ListTile(
              title:  const Text('Profile'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
             ListTile(
              title:  const Text('QR Code'),
               onTap: (){
                 final user = auth.currentUser;
                 String? userId = user?.uid;
                 Navigator.push(context, MaterialPageRoute(builder: (_)=> GenerateQr(userId!)));
               },
            ),
            ListTile(
              title:  const Text('Scan QR Code'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const ScanQr()));
              },
            ),
             ListTile(
              title:  const Text('Notifications'),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Account Balance'),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  Text('Payment Methods'),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Account Summary'),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Exit'),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Logout'),
               onTap: () async {
                 dynamic result = await _auth.signOut();
                 print(result);
                 Navigator.pop(context);
                 if(result=='Success'){
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Successfully Signed Out'),
                       ));
                   Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                 }

               },
            ),

      ]
        ),
      ),
    );
  }
}
