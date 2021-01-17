import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screens/home_screen.dart';
import 'package:notes_app/firestore_service.dart';

Future addOrEdit(

    {BuildContext context, bool isEdit, int index}) {
  if(isEdit==null)isEdit=false;
   return showDialog(
     context: context,
     builder: (context) => Container(
       height: MediaQuery.of(context).size.height / 2,
       child: AlertDialog(
         scrollable: true,
         title: Text("Please fill up fields"),
         actions: [
           FlatButton(
             child: Text(
               "cancel",
               style: TextStyle(color: Colors.green),
             ),
             onPressed: () {

               Navigator.pop(context);
               titleController.clear();
               descriptionController.clear();
             },
           ),
           FlatButton(
               onPressed: () {
                 if (formKey.currentState.validate()) {
                   final json = {
                     'text': titleController.text,
                     'description': descriptionController.text,
                   };

                   if(isEdit) FirestoreServices().updateNote(index, ShowNotes.docsData, json);
                   else FirestoreServices().addNote(json);
                   Navigator.pop(context);
                   titleController.clear();
                   descriptionController.clear();
                 }
               },
               child: Text(
                 (!isEdit)? "Add":"Edit",
                 style: TextStyle(color: Colors.green),
               ))
         ],
         content: Form(
           key: formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               //title field
               TextFormField(
                 validator: (value) {
                   if (value.isEmpty) return "Note title cannot be empty";
                   return null;
                 },
                 key: ValueKey('*Task title*'),
                 controller: titleController,
                 decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(10),
                     hintText: "task title",
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10)),
                     fillColor: Colors.cyan[900]),
               ),
               //description field
               TextField(
                 key: ValueKey('*Task description*'),
                 controller: descriptionController,
                 autocorrect: true,
                 minLines: 1,
                 maxLines: 100,
                 enableInteractiveSelection: true,
                 decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(10),
                     hintText: "task description",
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10)),
                     fillColor: Colors.cyan[900]),
               ),
             ],
           ),
         ),
       ),
     ),
  );
}
