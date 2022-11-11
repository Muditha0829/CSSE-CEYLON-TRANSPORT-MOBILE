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

  late final String UserId;

  @override
  void initState() {
    _auth.getCurrentUserId().then((String? result) {
      setState(() {
        UserId = result!;
      });
    }
    );

    super.initState();
  }

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
                moveToProfile();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>  Profile(UserId)));
              },
            ),
             ListTile(
              title:  const Text('QR Code'),
               onTap: (){
                 // Navigator.pop(context);
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
              title:  const Text('Payment Methods'),
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

  void moveToProfile(){
  final userId =  auth.currentUser?.uid;
  if(userId!=null){
    changeScreen(userId);
  }
  }

  void changeScreen(userId) {

    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return Profile(userId);
    }));
  }
}
