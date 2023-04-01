import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class LoginController with ChangeNotifier{
    
    FirebaseAuth auth = FirebaseAuth.instance;
    
    bool _loading = false;
    bool get loading =>_loading;

    setLoading(bool value){
      _loading = value;
      notifyListeners();
    }
    void login(BuildContext context, String email, String password) async{
      
      setLoading(true);
      
      try {
          auth.signInWithEmailAndPassword(
          email: email, 
          password: password  
          ).then((value){
            SessionController().userId = value.user!.uid.toString();
              setLoading(false);
              Navigator.pushNamed(context, RouteName.dashboardScreen);
          }).onError((error, stackTrace){
            Utils.toastMessage(error.toString());
            setLoading(false);
          });     
      
      } catch (e) {
        setLoading(false);
        Utils.toastMessage(e.toString());
      }
    }

}