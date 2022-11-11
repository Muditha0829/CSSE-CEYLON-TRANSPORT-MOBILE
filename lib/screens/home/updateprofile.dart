import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/services/validators.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class UpdateProfile extends StatefulWidget {
  SingleUser user;
  UpdateProfile(SingleUser this.user, {Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {


  final AuthService auth = AuthService();

  final updateUserForm = GlobalKey<FormState>();

  final TextEditingController fullName = TextEditingController();
  final TextEditingController nic = TextEditingController();
  final TextEditingController passportNo = TextEditingController();
  final TextEditingController contactNo = TextEditingController();



  @override
  Widget build(BuildContext context) {

    fullName.text = widget.user.fullName;
    nic.text = widget.user.nic;
    passportNo.text = widget.user.passportNo;
    contactNo.text = widget.user.phoneNo;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title:  Text('Update Profile'),
    ),
    body:  Form(
        key: updateUserForm,
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Wrap(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,30.0,0.0,10.0),
              child: Center(child: Text('Update Profile',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            // if (registrationFormKeyLocal.currentState!.validate()) {
                            //   dynamic result = await auth.registerLocal(fullName.text,nic.text,contactNo.text,email.text, pass.text);
                            //   print(result);
                            //   if(result=='Success'){
                            //     print('Successfully Created Account');
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(content: Text('Successfully Created Account'),
                            //         ));
                            //   }else{
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(content: new Text(result),
                            //         ));
                            //   }
                            // }
                          },
                          child: const Text('Update User Profile',
                            style: TextStyle(fontSize: 18),),
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
}
