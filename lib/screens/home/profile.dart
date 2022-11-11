import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/SingleUser.dart';
import '../../services/auth.dart';


class Profile extends StatefulWidget {

  final String userId;

  const Profile(this.userId, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final AuthService auth = AuthService();
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    String userId = widget.userId;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: const Text('Profile'),
    ),
    body: FutureBuilder<SingleUser?>(
      future: readUser(userId),
      builder: (context,snapshot){
        if(snapshot.hasData){
          final user = snapshot.data;

          return user==null
              ? Center(child: Text('No User'))
              : buildUser(user);
        }else{
          return Center(child: Text('No Data ! '));
        }
      },
    )
    );
  }

 Future<SingleUser?> readUser(userId) async {

    final docUser = _fireStore.collection("userData").doc(userId);
    final snapshot = await docUser.get();

    if(snapshot.exists){
      return SingleUser.fromJson(snapshot.data()!);
    }
    return null;
 }

  Widget buildUser(SingleUser? user) =>ListTile(
    title: Text(user!.fullName),
    subtitle: Text(user!.email),
  );
}



