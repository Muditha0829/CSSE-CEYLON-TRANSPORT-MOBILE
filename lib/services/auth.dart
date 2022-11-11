import 'dart:math';

import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final SingleUser singleUser;



  // Create user object from firebaseUser
  modelUser? _userFromFirebaseUser(UserCredential result) {
    if (result.user != null) {
      var userId = result.user?.uid;
      return modelUser(uid: userId.toString());
    }
    else {
      return null;
    }
  }

  //Sign in with anonymous
  Future signInAnon() async {
    if (signIncheck() == true) {
      print('User already Signed In in to the System');
    } else {
      try {
        UserCredential result = await _auth.signInAnonymously();
        // User user = result;
        return _userFromFirebaseUser(result);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  //Sign in with email and password
  Future signInEmail(formEmail,formPassword) async {

    if(await _auth.currentUser != null){
      return 'User already Signed In in to the System';
    }else{
      try {
        UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: formEmail,
            password: formPassword
        );
        return 'Success';

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          return 'Wrong password provided for that user.';
        }
      }catch (e) {
        return e.toString();
      }
    }

  }

  //Register with email and password - Local
  Future registerLocal(fullName,nic,phoneNo,email,password) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseFirestore.instance.collection('userData').doc(userCredential.user?.uid).set({
        'uid' : userCredential.user?.uid,
        'fullName' : fullName,
        'nic' : nic,
        'phoneNo': phoneNo,
        'userType' : 'local',
        'email' : email,
        'passportNo' : ''
      });
      return 'Success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }


  //Register with email and password - Local
  Future registerForeign(fullName,passportNo,phoneNo,email,password) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseFirestore.instance.collection('userData').doc(userCredential.user?.uid).set({
        'uid' : userCredential.user?.uid,
        'fullName' : fullName,
        'passportNo' : passportNo,
        'phoneNo': phoneNo,
        'userType' : 'foreign',
        'email' : email,
        'nic' : ''
      });
      return 'Success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  //Update User
  Future updateUser(fullNameUpdated,nicUpdated,passportNoUpdated,phoneNoUpdated) async {
    try{
      FirebaseFirestore.instance.collection('userData').doc(_auth.currentUser?.uid).update(
          {'fullName':fullNameUpdated,
            'nic': nicUpdated,
            'phoneNo': phoneNoUpdated,
            'passportNo': passportNoUpdated
          });
      return 'Success';
    }catch (e){
      return e.toString();
    }
  }

  Future resetPassword(newPassword) async{
    try{
      await _auth.currentUser?.updatePassword(newPassword);
      return 'Success';
    }catch(e){
      return e.toString();
    }
  }

  //Delete user from the firebase and data from the firestore
  Future deleteUserData() async {
    try{
      FirebaseFirestore.instance.collection('userData').doc(_auth.currentUser?.uid).delete();
      _auth.currentUser?.delete();

      return 'Success';
    }catch(e){
      return e.toString();
    }

  }

  //Delete user from the firebase
  Future deleteUser(userId) async {
    try{
      _auth.currentUser?.delete();
      try{
        FirebaseFirestore.instance.collection('userData').doc(userId).delete();

        return 'Success';
      }catch(e){
        return e.toString();
      }
      return 'Success';
    }catch(e){
      return e.toString();
    }

  }

  getUserById(userId)async{

    late DocumentReference<Map<String, dynamic>> oneUser;
    late SingleUser singleUser;

    oneUser = FirebaseFirestore.instance.collection('userData').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;
    snapshot = await oneUser.get();
    singleUser = SingleUser.fromJson(snapshot.data()!);
    // print(singleUser.uid);
    return singleUser;
  }




  //Sign out
  Future signOut() async {
    try{
      await _auth.signOut();
      return 'Success';
    }
    catch(e){
      return e.toString();
    }


  }

  //Check user changes
  Future AuthStateCheck() async {
    await _auth.userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<String?> getCurrentUserId() async {
    final user = await _auth.currentUser;
    if(user != null){
      return user?.uid;
    }else{
      return 'No User';
    }
  }

  Future<bool> signIncheck() async {
    final user = await _auth.currentUser;
    if(user != null){
      return true;
    }else{
      print('No User');
      return false;
    }
  }

}