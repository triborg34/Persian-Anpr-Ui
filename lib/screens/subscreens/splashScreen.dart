import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';
import 'package:unapwebv/screens/mainPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return SplashView(
        backgroundColor: Colors.black,
        logo: kIsWeb ?  Image.network('assets/images/logo.jpg') :Image.asset('assets/images/logo.jpg'),
        subtitle: Text(
          "Automatic Licence Plate Recognition",
          style: TextStyle(color: Colors.white60),
        ),
        bottomLoading: true,
        showStatusBar: true,
        loadingIndicator: LinearProgressIndicator(),
        title: Text(
          'AmnAfarin',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        duration: Duration(seconds: 2),
        done: Done(MainView(),
            animationDuration: Duration(seconds: 0), curve: Curves.easeIn),
      );
  }
}
