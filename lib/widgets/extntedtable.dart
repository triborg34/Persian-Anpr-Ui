

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/detailedScreen.dart';
import 'package:unapwebv/widgets/licancenumber.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

Container contant() {
  return Container(
      height: 48,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: GetBuilder<tableController>(
        builder: (tcontroller) => Row(
         
          textDirection: TextDirection.rtl,
          children: [
            // contactOfTable(tcontroller.selectedIndex == -1
            //     ? "-"
            //     : convertToPersianString(
            //         tcontroller.selectedmodel.plateNum!,
            //         alphabetP2)),
            tcontroller.selectedIndex == -1
                ? headerOftable('-')
                : Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: purpule))),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: Get.width/9.03,
                    height: 48,
                    child:  LicanceNumber(entry: tcontroller.selectedmodel)),
            tcontroller.selectedIndex == -1
                ? headerOftable('-')
                : InkWell(
                  onTap: () {
                    Get.to(()=>Detailedscreen(selectedModel: tcontroller.selectedmodel, index: tcontroller.selectedIndex));
                  },
                  child: Container(

                    height: 48,
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                          border: Border(left: BorderSide(color: purpule))),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      width: 223,
                      child: Center(
                        child: Hero(tag: 'heroTag${tcontroller.selectedIndex}',child: Image.network("${imagesPath}${tcontroller.selectedmodel.id}/${tcontroller.selectedmodel.imgpath}",fit: BoxFit.fill,width: 205,),),
                      ),
                    ),
                ),
            contactOfTable(Get.find<Boxes>()
                    .regBox
                    .where(
                      (element) =>
                          element.plateNumber ==
                          tcontroller.selectedmodel.plateNum,
                    )
                    .isEmpty
                ? "-"
                : Get.find<Boxes>()
                    .regBox[Get.find<Boxes>().regBox.indexWhere(
                          (element) =>
                              element.plateNumber ==
                              tcontroller.selectedmodel.plateNum,
                        )]
                    .name!),
            contactOfTable(tcontroller.selectedIndex==-1 ? '-':
            tcontroller.selectedmodel.plateNum!.contains("x") ? 'تاکسی' : tcontroller.selectedmodel.plateNum!.contains('A') ? "دولتی" : "شخصی" 
            // Get.find<Boxes>()
            //         .regBox
            //         .where(
            //           (element) =>
            //               element.plateNumber ==
            //               tcontroller.selectedmodel.plateNum,
            //         )
            //         .isEmpty
            //     ? "-"
            //     : Get.find<Boxes>()
            //         .regBox[Get.find<Boxes>().regBox.indexWhere(
            //               (element) =>
            //                   element.plateNumber ==
            //                   tcontroller.selectedmodel.plateNum,
            //             )]
            //         .carName!
                    ),
                      // Expanded(
                      //           child: Center(
                      //               child: Container(
                                      
                      //         child: Text(entry.plateNum!.contains('x')
                      //             ? "تاکسی"
                      //             : entry.plateNum!.contains('A')
                      //                 ? "دولتی"
                      //                 : "شخصی",style: TextStyle(color: Colors.white,fontSize: 18),),
                      //       )))
            contactOfTable(tcontroller.selectedIndex == -1
                ? "-"
                : tcontroller.selectedmodel.platePercent!.toString()+"%"),
                   contactOfTable(tcontroller.selectedIndex == -1
                ? "-"
                : tcontroller.selectedmodel.charPercent.toString()+"%"),
                   contactOfTable(tcontroller.selectedIndex == -1
                ? "-"
                : tcontroller.selectedmodel.eDate!.toPersianDate()),
                
            contactOfTable(tcontroller.selectedIndex == -1
                ? "-"
                : tcontroller.selectedmodel.eTime!)
          ],
        ),
      ));
}

Container header() {
  return Container(
    alignment: Alignment.center,
    height: 50,
    decoration:
        BoxDecoration(border: Border(bottom: BorderSide(color: purpule))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        headerOftable("شماره پلاک"),
        headerOftable("عکس پلاک"),
        headerOftable(" نام و نام خانوادگی"),
        headerOftable("نوع ماشین"),
        headerOftable("دقت تشخیص پلاک"),
        headerOftable("دقت تشخیص حروف"),
        headerOftable("تاریخ ورود"),
        headerOftable("ساعت ورود")
      ],
    ),
  );
}

Container headerOftable(String title) {

  return Container(
      decoration:
          BoxDecoration(border: Border(left: BorderSide(color: purpule))),
      height: 50,
      width: Get.width/9.03,
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white),
      )));
}

Container contactOfTable(String title) {
  
  return Container(
      decoration:
          BoxDecoration(border: Border(left: BorderSide(color: purpule))),
      height: 98,
      width: Get.width/8.34,
      child: Center(
          child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )));
}
