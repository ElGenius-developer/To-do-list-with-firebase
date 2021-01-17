
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screens/home_screen.dart';
 class FirestoreServices{
  final fireService= FirebaseFirestore.instance.collection('notes');


  //Create New Note
 void addNote(Map<String,dynamic> json){
try{

  fireService.add(json);

}catch(e){
  showError(e);
 }
  }

  // update function
 void  updateNote(int index, List snapShotDocs,json){
  try{
    fireService.doc('${snapShotDocs[index].id}').update(
        json
    );
  }catch(e){
    showError(e);
  }

  }
  //delete a Note
  Future deleteNote(int index, List snapShotDocs,) async{
   try{
     await fireService.doc('${snapShotDocs[index].id}').delete();

   }catch(e){
     showError(e);
   }
  }



void showError(e){
  scaffoldKey.currentState..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("${e.message}",
    ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      backgroundColor: Colors.cyan[800],
      duration: Duration(seconds: 2),),);


}

}