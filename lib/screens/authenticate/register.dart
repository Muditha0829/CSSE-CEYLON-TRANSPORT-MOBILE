import 'package:flutter/material.dart';
import '../../services/auth.dart';

void main() {
  runApp(const Register());
}
//Validators
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension NumberValidator on String {
  bool isValidNumber(){
    return RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(this);
  }
}

extension NameValidator on String {
  bool isValidName(){
    return RegExp(r'^[A-Za-z]').hasMatch(this);
  }
}


class Register extends StatelessWidget {
  const Register({super.key});




  @override
  Widget build(BuildContext context) {

    final AuthService auth = AuthService();

    final registrationFormKeyLocal = GlobalKey<FormState>();
    final registrationFormKeyForeign = GlobalKey<FormState>();

    final TextEditingController fullName = TextEditingController();
    final TextEditingController nic = TextEditingController();
    final TextEditingController passportNo = TextEditingController();
    final TextEditingController contactNo = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController pass = TextEditingController();
    final TextEditingController confirmPass = TextEditingController();

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Text('Local')),
                Tab(icon: Text('Foreign')),
              ],
            ),
            title: const Text('Register'),
          ),
          body:  TabBarView(
            children: <Widget>[
              Form(
                  key: registrationFormKeyLocal,
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                  Form.of(primaryFocus!.context!)!.save();
                },
                  child: Wrap(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0,30.0,0.0,10.0),
                        child: Center(child: Text('Local',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.black54,
                          ),
                        ),
                        ),),
                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,30.0),
                      //   child: Center(child: Text('Fill the following fields to sign up',
                      //     style: TextStyle(
                      //       fontSize: 20.0,
                      //       color: Colors.black54,
                      //     ),
                      //   ),
                      //   ),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                hintText: 'What is your full name?',
                                labelText: 'Full Name *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter Your Full Name';
                                }
                                if(!value.isValidName()){
                                  return 'Name should not contain any numbers';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: nic,
                              decoration: const InputDecoration(
                                hintText: 'What is your NIC Number?',
                                labelText: 'NIC *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter Your NIC';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: contactNo,
                              decoration: const InputDecoration(
                                hintText: 'What is your mobile number?',
                                labelText: 'Contact No *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter a number';
                                }
                                if(!value.isValidNumber()){
                                  return 'Phone Number should be a number';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: email,
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
                              controller: pass,
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
                                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (registrationFormKeyLocal.currentState!.validate()) {
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(content: Text('Processing Data')),
                                        //
                                        // );
                                        dynamic result = await auth.registerLocal(fullName.text,nic.text,contactNo.text,email.text, pass.text);
                                        print(result);
                                        if(result=='Success'){
                                          print('Successfully Created Account');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Successfully Created Account'),
                                              ));
                                          // Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: new Text(result),
                                              ));
                                        }
                                      }
                                    },
                                    child: const Text('Register as a Local User',
                                      style: TextStyle(fontSize: 22),),
                                  ),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],

                  )
              ),

              //Foreign
              Form(
                key: registrationFormKeyForeign,
                  child: Wrap(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0,30.0,0.0,10.0),
                        child: Center(child: Text('Foreign',
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
                              controller: fullName,
                              decoration: const InputDecoration(
                                hintText: 'What is your full name?',
                                labelText: 'Full Name *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter Your Full Name';
                                }
                                if(!value.isValidName()){
                                  return 'Name should not contain any numbers';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: passportNo,
                              decoration: const InputDecoration(
                                hintText: 'What is your Passport Number?',
                                labelText: 'Passport Number *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter Your Passport Number';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: contactNo,
                              decoration: const InputDecoration(
                                hintText: 'What is your mobile number?',
                                labelText: 'Contact No *',

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Enter a number';
                                }
                                if(!value.isValidNumber()){
                                  return 'Phone Number should be a number';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: email,
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
                              controller: pass,
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
                                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (registrationFormKeyForeign.currentState!.validate()) {
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(content: Text('Processing Data')),
                                        //
                                        // );
                                        dynamic result = await auth.registerForeign(fullName.text,passportNo.text,contactNo.text,email.text, pass.text);
                                        print(result);
                                        if(result=='Success'){
                                          print('Successfully Created Account');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Successfully Created Account'),
                                              ));
                                          // Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: new Text(result),
                                              ));
                                        }
                                      }
                                    },
                                    child: const Text('Register as a Foreign User',
                                      style: TextStyle(fontSize: 22),),
                                  ),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],

                  ))
            ],
          ),
        ),
      ),
    );
  }
}