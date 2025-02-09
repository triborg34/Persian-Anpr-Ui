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
  TextEditingController urlController = TextEditingController();
  bool showUrlInput = false;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp({String? customUrl}) async {
    setState(() {
      showUrlInput = false;
    });

    try {
      var resultList = await pb.collection('ipconfig').getFullList();
      url = resultList.last.data['defip'];
      pb = PocketBase(url);
      print("Initialized with URL: $url");

      updatePaths();
      await firstLogin();
      Get.to(() => ModernLoginPage());
    } catch (e) {
      print("Error initializing app: $e");
      setState(() {
        showUrlInput = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: showUrlInput
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter Server URL:", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    TextField(
                      controller: urlController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "http://127.0.0.1:8090",
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async{
                        if (urlController.text.isNotEmpty) {
                          url = urlController.text;
                          pb = PocketBase(url);
                          await pb.collection('ipconfig').create(body: {
                            "defip":url
                          });
                          initializeApp();
                        }
                      },
                      child: Text("Retry Initialization"),
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Initializing...", style: TextStyle(fontSize: 16))
                ],
              ),
      ),
    );
  }
}
