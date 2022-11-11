import 'package:bus_ticketing_system/screens/home/updateprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              ? const Center(child: Text('No User'))
              : buildUser(user);
        }else{
          return const Center(child: Text('No Data ! '));
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

  Widget buildUser(SingleUser user){
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Text(
               user.fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 38,
                ),
              ),
              Text(
                user.uid,
                style: const TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: const EdgeInsets.only( top: 10.0,left: 20.0,right: 20.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(('Personal Info').toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    Column(
                      children: const <Widget>[
                        Icon(Icons.abc_outlined,size: 40.0,),

                      ],
                    ),
                    Column(
                      children: <Widget> [
                        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(user.fullName,
                          style: const TextStyle(fontSize: 20),),)
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    Column(
                      children: const <Widget>[
                        Icon(Icons.email_outlined,size: 40.0,),

                      ],
                    ),
                    Column(
                      children: <Widget> [
                        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(user.email,
                            style: const TextStyle(fontSize: 20),),)
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    Column(
                      children: const <Widget>[
                        Icon(Icons.credit_card_outlined,size: 40.0,),

                      ],
                    ),
                    Column(
                      children: <Widget> [
                        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(user.nic,
                            style: const TextStyle(fontSize: 20),),)
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    Column(
                      children: const <Widget>[
                        Icon(Icons.phone,size: 40.0,),

                      ],
                    ),
                    Column(
                      children: <Widget> [
                        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(user.phoneNo,
                            style: const TextStyle(fontSize: 20),),)
                      ],
                    )
                  ],
                ),
      ],
    ),
    ),

    ),
        Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_){
              return UpdateProfile(user);
            }));
          },
              child: const Text('Update Profile')),),
        Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton(onPressed: (){

          },
              child: const Text('Update Password')),),
        Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: (){

              },
              child: const Text('Delete Account')),

        )
      ]
    );
  }


}



