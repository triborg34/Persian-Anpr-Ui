import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/storagedb/setting.dart';

class PortSettings extends StatelessWidget {
  PortSettings({super.key});
  TextEditingController portController =
      TextEditingController(text: Get.find<settingController>().port);
  TextEditingController connectConttroler =
      TextEditingController(text: Get.find<settingController>().connect);

  TextEditingController rfidip =
      TextEditingController(text: Get.find<settingController>().rfidip);
  TextEditingController rfidport = TextEditingController(
      text: Get.find<settingController>().rfidport.toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: purpule, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "سیستم",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ))),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 65,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'پورت سوکت:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: TextFormField(
                            controller: portController,
                            readOnly: false,
                            textDirection: TextDirection.ltr,
                            onEditingComplete: () {
                              Get.find<settingController>().port =
                                  portController.text;
                            },
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'arial'),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'eg:8080',
                                hintTextDirection: TextDirection.ltr),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 65,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'پورت اتصال:',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextFormField(
                          controller: connectConttroler,
                          readOnly: false,
                          onEditingComplete: () {
                            Get.find<settingController>().connect =
                                connectConttroler.text;
                          },
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'arial'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'eg:9090',
                              hintTextDirection: TextDirection.ltr),
                        ),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  height: 65,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'آدرس داخلی',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextFormField(
                          controller: TextEditingController(text: '127.0.0.1'),
                          readOnly: true,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.white70, fontFamily: 'arial'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'eg:8080',
                              hintTextDirection: TextDirection.ltr),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: purpule, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "اطلاعات سیستم",
                style: TextStyle(color: Colors.white),
              ))),
          SizedBox(
            height: 15,
          ),
          ipFunction("نام شبکه", ethname),
          SizedBox(
            height: 10,
          ),
          ipFunction("آدرس شبکه", ipadress),
          SizedBox(
            height: 10,
          ),
          ipFunction("نوع آدرس", ipname),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: purpule, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "رله و آلارم",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ))),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "اتصال به رله",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Obx(() => Switch(
                      value: Get.find<settingController>().isRfid.value,
                      onChanged: (value) async {
                        Get.find<settingController>().isRfid.value = value;
                        if (value == false) {
                          String url =
                              'http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/iprelay?ip=${rfidip.text}&port=${rfidport.text}';
                          Dio dio = Dio();
                          await dio.get(
                              'http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/iprelay?onOff=false&relay=1');
                          await dio.get(
                              'http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/iprelay?onOff=false&relay=2');
                          dio.post(url, data: {"isconnect": false}).then(
                            (value) {
                              if (value.statusCode == 200) {
                                Get.snackbar("", "اتصال قطع شد");
                              }
                            },
                          );
                        }
                      },
                    )),
                Obx(() => Visibility(
                      visible: Get.find<settingController>().isRfid.value,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 100,
                              child: TextFormField(
                                  controller: rfidip,
                                  readOnly: false,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'arial'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'eg:192.168.1.91',
                                      hintTextDirection: TextDirection.ltr))),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 100,
                              child: TextFormField(
                                  controller: rfidport,
                                  readOnly: false,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'arial'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'eg:2000',
                                      hintTextDirection: TextDirection.ltr))),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "رله یک",
                            style: TextStyle(color: Colors.white),
                          ),
                          Obx(() => Checkbox(
                                value: Get.find<settingController>().rl1.value,
                                onChanged: (value) {
                                  Get.find<settingController>().rl1.value =
                                      value!;
                                },
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "رله دو",
                            style: TextStyle(color: Colors.white),
                          ),
                          Obx(() => Checkbox(
                                value: Get.find<settingController>().rl2.value,
                                onChanged: (value) {
                                  Get.find<settingController>().rl2.value =
                                      value!;
                                },
                              )),
                          TextButton(
                              onPressed: () async {
                                String url =
                                    'http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/iprelay?ip=${rfidip.text}&port=${rfidport.text}';
                                Dio dio = Dio();
                                await dio
                                    .post(url, data: {"isconnect": true}).then(
                                  (value) {
                                    if (value.statusCode == 200) {
                                      Get.snackbar(
                                          "", "اتصال با موفقیت برقرار شد");
                                    }
                                  },
                                );
                              },
                              child: Text(
                                "اتصال",
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "فعال سازی آلارم",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Obx(() => Switch(
                      value: Get.find<settingController>().alarm.value,
                      onChanged: (value) {
                        Get.find<settingController>().alarm.value = value;
                        Get.snackbar("", "فعال شد",colorText: Colors.white);
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                         Get.find<Boxes>()
                            .settingbox[ Get.find<Boxes>().settingbox.length - 1]=
                           
                                Setting(
                                    alarm: Get.find<settingController>()
                                        .alarm
                                        .value,
                                    port: portController.text,
                                    connect: connectConttroler.text,
                                    isRfid: Get.find<settingController>()
                                        .isRfid
                                        .value,
                                    rl1:
                                        Get.find<settingController>().rl1.value,
                                    rl2:
                                        Get.find<settingController>().rl2.value,
                                    rfidip: rfidip.text,
                                    rfidport: int.parse(rfidport.text));
                                    final resultList = await pb.collection('setting').getList();
                                    var body={
                                           "alarm": Get.find<settingController>()
                                        .alarm
                                        .value,
                                    "port": portController.text,
                                    "connect": connectConttroler.text,
                                    "isRfid": Get.find<settingController>()
                                        .isRfid
                                        .value,
                                    "rl1":
                                        Get.find<settingController>().rl1.value,
                                    "rl2":
                                        Get.find<settingController>().rl2.value,
                                    "rfidip": rfidip.text,
                                    "rfidport": int.parse(rfidport.text)
                                    };
                        await pb.collection('setting').update(resultList.items.last.id, body: body);
                            Get.snackbar("", "تغییرات ذخیره شد",
                                colorText: Colors.white);
                   
                        Dio dio = Dio();
                        await dio.post('http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/config', data: {
                          "section": "DEFAULT",
                          "key": "socketport",
                          "value": portController.text
                        });
                        await dio.post('http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/config', data: {
                          "section": "DEFAULT",
                          "key": "serverport",
                          "value": connectConttroler.text
                        });
                      },
                      child: Text("ذخیره")))),
        ],
      ),
    );
  }

  Padding ipFunction(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Container(
            width: 110,
            child: Text(
              "${label}:",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}
