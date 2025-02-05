import 'dart:async';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/storagedb/db.dart';
import 'package:unapwebv/screens/homeScreen.dart';
import 'package:unapwebv/screens/infoScreen.dart';
import 'package:unapwebv/screens/reportScreen.dart';
import 'package:unapwebv/screens/settingScreen.dart';
import 'package:unapwebv/widgets/appbar.dart';

class MainView extends StatefulWidget {
  
  MainView();
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late DatabaseHelper _databaseHelper;
  Timer? _pollingTimer;
  int navIndex = Get.find<navController>().navIndex;
  
  
  @override
  void initState() {

    // _databaseHelper = DatabaseHelper.withPath(widget.dbPath);

    // _databaseHelper.queryAndEmitEntries();
    // _pollingTimer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   _databaseHelper.queryAndEmitEntries();
 
    // });
    // Get.find<videoController>()
    //     .player
    //     .open(Media("rtsp://admin:admin@192.168.1.89:554/stream"));
    //rtsp://admin:admin@192.168.1.88:554/stream
    Get.find<navController>().body=HomeScreen();

    super.initState();
  }




  @override
  void dispose() {
    _pollingTimer?.cancel();
    _databaseHelper.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Dio dio=Dio();
        var res=dio.get('assets/config.json');
        res.then((value) => print(value.data['defip']),);
      }),
      bottomNavigationBar: ResponsiveNavigationBar(

        inactiveIconColor: Colors.white38,
        backgroundColor: Colors.transparent,
        selectedIndex: navIndex,
        textStyle: TextStyle(color: Colors.white38),
        
fontSize: 22,
        showActiveButtonText: true,
        navigationBarButtons: [

          NavigationBarButton(

            text: 'اطلاعات',

              backgroundColor: const Color.fromARGB(255, 21, 19, 24), icon: Icons.info,),
          NavigationBarButton(
            text: "تنظیمات",
              backgroundColor: const Color.fromARGB(255, 21, 19, 24), icon: Icons.settings),
          NavigationBarButton(
            text: "گزارش گیری",
              backgroundColor: const Color.fromARGB(255, 21, 19, 24), icon: Icons.car_repair_outlined),
          NavigationBarButton(text: "خانه",backgroundColor: const Color.fromARGB(255, 21, 19, 24), icon: Icons.home),
        ],
        onTabChange: (index) {
          switch (index) {
            case 0:
              navIndex = index;
               Get.find<navController>().body=Infoscreen();
              setState(() {});

              break;
              case 1:
                 navIndex = index;
                  Get.find<navController>().body=Settingscreen();
              setState(() {});
              break;
              case 2:
                 navIndex = index;
                  Get.find<navController>().body=ReportScreen();
              setState(() {});
              break;
               case 3:
               
                 navIndex = index;
                  Get.find<navController>().body=HomeScreen();
              setState(() {});
              break;

            default:
                   navIndex = 3;
                      Get.find<navController>().body=HomeScreen();
              setState(() {});
          }
        },
      ),
      appBar: MyAppBar(),
      backgroundColor: Colors.black,
      body: Get.find<navController>().body
    );
  }
}
