// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:unapwebv/controller/mianController.dart';

import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/storagedb/cameras.dart';

class CameraSetting extends StatefulWidget {
  CameraSetting({super.key});

  @override
  State<CameraSetting> createState() => _CameraSettingState();
}

class _CameraSettingState extends State<CameraSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white70)),
                color: purpule,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
      
                CameraSettingRows(
                  title: 'اسم دوربین',
                ),
                VerticalDivider(),
                CameraSettingRows(
                  title: 'ادرس دوربین',
                ),
                VerticalDivider(),
                CameraSettingRows(
                  title: 'لایسنس',
                ),
                VerticalDivider(),
                CameraSettingRows(
                  title: 'ورودی/خروجی',
                ),
                VerticalDivider(),
                Container(
                    width: 150,
                    child: Center(
                      child: Text(
                        "وضعیت".toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
                VerticalDivider(),
                Container(
                  width: 70,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "اتصال مجدد",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "ویرایش",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "حذف",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          GetBuilder<Boxes>(
            id: 5,
            builder: (controller) {
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: purpule,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        CameraSettingRows(
                            title: controller.camerabox
                                .toList()[index]
                                .nameCamera),
                        VerticalDivider(),
                        CameraSettingRows(
                            title: controller.camerabox.toList()[index].ip),
                        VerticalDivider(),
                        CameraSettingRows(
                            title:
                                controller.camerabox.toList()[index].licance),
                        VerticalDivider(),
                        CameraSettingRows(
                            title: controller.camerabox.toList()[index].gate ==
                                    "exit"
                                ? "خروج"
                                : Get.find<Boxes>()
                                    .camerabox
                                    .toList()[index]
                                    .gate!
                                    .replaceFirst('entrance', 'ورود')),
                        VerticalDivider(),
                        controller.camerabox.toList()[index].status == true
                            ? Container(
                                width: 150,
                                child: Center(
                                    child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 32,
                                )))
                            : Container(
                                width: 150,
                                child: Center(
                                    child: Icon(
                                  Icons.dangerous,
                                  color: Colors.red,
                                  size: 32,
                                ))),
                        VerticalDivider(),
                        Container(
                          width: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "",
                                      middleText:
                                          "لطفا برای اعمال تغییرات برنامه را مجدد باز کنید");
                                },
                                icon: Icon(
                                  FontAwesomeIcons.repeat,
                                  color: Colors.white70,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final TextEditingController
                                          nameController =
                                          TextEditingController(
                                              text: controller.camerabox
                                                  .toList()[index]
                                                  .nameCamera);
                                      final TextEditingController ipController =
                                          TextEditingController(
                                              text: controller.camerabox
                                                  .toList()[index]
                                                  .ip);
                                      String cameraType = controller.camerabox
                                          .toList()[index]
                                          .gate!; // Default value
                                      final TextEditingController username =
                                          TextEditingController(
                                              text: controller
                                                  .camerabox[index].username);
                                      final TextEditingController password =
                                          TextEditingController(
                                              text: controller
                                                  .camerabox[index].password);
                                      final TextEditingController rtspname =
                                          TextEditingController(
                                              text: controller
                                                  .camerabox[index].rtspname);

                                      bool isnotrtsp = controller.camerabox
                                          .toList()[index]
                                          .isNotrtsp!;
                                      return AlertDialog(
                                        title: const Text('اضافه کردن دوربین'),
                                        content: SingleChildScrollView(
                                          child: StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // Using TextFormField instead of TextField for better Windows compatibility
                                                  TextFormField(
                                                    style: TextStyle(
                                                        fontFamily: 'arial'),
                                                    controller: nameController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'اسم دوربین',
                                                      hintText:
                                                          'اسم دوربین را وارد کنید',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    // Enable keyboard handling for Windows
                                                    keyboardType:
                                                        TextInputType.text,
                                                    autofocus: true,
                                                  ),
                                                  const SizedBox(height: 16),

                                                  Visibility(
                                                    maintainAnimation: false,
                                                    replacement: Column(
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              isnotrtsp =
                                                                  !isnotrtsp;
                                                              setState(
                                                                () {},
                                                              );
                                                            },
                                                            child: Text(
                                                              "وارد کردن  Ip",
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                            )),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'arial'),
                                                          controller:
                                                              ipController,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'آدرس RTSP',
                                                            hintText:
                                                                'e.g:rtsp://192.168.1.1:554/ch4',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          // Enable keyboard handling for Windows
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                      ],
                                                    ),
                                                    visible: isnotrtsp,
                                                    child: Column(
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              isnotrtsp =
                                                                  !isnotrtsp;
                                                              setState(
                                                                () {},
                                                              );
                                                            },
                                                            child: Text(
                                                              "وارد کردن مستقیم RTSP",
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                            )),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'arial'),
                                                          controller:
                                                              ipController,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'آدرس دوربین',
                                                            hintText:
                                                                'e.g:192.168.1.1',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          // Enable keyboard handling for Windows
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        TextFormField(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'arial'),
                                                          controller: rtspname,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'آدرس نمایش',
                                                            hintText:
                                                                'e.g:stream,mainstream',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          // Enable keyboard handling for Windows
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  TextFormField(
                                                    style: TextStyle(
                                                        fontFamily: 'arial'),
                                                    controller: username,
                                                    decoration: InputDecoration(
                                                      labelText: 'نام کاربری',
                                                      hintText: 'e.g:admin',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    // Enable keyboard handling for Windows
                                                    keyboardType:
                                                        TextInputType.text,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  TextFormField(
                                                    style: TextStyle(
                                                        fontFamily: 'arial'),
                                                    controller: password,
                                                    decoration: InputDecoration(
                                                      labelText: 'کلمه عبور',
                                                      hintText: 'e.g:admin',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    // Enable keyboard handling for Windows
                                                    keyboardType:
                                                        TextInputType.text,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  // Using DropdownButton instead of Radio for better Windows experience,
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: cameraType,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'نوع دوربین',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    items: const [
                                                      DropdownMenuItem(
                                                        value: 'entrance',
                                                        child: Text('ورود'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'exit',
                                                        child: Text('خروج'),
                                                      ),
                                                    ],
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        cameraType = newValue!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              nameController.dispose();
                                              ipController.dispose();
                                              username.dispose();
                                              password.dispose();
                                              rtspname.dispose();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('خروج'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              final cameraData = {
                                                'name': nameController.text,
                                                'ip': ipController.text,
                                                'type': cameraType,
                                                'username': username.text,
                                                'password': password.text,
                                                'rtspname': rtspname.text,
                                                'isnotrtsp': isnotrtsp
                                              };

                                              nameController.dispose();
                                              ipController.dispose();
                                              username.dispose();
                                              password.dispose();
                                              rtspname.dispose();

                                              Navigator.of(context)
                                                  .pop(cameraData);
                                            },
                                            child: const Text('ثبت'),
                                          ),
                                        ],
                                      );
                                    },
                                  ).then((value) async {
                                    if (value != null) {
                                      // Handle the camera data

                                      Get.find<Boxes>().camerabox[index] =
                                          Cameras(
                                              rtpath: controller
                                                  .camerabox[index].rtpath,
                                              id: controller.camerabox
                                                  .toList()[index]
                                                  .id,
                                              gate: value['type'],
                                              ip: value['ip'],
                                              nameCamera: value['name'],
                                              rtspname: value['rtspname'],
                                              status: true,
                                              username: value['username'],
                                              password: value['username'],
                                              isNotrtsp: value['isnotrtsp'],
                                              licance: controller.camerabox
                                                  .toList()[index]
                                                  .licance);
                                    }
                                    Get.find<Boxes>().update([5]);
                                    var body={
                                           "rtpath": controller
                                                  .camerabox[index].rtpath,
                                              "id": controller.camerabox
                                                  .toList()[index]
                                                  .id,
                                              "gate": value['type'],
                                              "ip": value['ip'],
                                              "nameCamera": value['name'],
                                              "rtspname": value['rtspname'],
                                              "status": true,
                                              "username": value['username'],
                                              "password": value['username'],
                                              "isNotrtsp": value['isnotrtsp'],
                                              "licance": controller.camerabox
                                                  .toList()[index]
                                                  .licance

                                    };
                                    await pb.collection('cameras').update(controller.camerabox
                                                  .toList()[index]
                                                  .id!, body: body);
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.penToSquare,
                                  color: Colors.white70,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: IconButton(
                                onPressed: () async {
                                    await pb.collection('cameras').delete(controller.camerabox[index].id!);
                                  await controller.camerabox.removeAt(index);
                                 
                                ;
                                  Get.find<Boxes>().update([5]);
                                  setState(() {});
                                },
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  color: Colors.red,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: controller.camerabox.length,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 0,
                    height: 0,
                  ),
                ),
              );
            },
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
// Button to show dialog
              Visibility(
                visible: Get.find<Boxes>().nol.value >
                    Get.find<Boxes>().camerabox.length,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final TextEditingController nameController =
                            TextEditingController();
                        final TextEditingController ipController =
                            TextEditingController();
                        final TextEditingController username =
                            TextEditingController();
                        final TextEditingController password =
                            TextEditingController();
                        String cameraType = 'entrance'; // Default value
                        final TextEditingController rtspname =
                            TextEditingController();
                        bool isnotrtsp = true;

                        return AlertDialog(
                          title: const Text('اضافه کردن دوربین'),
                          content: SingleChildScrollView(
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Using TextFormField instead of TextField for better Windows compatibility
                                    TextFormField(
                                      style: TextStyle(fontFamily: 'arial'),
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'اسم دوربین',
                                        hintText: 'اسم دوربین را وارد کنید',
                                        border: OutlineInputBorder(),
                                      ),
                                      // Enable keyboard handling for Windows
                                      keyboardType: TextInputType.text,
                                      autofocus: true,
                                    ),
                                    const SizedBox(height: 16),

                                    Visibility(
                                      maintainAnimation: false,
                                      replacement: Column(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                isnotrtsp = !isnotrtsp;
                                                setState(
                                                  () {},
                                                );
                                              },
                                              child: Text(
                                                "وارد کردن  Ip",
                                                textDirection:
                                                    TextDirection.rtl,
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            style:
                                                TextStyle(fontFamily: 'arial'),
                                            controller: ipController,
                                            decoration: InputDecoration(
                                              labelText: 'آدرس RTSP',
                                              hintText:
                                                  'e.g:rtsp://192.168.1.1:554/ch4',
                                              border: OutlineInputBorder(),
                                            ),
                                            // Enable keyboard handling for Windows
                                            keyboardType: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                      visible: isnotrtsp,
                                      child: Column(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                isnotrtsp = !isnotrtsp;
                                                setState(
                                                  () {},
                                                );
                                              },
                                              child: Text(
                                                "وارد کردن مستقیم RTSP",
                                                textDirection:
                                                    TextDirection.rtl,
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            style:
                                                TextStyle(fontFamily: 'arial'),
                                            controller: ipController,
                                            decoration: InputDecoration(
                                              labelText: 'آدرس دوربین',
                                              hintText: 'e.g:192.168.1.1',
                                              border: OutlineInputBorder(),
                                            ),
                                            // Enable keyboard handling for Windows
                                            keyboardType: TextInputType.text,
                                          ),
                                          const SizedBox(height: 16),
                                          TextFormField(
                                            style:
                                                TextStyle(fontFamily: 'arial'),
                                            controller: rtspname,
                                            decoration: InputDecoration(
                                              labelText: 'آدرس نمایش',
                                              hintText: 'e.g:stream,mainstream',
                                              border: OutlineInputBorder(),
                                            ),
                                            // Enable keyboard handling for Windows
                                            keyboardType: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      style: TextStyle(fontFamily: 'arial'),
                                      controller: username,
                                      decoration: InputDecoration(
                                        labelText: 'نام کاربری',
                                        hintText: 'e.g:admin',
                                        border: OutlineInputBorder(),
                                      ),
                                      // Enable keyboard handling for Windows
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      style: TextStyle(fontFamily: 'arial'),
                                      controller: password,
                                      decoration: InputDecoration(
                                        labelText: 'کلمه عبور',
                                        hintText: 'e.g:admin',
                                        border: OutlineInputBorder(),
                                      ),
                                      // Enable keyboard handling for Windows
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 16),
                                    // Using DropdownButton instead of Radio for better Windows experience,
                                    DropdownButtonFormField<String>(
                                      value: cameraType,
                                      decoration: const InputDecoration(
                                        labelText: 'نوع دوربین',
                                        border: OutlineInputBorder(),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'entrance',
                                          child: Text('ورود'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'exit',
                                          child: Text('خروج'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          cameraType = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                nameController.dispose();
                                ipController.dispose();
                                username.dispose();
                                password.dispose();
                                rtspname.dispose();
                                Navigator.of(context).pop();
                              },
                              child: const Text('خروج'),
                            ),
                            TextButton(
                              onPressed: () {
                                final cameraData = {
                                  'name': nameController.text,
                                  'ip': ipController.text,
                                  'type': cameraType,
                                  'username': username.text,
                                  'password': password.text,
                                  'rtspname': rtspname.text,
                                  'isnotrtsp': isnotrtsp
                                };

                                nameController.dispose();
                                ipController.dispose();
                                username.dispose();
                                password.dispose();
                                rtspname.dispose();
                                Navigator.of(context).pop(cameraData);
                                setState(() {});
                              },
                              child: const Text('ثبت'),
                            ),
                          ],
                        );
                      },
                    ).then((value) async {
                      if (value != null) {
                        // Handle the camera data

                        Get.find<Boxes>().camerabox.add(Cameras(
                            id: Random().nextInt(9999).toString(),
                            gate: value['type'],
                            ip: value['ip'],
                            nameCamera: value['name'],
                            status: true,
                            username: value['username'],
                            password: value['password'],
                            rtspname: value['rtspname'],
                            isNotrtsp: value['isnotrtsp'],
                            rtpath:
                                '/rt${Get.find<Boxes>().camerabox.length + 1}',
                            licance: generateRandomString(100)));
                      }
                  
                      Get.find<Boxes>().update([5]);
                    });
                  },
                  child: Row(
                    children: [
                      Text('اضافه کردن'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.add_circle),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  var dio = Dio();
                      
                      var body = {
                        "id": Get.find<Boxes>().camerabox.last.id,
                        "gate": Get.find<Boxes>().camerabox.last.gate,
                        "ip": Get.find<Boxes>().camerabox.last.ip,
                        "nameCamera": Get.find<Boxes>().camerabox.last.nameCamera,
                        "status": Get.find<Boxes>().camerabox.last.status,
                        "username": Get.find<Boxes>().camerabox.last.username,
                        "password": Get.find<Boxes>().camerabox.last.password,
                        "rtspname": Get.find<Boxes>().camerabox.last.rtspname,
                        "isNotrtsp": Get.find<Boxes>().camerabox.last.isNotrtsp,
                        "rtpath":
                            Get.find<Boxes>().camerabox.last.rtpath,
                        "licance": Get.find<Boxes>().camerabox.last.licance
                      };
                      final record =
                          await pb.collection('cameras').create(body: body);
                  var res = dio.post(
                      'http://127.0.0.1:${Get.find<Boxes>().settingbox.last.connect}/cameras',
                      data: {
                        "ip": "${Get.find<Boxes>().camerabox.last.ip}",
                        "username":
                            "${Get.find<Boxes>().camerabox.last.username}",
                        "password":
                            "${Get.find<Boxes>().camerabox.last.password}",
                        'isnotrstp':
                            "${Get.find<Boxes>().camerabox.last.isNotrtsp}"
                      }).then(
                    (value) {
                      // print({
                      //   "username":
                      //       "${Get.find<Boxes>().camerabox.values.first.username}",
                      //   "password":
                      //       "${Get.find<Boxes>().camerabox.values.first.password}"
                      // });
                      if (value.statusCode == 200) {
                        Get.snackbar(
                          "",
                          '',
                          colorText: Colors.white,
                          messageText: Text(
                            "تنظیمات ذخیره شد",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'arial'),
                          ),
                        );
                      }
                    },
                  );
                },
                child: Row(
                  children: [
                    Text("ذخیره"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.save_as),
                  ],
                ),
              ),
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}

class CameraSettingRows extends StatelessWidget {
  CameraSettingRows({
    super.key,
    required this.title,
  });

  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 11.w,
        child: Center(
          child: Text(
            title.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
