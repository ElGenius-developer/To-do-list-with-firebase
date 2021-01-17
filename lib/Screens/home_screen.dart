import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Widgets/addOrEdit.dart';
import 'package:notes_app/Widgets/edit_and_remove.dart';
import 'package:notes_app/firestore_service.dart';
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
TextEditingController titleController =TextEditingController();
TextEditingController descriptionController=TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class ShowNotes extends StatefulWidget{
  static var docsData;
  @override
  _ShowNotesState createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {

@override
  void initState() {

    super.initState();
    titleController=TextEditingController(text: '');
    descriptionController=TextEditingController(text: '');
  }
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    formKey.currentState.dispose();
    scaffoldKey.currentState.dispose();
  }
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar:AppBar(
        title: Text("To Do List"),
            backgroundColor: Colors.cyan[800],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirestoreServices().fireService.snapshots(),
          builder: (ctx, snapShot){

            if(snapShot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);

            }else
            {
              ShowNotes.docsData = snapShot.data.docs;

             if(ShowNotes.docsData.isNotEmpty)
              return ListView.builder(
                itemCount:(ShowNotes.docsData.isNotEmpty)? ShowNotes.docsData.length:0,
                itemBuilder: (ctx, index) =>Card(
                  child: ListTile(
                    title:
                    Text(ShowNotes.docsData[index]['text']),
                   subtitle: Text(ShowNotes.docsData[index]['description']),
                    trailing: EditAndRemove(index: index,
                      context: context,)
                  ),
                ),

              );
             else
               return Center(child: Text(
                 "No notes try add a new one.",textScaleFactor: 1.2,
               ),);
            }
          },


        ),


      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan[800],
        onPressed: (){
          addOrEdit(context: context);

        },
      ),

    );
  }
}