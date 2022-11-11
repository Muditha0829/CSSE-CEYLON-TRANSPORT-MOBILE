import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/screens/home/home.dart';
import 'package:bus_ticketing_system/services/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class UpdateProfile extends StatefulWidget {

  SingleUser user;
  UpdateProfile(this.user, {Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {


  final AuthService _auth = AuthService();

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
        title:  const Text('Update Profile'),
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
                  buildNicPassportUpdate(widget.user),
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
                            dynamic result = await _auth.updateUser(fullName.text, nic.text,passportNo.text, contactNo.text);
                            if(result=='Success'){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Successfully Updated Data'),
                                  ));
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> const Home()));
                            }else{
                              if (kDebugMode) {
                                print(result);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: new Text(result),
                                  ));
                            }
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

  Widget buildNicPassportUpdate(SingleUser user) {
    if(user.userType=='local'){
      return TextFormField(
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
          },);
    }else{
      return TextFormField(
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
      );
    }
  }
}


