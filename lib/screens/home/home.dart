import 'package:bus_ticketing_system/screens/authenticate/email_sign_in.dart';
import 'package:bus_ticketing_system/screens/home/profile.dart';
import 'package:bus_ticketing_system/screens/transaction/AccountBalance.dart';
import 'package:bus_ticketing_system/screens/transaction/GenerateQr.dart';
import 'package:bus_ticketing_system/screens/transaction/ScanQr.dart';
import 'package:bus_ticketing_system/screens/transaction/TransactionList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final AuthService _auth = AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  late final String UserId;
  late dynamic result = 'Email';


  @override
  void initState() {
    result = FirebaseAuth.instance.currentUser?.email;
    _auth.getCurrentUserId().then((String? result) {
      setState(() {
        UserId = result!;
      });
    });


    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    result = FirebaseAuth.instance.currentUser?.email;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: const Text('Home',),
        ),
        body:  Center(
          child: ElevatedButton(child: Text('Test'),
          onPressed: (){

          },),
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
              children:   [
                Text((result.toString()),style: TextStyle(color: Colors.white,fontSize: 19))
              ],
            )
          ],
        ))
      ),
             ListTile(
              title:  const Text('Profile',style: TextStyle(fontSize: 18)),
              onTap: (){
                moveToProfile();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>  Profile(UserId)));
              },
            ),
            ListTile(
              title:  const Text('Account Balance',style: TextStyle(fontSize: 18)),
              onTap: (){
                moveToProfile();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>  const AccountBalance()));
              },
            ),
            ListTile(
              title:  const Text('Transaction List',style: TextStyle(fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const TransactionList()));
              },
            ),
             ListTile(
              title:  const Text('QR Code',style: TextStyle(fontSize: 18)),
               onTap: (){
                 final user = auth.currentUser;
                 String? userId = user?.uid;
                 Navigator.push(context, MaterialPageRoute(builder: (_)=> GenerateQr(userId!)));
               },
            ),
            ListTile(
              title:  const Text('Scan QR Code',style: TextStyle(fontSize: 18)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const ScanQr()));
              },
            ),
             ListTile(
              title:  const Text('Notifications',style: TextStyle(fontSize: 18)),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Account Balance',style: TextStyle(fontSize: 18)),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Payment Methods',style: TextStyle(fontSize: 18)),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Account Summary',style: TextStyle(fontSize: 18)),
               onTap: (){
                 // Navigator.pop(context);
               },
            ),
             ListTile(
              title:  const Text('Exit',style: TextStyle(fontSize: 18)),
               onTap: ()async{
                 Navigator.pop(context);

               },
            ),
             ListTile(
              title:  const Text('Logout',style: TextStyle(fontSize: 18,color: Colors.red)),
               onTap: () async {
                 dynamic result = await _auth.signOut();
                 print(result);
                 Navigator.pop(context);
                 if(result=='Success'){
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Successfully Signed Out'),
                       ));
                   Navigator.push(context, MaterialPageRoute(builder: (_)=> EmailSignin()));
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
