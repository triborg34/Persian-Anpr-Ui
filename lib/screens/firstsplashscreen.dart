import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:idb_shim/idb_browser.dart';
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
  static const String dbName = "AppDatabase";
  static const String storeName = "settings";

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp({String? customUrl}) async {
    setState(() {
      showUrlInput = false;
    });
    

    if(kIsWeb){
    try {
      String? savedUrl = await _getSavedUrl();
      if (savedUrl != null) {
        url = savedUrl;
      } else {
        var resultList = await pb.collection('ipconfig').getFullList();
        url = resultList.last.data['defip'];
        await _saveUrl(url);
      }
      
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
    
    }else{
      print(url);
      url='http://127.0.0.1:8090';
            updatePaths();
      await firstLogin();
      Get.to(() => ModernLoginPage());
    }
  }

  Future<void> _saveUrl(String url) async {
    var dbFactory = getIdbFactory();
    var db = await dbFactory!.open(dbName, version: 1, onUpgradeNeeded: (event) {
      var db = event.database;
      db.createObjectStore(storeName);
    });
    var txn = db.transaction(storeName, 'readwrite');
    var store = txn.objectStore(storeName);
    await store.put(url, 'server_url');
    await txn.completed;
  }

  Future<String?> _getSavedUrl() async {
    var dbFactory = getIdbFactory();
    var db = await dbFactory!.open(dbName, version: 1, onUpgradeNeeded: (event) {
      var db = event.database;
      db.createObjectStore(storeName);
    });
    var txn = db.transaction(storeName, 'readonly');
    var store = txn.objectStore(storeName);
    var savedUrl = await store.getObject('server_url');
    await txn.completed;
    return savedUrl as String?;
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
                    Text("آدرس سرور را وارد کنید", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextField(
                        controller: urlController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "127.0.0.1:8090",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (urlController.text.isNotEmpty) {
                            if(urlController.text.contains(":")){
                              url="http://${urlController.text}";
                            }else{
                            url = "http://${urlController.text}:8090";
                            }
                           
                            pb = PocketBase(url);
                            await pb.collection('ipconfig').create(body: {"defip": url});
                            if (kIsWeb){
                            await _saveUrl(url);
                            }
                            initializeApp();
                          }
                        },
                        child: Text("ثبت"),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("در حال بارگزاری", style: TextStyle(fontSize: 16))
                ],
              ),
      ),
    );
  }
}
