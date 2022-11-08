import 'package:bus_ticketing_system/screens/home/profile.dart';
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
          child: Wrap(
            children: <Widget> [
              Column(
                children: <Widget> [
                  const Text('Seems like you have signed in !'),
                  ElevatedButton(
                    onPressed: () async {
                      dynamic result = await _auth.signOut();
                      print(result);
                      if(result=='Success'){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Successfully Signed Out'),
                            ));
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                      }

                    },
                    child: const Text('Sign Out'),

                  ),
          ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.signOut();
              print(result);
              if(result=='Success'){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfully Signed Out'),
                    ));
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
              }

            },
            child: const Text('My Profile'),)
                ],
              )
            ],
          ),


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
