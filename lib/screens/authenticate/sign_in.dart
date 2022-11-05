import 'package:bus_ticketing_system/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import 'email_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent[050],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: const Text('Sign In To Brew Crew'),
        ),
        body:Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    var rs = _auth.AuthStateCheck();
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('error in sign in' );
                    } else {
                      print(result.uid + ' ' + 'signed in');
                    }

                  },
                  child: const Text('Sign In Anon'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    dynamic result = await _auth.signOut();
                    print(result);

                  },
                  child: const Text('Sign Out'),
                ),
                ElevatedButton(
                  onPressed: ()  async {
                    dynamic result = await _auth.signIncheck();
                    print(result);
                    if(result!=true){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Sign In Alert'),
                          content: const Text('No User'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Check'),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                  },
                  child: const Text('Sign In with email and password'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const Register()));
                  },
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        )




    );
  }
}
