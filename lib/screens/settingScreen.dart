import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:side_bar_custom/side_bar_custom.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/subscreens/cameraSetting.dart';
import 'package:unapwebv/screens/subscreens/generalSetting.dart';
import 'package:unapwebv/screens/subscreens/portSetting.dart';
import 'package:unapwebv/screens/subscreens/userSetting.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SideBar( items: [
           SideBarItem(
             text: "عمومی",
             icon: FontAwesomeIcons.gears,
    
           ),
           SideBarItem(
             text: "دوربین",
             icon: Icons.camera_indoor,
           ),
             SideBarItem(
             text: "کاربران",
             icon: FontAwesomeIcons.usersGear,)
         ,  SideBarItem(
             text: "شبکه",
             icon: FontAwesomeIcons.networkWired,
           ),
         ], children:  [
            Generalsetting(),
            CameraSetting(),
            UserSetting(),
            PortSettings(),
            //      Center(
            //   child: Text("Add User",style: TextStyle(color: Colors.white),),
            // ),
          ],config: SideBarConfig(
            backgroundColor: purpule,
            enableFloating: false,
            iconSize: 28,
            fontSize: 16,
            dividerColor: Colors.deepPurpleAccent,
            bottomIconColor: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(35)),
            selectedBoxColor:Colors.deepPurple,
            unselectedBoxColor: purpule,
            selectedIconColor: Colors.white,
            unselectedIconColor: Colors.white54,
            selectedTextStyle: TextStyle(color: Colors.white),
            unselectedTextStyle: TextStyle(color: Colors.white54),



        
        
           enablePageView: true,
         ),),
      ),
    );
  }
}



