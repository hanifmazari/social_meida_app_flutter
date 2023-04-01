import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/user/user_list_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 
 final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      SafeArea(child: Text('Home')),
      Text('Chat'),
      Text('Add'),
      UserListScreen(),
      ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return[
      PersistentBottomNavBarItem(icon: Icon(Icons.home), inactiveIcon:Icon(Icons.home, color: Colors.grey.shade100,), activeColorPrimary: AppColors.primaryIconColor),
      PersistentBottomNavBarItem(icon: Icon(Icons.message), inactiveIcon:Icon(Icons.chat_bubble, color: Colors.grey.shade100,),activeColorPrimary: AppColors.primaryIconColor ),
      PersistentBottomNavBarItem(icon: Icon(Icons.add) , inactiveIcon:Icon(Icons.add, color: Colors.grey.shade100,),activeColorPrimary: AppColors.primaryIconColor),
      PersistentBottomNavBarItem(icon: Icon(Icons.message ), inactiveIcon:Icon(Icons.add, color: Colors.grey.shade100,),activeColorPrimary: AppColors.primaryIconColor),
      PersistentBottomNavBarItem(icon: Icon(Icons.person_outline) , inactiveIcon:Icon(Icons.person_outline, color: Colors.grey.shade100,),activeColorPrimary: AppColors.primaryIconColor),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, 
      controller: controller,
      screens: _buildScreen(),
      items:_navBarItem(),
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1)
      ),
      navBarStyle: NavBarStyle.style15,
      );
  }
}
