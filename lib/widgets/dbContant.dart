





import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/model.dart';
import 'package:unapwebv/model/storagedb/db.dart';
import 'package:unapwebv/widgets/Register.dart';
import 'package:unapwebv/widgets/arvand_pelak.dart';
import 'package:unapwebv/widgets/licancenumber.dart';

class DbContant extends StatefulWidget {
  const DbContant({
    super.key,
    
  }) ;

  @override
  State<DbContant> createState() => _DbContantState();
}

class _DbContantState extends State<DbContant> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  @override
  void dispose() {
      _databaseHelper.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 290,
      width: 50.w,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<List<plateModel>>(
          stream: _databaseHelper.entryStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: purpule,
                ),
              );
            }
            final entries = snapshot.data!.reversed.toList();
          

            if (Get.find<settingController>().alarm.value) {
              AudioPlayer audioPlayer = AudioPlayer();
              if (Get.find<Boxes>()
                  .regBox
                  .where(
                    (element) => element.plateNumber != entries.first.plateNum,
                  )
                  .isNotEmpty) {
               kIsWeb ?  audioPlayer.play(UrlSource('assets/alarm.mp3')) :  audioPlayer.play(AssetSource('assets/alarm.mp3'));
              }
              Dio dio = Dio();
              dio.post(
                  'http://${pathurl}:${Get.find<Boxes>().settingbox.last.connect}/email?email=${Get.find<Boxes>().userbox.last.email}',
                  data: {
                    "plateNumber": entries.last.plateNum,
                    "eDate": entries.last.eDate,
                    "eTime": entries.last.eTime
                  });
            }
            print(Get.find<Boxes>().settingbox.last.isRfid!);
            if (Get.find<Boxes>().settingbox.last.isRfid!) {
              print("inja");
              print(Get.find<Boxes>()
                  .regBox
                  .where(
                    (element) {
                      return element.plateNumber == entries.first.plateNum;
            }).isNotEmpty);
            
              if (Get.find<Boxes>()
                  .regBox
                  .where(
                    (element) => element.plateNumber == entries.first.plateNum,
                  )
                  .isNotEmpty) {
                    print("inja 2");
                if (Get.find<settingController>().rl1.value &&
                    Get.find<settingController>().rl2.value) {
                      print("?");
                  onRelayOne();
                  onRelayTwo();
                } else if (Get.find<settingController>().rl1.value == true &&
                    Get.find<settingController>().rl2.value == false) {
                      print("inja3");
    onRelayOne();
                } else if (Get.find<settingController>().rl1.value == false &&
                    Get.find<settingController>().rl2.value == true) {
               onRelayTwo();
                } else {
                  Get.snackbar("", "مشکلی در رله پیش امده");
                }
              } else {
                //Alarm
                Get.snackbar("", "ورود غیر مجاز");
              }
            }
            return ListView.separated(
                controller: ScrollController(
                  initialScrollOffset: 0.0,
                ),
                itemBuilder: (context, index) {
                
                  final entry = entries[index];

                  return InkWell(
                    onTap: () {
                      Get.find<tableController>().selectedIndex = index;
                      Get.find<tableController>().selectedmodel =
                          entries[index];
           
                      Get.find<tableController>().update();
                    },
                    child: Visibility(
                      visible: entry.isarvand == 'arvand'
                          ? entry.plateNum!.contains(RegExp('[a-zA-Z]'))
                              ? false
                              : true
                          : convertToPersian(entry.plateNum!, alphabetP2)[0] !=
                              '-',
                      child: Container(
                        height: 60,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: purpule,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            SizedBox(
                                width: 10.w,
                                child: entry.isarvand == 'arvand'
                                    ? ArvandPelak2(entry: entry)
                                    : LicanceNumber(entry: entry)),
                            VerticalDivider(
                              color: Colors.black,
                            ),
                            Container(
                              height: 48,
                              child: Center(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  ("${imagesPath}${entry.id}/${entry.imgpath}"), ///
                                  fit: BoxFit.fill,
                                  width: 10.w,
                                  height: 48,
                                ),
                              )),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                width: 8.w,
                                child: Get.find<Boxes>()
                                        .regBox
                                        .where(
                                          (element) =>
                                              element.plateNumber ==
                                              entry.plateNum,
                                        )
                                        .isNotEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.transparent
                                            // const Color.fromARGB(
                                            //     255, 36, 87, 37)
                                                ),
                                        child: Center(
                                          child: Text(
                                            
                                            Get.find<Boxes>()
                    .regBox[Get.find<Boxes>().regBox.indexWhere(
                          (element) =>
                              element.plateNumber ==
                              entry.plateNum,
                        )]
                    .name!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EnhancedCarRegistrationDialog(
                                                entry: entry,
                                                isEditing: false,
                                                isRegister: false,
                                                index: index,
                                              );
                                            },
                                          );
                                        },
                                        hoverColor: const Color.fromARGB(
                                            255, 29, 14, 55),
                                
                                        icon: Icon(Icons.add_box_outlined),
                                        color: Colors.white70,
                                        iconSize: 36,
                                      ),
                                height: 50,
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                            ),
                            Expanded(
                                child: Center(
                                    child: Container(
                              child: Text(
                                  Get.find<Boxes>()
                                            .camerabox.isEmpty ? '-' :
                                Get.find<Boxes>()
                                            .camerabox
                                            
                                            .firstWhere(
                                              (element) =>
                                                  element.rtpath ==
                                                  entry.rtpath,
                                            )
                                            .gate ==
                                        "exit"
                                    ? "دوربین خروجی"
                                    : "دوربین ورودی",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            )))
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                itemCount: entries.length);
          }),
    );
  }
}
