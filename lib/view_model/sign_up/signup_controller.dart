

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SignUpController with ChangeNotifier{
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
    bool _loading = false;
    bool get loading =>_loading;

    setLoading(bool value){
      _loading = value;
      notifyListeners();
    }
    void signup(BuildContext context, String username,String email, String password) async{
      setLoading(true);
      try {
        // final user = await auth.createUserWithEmailAndPassword(
          auth.createUserWithEmailAndPassword(
          email: email, 
          password: password  
          ).then((value){
            SessionController().userId = value.user!.uid.toString();
            ref.child(value.user!.uid.toString()).set({
              'uid' : value.user!.uid.toString(),
              'email': value.user!.email.toString(),
              'onlineStatus':'no One',
              'phone': '',
              'userName' : username,
              'profile':'',

            }).then((value) {
              setLoading(false);
              Navigator.pushNamed(context, RouteName.dashboardScreen);

            }).onError((error, stackTrace) {
              setLoading(false);
            });

            Utils.toastMessage('User created successfully');
          }).onError((error, stackTrace){
            Utils.toastMessage(error.toString());
            setLoading(false);
          });   /*if you donot use await then you will use then and it will also handle if there is a error  */  
      } catch (e) {
        setLoading(false);
        Utils.toastMessage(e.toString());
      }
    }
  }