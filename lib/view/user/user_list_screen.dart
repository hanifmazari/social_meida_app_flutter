import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Here we use firebase animated list instead of stream builder both are same almost
        appBar: AppBar(
          title: Text('User list'),
        ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {

            if (SessionController().userId.toString() == snapshot.child('uid').toString()) {
              return Container();
            }else{
              return Card(
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryButtonColor
                    )
                  ),
                  child: snapshot.child('profile').value.toString()==''? Icon(Icons.person_outline) : 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.child('profile').value.toString())),
                  )
                ),
                title:Text(snapshot.child('userName').value.toString()),
                subtitle: Text(snapshot.child('email').value.toString()),
                 ),
            );
          
            }
            
          }),
      ) ,
    );
  }
}