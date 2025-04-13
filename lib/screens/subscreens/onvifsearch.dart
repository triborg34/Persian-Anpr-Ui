import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/storagedb/cameras.dart';
import 'package:unapwebv/screens/subscreens/cameraSetting.dart';

import 'dart:math';
import 'package:unapwebv/widgets/appbar.dart';

class OnvifSearch extends StatefulWidget {
  const OnvifSearch({super.key});

  @override
  State<OnvifSearch> createState() => _OnvifSearchState();
}

class _OnvifSearchState extends State<OnvifSearch> {
  bool _isLoading = false;

  List data = [];

  Future<void> _handleFetchData() async {
    setState(() {
      _isLoading = true;
    });
    data.clear();
    try {
      var res = await fetchData();
      if (res != null) {
        print('Done');
        print(res);
        data = res;
        setState(() {});
      } else {
        print("Error");
        setState(() {});
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {});
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _handleFetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: purpule,
                ),
              )
            : Center(
                child: Container(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          String cameraType = 'entrance'; // Default value
                          TextEditingController nameController =
                              TextEditingController();
                          TextEditingController username =
                              TextEditingController();
                          TextEditingController password =
                              TextEditingController();
                          bool _notvisibale = true;
                          nameController.clear();
                          username.clear();
                          password.clear();
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setstate) => Center(
                                  child: Container(
                                    width: 300,
                                    height: 400,
                                    decoration: BoxDecoration(
                                        color: purpule,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 250,
                                              height: 75,
                                              child: TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                cursorColor: Colors.white,
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      "نام",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    filled: true,
                                                    fillColor: Colors.black),
                                              )),
                                          SizedBox(
                                              width: 250,
                                              height: 75,
                                              child: TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                cursorColor: Colors.white,
                                                controller: username,
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      "نام کاربری",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    filled: true,
                                                    fillColor: Colors.black),
                                              )),
                                          SizedBox(
                                              width: 250,
                                              height: 75,
                                              child: TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                cursorColor: Colors.white,
                                                controller: password,
                                                obscureText: _notvisibale,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      "رمز عبور",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _notvisibale
                                                            ? Icons
                                                                .visibility_sharp
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setstate(() {
                                                          _notvisibale =
                                                              !_notvisibale;
                                                        });
                                                      },
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    filled: true,
                                                    fillColor: Colors.black),
                                              )),
                                          DropdownButtonFormField<String>(
                                            dropdownColor: Colors.black,
                                            value: cameraType,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: const InputDecoration(
                                              fillColor: Colors.black,
                                              filled: true,
                                              labelText: 'نوع دوربین',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
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
                                              setstate(() {
                                                cameraType = newValue!;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: 300,
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    var res = await fetchRtsp(
                                                        data[index]['ip'],
                                                        data[index]['port'],
                                                        username.text,
                                                        password.text);
                                                    Get.find<Boxes>()
                                                        .camerabox
                                                        .add(Cameras(
                                                            id: Random()
                                                                .nextInt(9999)
                                                                .toString(),
                                                            nameCamera:
                                                                nameController
                                                                    .text,
                                                            rtspname: 'main',
                                                            rtpath:
                                                                '/rt${Get.find<Boxes>().camerabox.length + 1}',
                                                            ip: res['rtsp'],
                                                            gate: cameraType,
                                                            status: true,
                                                            username:
                                                                username.text,
                                                            password:
                                                                password.text,
                                                                licance: generateRandomString(100),
                                                            isNotrtsp: false));
                                                            Get.find<Boxes>().update([5]);
                                                            Navigator.pop(context);
                                                            Get.back();

                                                  },
                                                  style: ButtonStyle(
                                                      shape: WidgetStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)))),
                                                  child: Text("ثبت")))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: purpule,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(0)),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              CameraSettingRows(title: index),
                              VerticalDivider(
                                color: Colors.white,
                              ),
                              CameraSettingRows(title: data[index]['ip']),
                              VerticalDivider(
                                color: Colors.white,
                              ),
                              CameraSettingRows(
                                  title: data[index]['port'].toString())
                            ],
                          ),
                        ),
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: purpule,
                        ),
                        borderRadius: BorderRadius.circular(15))),
              ),
      ),
    );
  }
}
