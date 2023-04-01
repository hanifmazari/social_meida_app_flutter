import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(builder: (context, provider, child) {
          return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            stream: ref.child(SessionController().userId.toString()).onValue,
            builder: ((context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasData){
              Map<dynamic, dynamic> map =snapshot.data.snapshot.value;
            return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.02,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryTextTextColor,
                        
                      )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: provider.image== null? map['profile'].toString() ==  ""? 
                      const Icon(Icons.person, size: 35,): 
                      Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          map['profile'].toString()
                        ),

                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator();
                      },
                      errorBuilder: ((context, error, stackTrace) {
                        return Container(
                          child: Icon(Icons.error_outline, color: AppColors.alertColor,),
                        );
                      })
                      ) : 
                      Stack(
                        children: [
                          Image.file(
                            File(provider.image!.path).absolute
                          ),
                          Center(child: CircularProgressIndicator())
                        ],
                      )
                                      
                      ),
                      
                ),
              ),
                  ),
              InkWell(
                onTap: () {
                  provider.pickImage(context);
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primaryIconColor,
                  child: Icon(Icons.add,size: 15, color: Colors.white,),
                ),
              )
              ],
            ),
              SizedBox(height: height*.04,),
              GestureDetector(
                onTap: () {
                  provider.showUserNameDialogAlert(context, map['userName']);
                },
                child: ReuseableRow(title: 'User Name',value: map['userName'], iconData: Icons.person_outline, )),
              GestureDetector(
                onTap: (){
                  provider.showPhoneDialogAlert(context, map['phone']);
                },
                child: ReuseableRow(title: 'Phone',value: map['phone'] == ''? 'xxx-xxxxxx' : map['phone'], iconData: Icons.phone_outlined, )),
              ReuseableRow(title: 'Email',value: map['email'], iconData: Icons.email_outlined, ),
             
            ],
          );
           
            }else{
              return Center(child: Text('Something went wrong', style: Theme.of(context).textTheme.subtitle1,),);
            }
           
          }))
          ),
      );
        },),
        )
    
      
    
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReuseableRow({super.key, required this.title, required this.iconData, required this.value, });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: Theme.of(context).textTheme.subtitle2,),
          leading: Icon(iconData, color: AppColors.primaryIconColor,),
          trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
        ),
        Divider(color: AppColors.dividedColor.withOpacity(0.5),)
      ],
    );
  }
}