import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/mainPage.dart';
import 'package:unapwebv/screens/subscreens/splashScreen.dart';

class Licancecheker extends StatefulWidget {
  @override
  State<Licancecheker> createState() => _LicancechekerState();
}

class _LicancechekerState extends State<Licancecheker> {
  TextEditingController controller = TextEditingController();
  late int nol;
  bool isLicanced = false;
   String? id;

  @override
  void initState() {
    _loadSavedValues();
    super.initState();
  }

  // Load saved values
  _loadSavedValues() async {
    final resuilt=await pb.collection('sharedPerfence').getFullList();

    isLicanced=resuilt[0].data['licance'];
    Get.find<Boxes>().nol.value=resuilt[0].data['nol'];

    if (isLicanced) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SplashScreen()),
      );
    }
  }

  // Save values
  _saveValues(bool isLicanced, String id, int nol) async {
    await pb
        .collection('sharedPerfence')
        .update(id, body: {"nol": nol, "licance": isLicanced});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              RadialGradient(colors: [purpule, Colors.black], radius: 0.9),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('assets/images/logo.jpg'),
            SizedBox(
              height: 15,
            ),
            Text(
              "شناسه لایسنس خود را وارد کنید",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: TextField(
                style: TextStyle(fontFamily: 'arial', color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                    hintText: "coamnafarin-3546",
                    hintStyle: TextStyle(fontFamily: 'arial'),
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  Dio dio = Dio();
                  String url = 'https://sheetdb.io/api/v1/znsflyn60etgx';
                  final resultList =
                    await  pb.collection('sharedPerfence').getFullList();

                  var response = await dio.get(url,
                      options: Options(
                          headers: {"Authorization": "Bearer ${auth}"}));
                  if (response.statusCode == 200) {
                    for (var json in response.data) {
                      if (json['sn'] == controller.text) {
                        nol = int.parse(json['nol']);
                        isLicanced = true;
                        id=resultList[0].id;
            

                        await _saveValues(isLicanced, id!, nol);
                        Get.to(() => MainView());
                        break;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "شناسه سریال اشتباه است",
                          textDirection: TextDirection.rtl,
                        )));
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "خطا در برقراری ارتباط با سرور",
                      textDirection: TextDirection.rtl,
                    )));
                  }
                },
                child: Text("ارسال به سرور"))
          ],
        ),
      ),
    );
  }
}
