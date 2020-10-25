import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vit_app1/models/user.dart';

import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user

  User _userFromFirebaseUSer(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;

  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUSer(user));
  }


  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result =await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }



  //register with email and password

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result =await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      print(result);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUSerData('HUMAN', 'no Name',);
      return _userFromFirebaseUSer(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

// sign out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;

    }
  }


}