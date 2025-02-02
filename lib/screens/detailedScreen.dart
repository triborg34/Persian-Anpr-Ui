

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/model.dart';
import 'package:unapwebv/widgets/appbar.dart';
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
                        ),),
    
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: header3(),
              ),
              Container(
                height: 48,
               margin: const EdgeInsets.symmetric(horizontal: 8.0) ,
               decoration: BoxDecoration(border: Border(bottom: BorderSide(color: purpule))),
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
                        : Container(
                          
                            decoration: BoxDecoration(
                                border:
                                    Border(right: BorderSide(color: purpule),left: BorderSide(color: purpule))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            width: 200,
                            height: 48,
                            child: LicanceNumber(entry: selectedModel)),

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
                            contactOfTable3(selectedModel.platePercent.toString()+"%"),
                            contactOfTable3(selectedModel.charPercent.toString()+"%"),
                    contactOfTable3( selectedModel.eDate!.toPersianDate()),
                    contactOfTable3( selectedModel.eTime!)
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
