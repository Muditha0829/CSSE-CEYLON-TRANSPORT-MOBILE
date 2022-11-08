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
          title: const Text('Sign In'),
        ),
        body:  Center(
          child: Wrap(
            children: <Widget> [
              Column(
                children: <Widget> [
                  Text('Seems like you have signed in !'),
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
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> GenerateQr(auth.currentUser!.uid)));
                      },
                      child: const Text('Show QR'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const ScanQr()));
                    },
                    child: const Text('Test1'),
                  ),
                ],
              )
            ],
          ),


        )
    );
  }
}
