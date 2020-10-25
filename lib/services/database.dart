import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vit_app1/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});




  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection("USER");



  Future updateUSerData(String profile,String name)async {
    return await userCollection.document(uid).setData({
      'profile': profile,
      'name': name,

    });
  }
  //brew list from snapshot


  //get brew collections

  //user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      profile: snapshot.data['profile'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(
        _userDataFromSnapshot);
  }




}