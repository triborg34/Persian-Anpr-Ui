
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:unapwebv/controller/bindings.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/firstsplashscreen.dart';



void main() async {
  //TODO:Add Pdf
  //TODO:Fix Setting🤓
  //TODO:Fix try and expects🤓
  //TODO:Licance Demo🤓

  WidgetsFlutterBinding.ensureInitialized();

// try{
//   tz.initializeTimeZones();
// }catch(e){
//   print(e);
// }


  //Clean Up Code Refactor all codes and remove duplicate code

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) {

          return ResponsiveBreakpoints.builder(child: child!, breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ]);

        },
        initialBinding: MyBinding(),
        theme: ThemeData(fontFamily: 'byekan', useMaterial3: true),
        debugShowCheckedModeBanner: false,
        title: 'AmnAfarin',
        onInit: () async {

        },
        onReady: () async {
          printIps();
          try{
          tz.initializeTimeZones();
          }catch(e){
          
          }
        },
        home: FirstLoginScreen());
  }
}
