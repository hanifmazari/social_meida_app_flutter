import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier{

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

    bool _loading = false;
    bool get loading =>_loading;

    setLoading(bool value){
      _loading = value;
      notifyListeners();
    }

  Future pickGalleryImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }
  Future pickCameraImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }


  void pickImage(context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera, color: AppColors.primaryIconColor,),
                  title: Text('Camera'),

                ),
                ListTile(
                  onTap: (){
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image, color: AppColors.primaryIconColor,),
                  title: Text('Gallery'),

                )
              ],
            ),
          ),
        );
      });
  }

// This code is to upload the image in the firebase database

  void uploadImage(BuildContext context) async{

    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionController().userId.toString());

    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
     
      'profile': newUrl.toString()
    }).then((value) {
     
      Utils.toastMessage('Profile update');
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });

  }

  //code forchanging the username and phone number of the a User

  Future<void> showUserNameDialogAlert(BuildContext context, String name){
    nameController.text =name;
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Update User Name'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFeld(
                  myController: nameController, 
                  focusNode: nameFocusNode,
                  onFieldSubmittedValue: (value){

                  }, 
                  keyBoardType: TextInputType.text, 
                  obscureText: false, 
                  hint: 'Enter Name', 
                  onValidator: (value){

                  })
              ],
              )),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text('Cancel', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
                
                TextButton(onPressed: (){

                  ref.child(SessionController().userId.toString()).update({
                    'userName' : nameController.text.toString()
                  }).then((value) => nameController.clear());
                  Navigator.pop(context);
                }, 
                child: Text('OK', style: Theme.of(context).textTheme.subtitle2),)
              ],
        );
      });    
  }

 Future<void> showPhoneDialogAlert(BuildContext context, String phone){
    phoneController.text =phone;
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Update Phone Number'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFeld(
                  myController: phoneController, 
                  focusNode: phoneFocusNode,
                  onFieldSubmittedValue: (value){

                  }, 
                  keyBoardType: TextInputType.phone, 
                  obscureText: false, 
                  hint: 'Phone Number', 
                  onValidator: (value){

                  })
              ],
              )),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text('Cancel', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
                
                TextButton(onPressed: (){

                  ref.child(SessionController().userId.toString()).update({
                    'phone' : phoneController.text.toString()
                  }).then((value) => phoneController.clear());
                  Navigator.pop(context);
                }, 
                child: Text('OK', style: Theme.of(context).textTheme.subtitle2),)
              ],
        );
      });    
  }



}