import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/model.dart';

import 'package:unapwebv/widgets/alphabetselector.dart';
import 'package:unapwebv/widgets/appbar.dart';
import 'package:unapwebv/widgets/arvand_pelak.dart';
import 'package:unapwebv/widgets/licancenumber.dart';

class Detailedscreen extends StatelessWidget {
  plateModel selectedModel = plateModel();
  int index;
  Detailedscreen({required this.selectedModel, required this.index});

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    border: Border.all(color: purpule),
                    borderRadius: BorderRadius.circular(15)),
                height: 450,
                width: 800,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: EasyImageView(
                    imageProvider: NetworkImage(
                      "${imagesPath}${selectedModel.id}/${selectedModel.scrnPath}",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: header3(),
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: purpule))),
                alignment: Alignment.center,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    // contactOfTable3(tcontroller.selectedIndex == -1
                    //     ? "-"
                    //     : convertToPersianString(
                    //         selectedModel.plateNum!,
                    //         alphabetP2)),
                    index == -1
                        ? headerOftable3('-')
                        : InkWell(
                            onTap: () {
                              Get.find<ReportController>().platePicker=null;
                              Get.find<ReportController>().engishalphabet=null;
                              Get.find<ReportController>().lastTwoDigits.text='';
                              Get.find<ReportController>().threedigits.text='';
                              Get.find<ReportController>().persianalhpabet.value='';
                              
                              if (selectedModel.isarvand == 'arvand') {
                                 TextEditingController arvandController=TextEditingController(text: selectedModel.plateNum);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: 500,
                                        height: 150,
                                        decoration:
                                            BoxDecoration(color: purpule),
                                        child: Column(
                                          children: [
                                            Text(
                                              'ویرایش پلاک',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'byekan'),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Material(
                                              color: purpule,
                                              child: SizedBox(
                                                width: 350,
                                                child: TextField(
                                                  style: TextStyle(color: Colors.white,fontSize: 16),
                                                  controller:arvandController ,
                                                  decoration: InputDecoration(
                                                  
                                                      enabled: true,
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.circular(15)),
                                                      focusColor: purpule,
                                                      hoverColor: purpule,
                                                      filled: true,
                                                      fillColor: purpule),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15,),
                                            ElevatedButton(onPressed: ()async{
                                              String platePicker=arvandController.text;
                                                    await pb
                                                        .collection('database')
                                                        .update(
                                                            selectedModel.id!,
                                                            body: {
                                                          "plateNum":
                                                              platePicker
                                                        }).then(
                                                      (value) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "تغییر یافت")));
                                                        Get.find<
                                                                ReportController>()
                                                            .update([10]);
                                                        Navigator.pop(context);
                                                        Get.back();
                                                      },
                                                    );
                                            }, child: Text("ثبت"))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                var d = selectedModel.plateNum!
                                    .split(RegExp(r'[0-9]'))
                                    .toList()[2]
                                    .toString();
                                var ind =
                                    plateAlphabet.keys.toList().indexOf(d);
                                var f = plateAlphabet.values.elementAt(ind);

                                Get.find<ReportController>()
                                    .persianalhpabet
                                    .value = f;
                                Get.find<ReportController>().engishalphabet = d;
                                Get.find<ReportController>()
                                        .firtTwodigits
                                        .text =
                                    selectedModel.plateNum!
                                        .split(RegExp(r'[a-z,A-Z]'))
                                        .toList()[0];

                                try {
                                  Get.find<ReportController>()
                                          .threedigits
                                          .text =
                                      selectedModel.plateNum!
                                          .split(RegExp(r'[a-z,A-Z]'))
                                          .toList()[1]
                                          .substring(0, 3);

                                  Get.find<ReportController>()
                                          .lastTwoDigits
                                          .text =
                                      selectedModel.plateNum!
                                          .split(RegExp(r'[a-z,A-Z]'))
                                          .toList()[1]
                                          .substring(3, 5);
                                } catch (e) {
                                  Get.find<ReportController>()
                                      .threedigits
                                      .text = '-';
                                  Get.find<ReportController>()
                                      .lastTwoDigits
                                      .text = '-';
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 6),
                                        width: 500,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: purpule,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            Text(
                                              'ویرایش پلاک',
                                              style: TextStyle(
                                                  fontFamily: 'byekan',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Material(child: EditPlateNum2()),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 300,
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    var platePicker =
                                                        "${Get.find<ReportController>().firtTwodigits.text}${Get.find<ReportController>().engishalphabet == null ? '' : Get.find<ReportController>().engishalphabet}${Get.find<ReportController>().threedigits.text}${Get.find<ReportController>().lastTwoDigits.text}";
                                                    await pb
                                                        .collection('database')
                                                        .update(
                                                            selectedModel.id!,
                                                            body: {
                                                          "plateNum":
                                                              platePicker
                                                        }).then(
                                                      (value) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "تغییر یافت")));
                                                        Get.find<
                                                                ReportController>()
                                                            .update([10]);
                                                        Navigator.pop(context);
                                                        Get.back();
                                                      },
                                                    );
                                                  },
                                                  child: Text("ثبت")),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: GetBuilder<ReportController>(
                              id: 10,
                              init: ReportController(),
                              initState: (_) {},
                              builder: (_) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(color: purpule),
                                            left: BorderSide(color: purpule))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    width: 200,
                                    height: 48,
                                    child: selectedModel.isarvand == 'arvand'
                                        ? ArvandPelak(entry: selectedModel)
                                        : LicanceNumber(entry: selectedModel));
                              },
                            ),
                          ),

                    Container(
                      decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: purpule))),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      width: 224,
                      child: Center(
                        child: Hero(
                          tag: "heroTag${index}",
                          child: Image.network(
                            "${imagesPath}${selectedModel.id}/${selectedModel.imgpath}",
                            fit: BoxFit.fill,
                            width: 210,
                            height: 48,
                          ),
                        ),
                      ),
                    ),
                    contactOfTable3(Get.find<Boxes>()
                            .regBox
                            .where(
                              (element) =>
                                  element.plateNumber == selectedModel.plateNum,
                            )
                            .isEmpty
                        ? "-"
                        : Get.find<Boxes>()
                            .regBox[Get.find<Boxes>().regBox.indexWhere(
                                  (element) =>
                                      element.plateNumber ==
                                      selectedModel.plateNum,
                                )]
                            .name!),
                    contactOfTable3(Get.find<Boxes>()
                            .regBox
                            .where(
                              (element) =>
                                  element.plateNumber == selectedModel.plateNum,
                            )
                            .isEmpty
                        ? "-"
                        : Get.find<Boxes>()
                            .regBox[Get.find<Boxes>().regBox.indexWhere(
                                  (element) =>
                                      element.plateNumber ==
                                      selectedModel.plateNum,
                                )]
                            .carName!),
                    contactOfTable3(
                        selectedModel.platePercent.toString() + "%"),
                    contactOfTable3(selectedModel.charPercent.toString() + "%"),
                    contactOfTable3(selectedModel.eDate!.toPersianDate()),
                    contactOfTable3(selectedModel.eTime!)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Container header3() {
  return Container(
    alignment: Alignment.center,
    height: 50,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: purpule),
            top: BorderSide(color: purpule))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        headerOftable3("شماره پلاک"),
        headerOftable3("عکس پلاک"),
        headerOftable3(" نام و نام خانوادگی"),
        headerOftable3("نوع ماشین"),
        headerOftable3("درصد تشخیص پلاک"),
        headerOftable3("درصد تشخیص حروف"),
        headerOftable3("تاریخ ورود"),
        headerOftable3("ساعت ورود")
      ],
    ),
  );
}

