import 'package:bus_ticketing_system/screens/authenticate/register.dart';
import 'package:bus_ticketing_system/screens/authenticate/sign_in.dart';
import 'package:bus_ticketing_system/services/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../home/home.dart';

class EmailSignin extends StatefulWidget {
   EmailSignin({Key? key}) : super(key: key);

  @override
  State<EmailSignin> createState() => _EmailSigninState();

}

class _EmailSigninState extends State<EmailSignin> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : const Scaffold(
        backgroundColor: Colors.white,
        body: UserSignInWidget()
    );
  }


class UserSignInWidget extends StatefulWidget {
  const UserSignInWidget({Key? key}) : super(key: key);

  @override
  State<UserSignInWidget> createState() {
    return UserSignInFromState();
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

class _UserSignInWidgetState extends State<UserSignInWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserSignInFromState extends State<UserSignInWidget>{


  final AuthService _auth = AuthService();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signInFormKey,

        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(0.0,50.0,0.0,30.0),
                    child: Center(child: Text('Bus Ticketing System',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black54,
                      ),
                    ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0.0,0.0,0.0,30.0),
                    child: Center(child: Text('Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        color: Colors.black54,
                      ),
                    ),
                    ),
                  ),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/bus.webp'),
                    ),
                  ),

                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: 'What is your email',
                      labelText: 'Email *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter an email';
                      }
                      if(!value.isValidEmail()){
                        return 'Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _pass,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Enter a Strong Password',
                      labelText: 'Password *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a password';
                      }
                      return null;
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                             _EmailSigninState().isLoading = true;
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_signInFormKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing Data')),
                              // );
                              dynamic result = await _auth.signInEmail(_email.text, _pass.text);
                              if (kDebugMode) {
                                print(result);
                              }
                              if(result=='Success'){
                                _EmailSigninState().isLoading = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Successfully Signed In'),
                                    ));
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> const Home()));
                              }else{
                                 _EmailSigninState().isLoading = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(content: new Text(result),
                                    ));
                              }
                            }
                          },
                          child: const Text('Sign In',
                            style: TextStyle(fontSize: 25,wordSpacing: 2,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> const SignIn()));
                          },
                          child: const Text('Forgot Password',
                            style: TextStyle(fontSize: 18),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> const Register()));
                          },
                          child: const Text('Register',
                            style: TextStyle(fontSize: 18),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],

        )
    );
    throw UnimplementedError();
  }

}



