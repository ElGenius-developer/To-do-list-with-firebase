import 'package:flutter/material.dart';
import 'package:notes_app/Screens/home_screen.dart';
import 'package:notes_app/Widgets/addOrEdit.dart';
import 'package:notes_app/firestore_service.dart';
class EditAndRemove extends StatelessWidget {
  final index;
  final BuildContext context;

  EditAndRemove({ this.index,  this.context});
  Widget buildIcon(bool isDelete){
   return IconButton(
      onPressed: () {
      if(isDelete)  FirestoreServices().deleteNote(index,ShowNotes. docsData);
      else     {
        titleController=TextEditingController(text:ShowNotes.docsData[index]['text']);
        descriptionController=TextEditingController(text:ShowNotes. docsData[index]['description']);
        addOrEdit(context: context,isEdit: true,index: index );
      }
      },
      icon: (isDelete)?  Icon(
         Icons.delete,color: Colors.red[900],
      ):Icon(Icons.edit,color: Colors.blue,)
    );
  }
  @override
  Widget build(BuildContext context) {
    bool delete=true;
    return Row(
      mainAxisSize: MainAxisSize.min,
     children: List.generate(2, (index){
       delete=!delete;
       return   buildIcon(delete);
     }),
    );
  }
}
