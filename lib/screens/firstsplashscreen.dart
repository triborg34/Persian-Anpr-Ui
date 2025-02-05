import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/loginScreen.dart';

class FirstLoginScreen extends StatefulWidget {
  const FirstLoginScreen({super.key});

  @override
  State<FirstLoginScreen> createState() => _FirstLoginScreenState();
}

class _FirstLoginScreenState extends State<FirstLoginScreen> {
 @override
  void initState() {

    super.initState();

    initializeApp();
  }

  Future<void> initializeApp() async {
    var resultList = await pb.collection('ipconfig').getFullList();

    try {
      url = resultList.last.data['defip'];
      pb = PocketBase(url); 
      print(url);

      // Update dependent variables
      updatePaths();
      await firstLogin();
      // Navigate to login screen after initialization
      Get.to(() => ModernLoginPage());
    } catch (e) {
      print("Error initializing app: $e");
      // Show an error message if something goes wrong
      showErrorMessage();
    }
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to load app configuration!")),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Loading indicator
            SizedBox(height: 20),
            Text("Initializing...", style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}