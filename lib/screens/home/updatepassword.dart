import 'package:bus_ticketing_system/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../authenticate/email_sign_in.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;
  final updatePasswordFormKey = GlobalKey<FormState>();

  final TextEditingController pass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) => isLoading ?
      const LoadingPage()
      : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: const Text('Update Password'),
    ),
    body:  Form(
        key: updatePasswordFormKey,
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Wrap(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,30.0,0.0,10.0),
              child: Center(child: Text('Update Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.black54,
                ),
              ),
              ),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: pass,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Enter a Strong Password',
                      labelText: 'New Password *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: confirmPass,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Enter a Strong Password',
                      labelText: 'Confirm Password *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a password';
                      }
                      if(pass.text!=confirmPass.text){
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (updatePasswordFormKey.currentState!.validate()) {

                              try{
                                await auth.currentUser?.updatePassword(confirmPass.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Password Changed Successfully'),
                                    ));
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> const Home()));
                              }catch(e){
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString()),
                                    ));
                              }

                            }
                          },
                          child: const Text('Update Password',style: TextStyle(fontSize: 18),),
                        ),),
                    ],
                  )
                ],
              ),
            )
          ],

        )
    ),
    );

}