Container headerOftable3(String title) {
  return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: purpule),
              right: title == "شماره پلاک"
                  ? BorderSide(color: purpule)
                  : BorderSide.none)),
      height: 50,
      width: 200,
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white),
      )));
}

Container contactOfTable3(String title) {
  return Container(
      decoration:
          BoxDecoration(border: Border(left: BorderSide(color: purpule))),
      height: 98,
      width: 224,
      child: Center(
          child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )));
}

class EditPlateNum2 extends StatelessWidget {
  const EditPlateNum2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: purpule,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: Get.find<ReportController>().firtTwodigits,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: purpule,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
            height: 40,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: purpule,
                    side: BorderSide(color: Colors.grey)),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize:
                          0.47, // You can adjust the size of the bottom sheet
                      minChildSize: 0.3,
                      maxChildSize: 0.7,
                      expand: false,
                      builder: (context, scrollController) {
                        return Alphabetselector(
                          scrollController: scrollController,
                        );
                      },
                    ),
                  );
                },
                child: Obx(() => Text(
                      Get.find<ReportController>().persianalhpabet.value == ''
                          ? "انتخاب حرف"
                          : Get.find<ReportController>().persianalhpabet.value,
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
              width: 70,
              height: 50,
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: Get.find<ReportController>().threedigits,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: purpule,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )),
          SizedBox(
            width: 15,
          ),
          SizedBox(
              width: 70,
              height: 50,
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: Get.find<ReportController>().lastTwoDigits,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: purpule,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
