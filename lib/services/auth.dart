import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  //Register with email and password
  Future register(_firstName,_lastName,_age,_email,_password) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'uid' : userCredential.user?.uid,
        'firstName' : _firstName,
        'lastName' : _lastName,
        'age' : _age,
        'email' : _email,
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