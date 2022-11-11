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

  //Get collection data from the firebase
  // Future getUserData() async {
  //   final user = _auth.currentUser;
  //   _fireStore.collection('userData').doc(user?.uid) .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //       // print('Document data: ${documentSnapshot.data()}');
  //       // print('Full Name: ${data['fullName']}');
  //       // print(data['fullName']);
  //       return data;
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  // }



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