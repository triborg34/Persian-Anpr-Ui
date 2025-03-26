

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/detailedScreen.dart';
import 'package:unapwebv/widgets/arvand_pelak.dart';
import 'package:unapwebv/widgets/licancenumber.dart';
import  'package:persian_number_utility/persian_number_utility.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
                    width: 10.w,
                    height: 48,
                    child: tcontroller.selectedmodel.isarvand == 'arvand'
                        ? ArvandPelak(entry:tcontroller.selectedmodel)
                        :
                     LicanceNumber(entry: tcontroller.selectedmodel)),
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
                      width: 10.w,
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
                       contactOfTable(tcontroller.selectedIndex == -1
                    ? '-'
                    : tcontroller.selectedmodel.plateNum!.contains("x")
                        ? 'تاکسی'
                        : tcontroller.selectedmodel.plateNum!.contains('A')
                            ? "دولتی" :  tcontroller.selectedmodel.plateNum!.contains('PuV') ?   'کامیون' 
                            : "شخصی"
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
                : kIsWeb ?
                 "${tcontroller.selectedmodel.eTime!.split(":")[2]}:${tcontroller.selectedmodel.eTime!.split(":")[1]}:${tcontroller.selectedmodel.eTime!.split(":")[0]}" : tcontroller.selectedmodel.eTime!) 
                ,
                Container(
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: purpule))
                  ),
                  width: 10.w,
                  child: Center(
                    child: IconButton(onPressed: ()async{
                         final doc = pw.Document();
                      final ttf =
                          await fontFromAssetBundle('assets/fonts/arial.ttf');
                      // final image = await networkImage(
                      //     "${imagesPath}${selectedModel.id}/${selectedModel.imgpath}");
                      doc.addPage(pw.Page(
                          orientation: pw.PageOrientation.landscape,
                          pageFormat: PdfPageFormat.a5,
                          build: (pw.Context context) {
                            return pw.Container(
                                padding: pw.EdgeInsets.all(10),
                                height: double.infinity,
                                width: double.infinity,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Column(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.end,
                                          children: [
                                            pw.Text(
                                                "تاریخ : ${DateTime.now().toPersianDate()}",
                                                textDirection: pw.TextDirection.rtl,
                                                style: pw.TextStyle(font: ttf)),
                                            pw.Spacer(),
                                                              pw.Text(
                                            ' ساعت : ${DateTime.now().hour.toString().toPersianDigit()}:${DateTime.now().minute.toString().toPersianDigit()}',
                                            style: pw.TextStyle(font: ttf),
                                            textDirection:
                                                pw.TextDirection.rtl),
                                                pw.Spacer(),
                                            pw.Text(
                                                'شماره قبض : ${Random().nextInt(200).toString().toPersianDigit()}',
                                                style: pw.TextStyle(font: ttf),
                                                textDirection:
                                                    pw.TextDirection.rtl),
                                          ]),
                                      pw.SizedBox(height: 15),
                                      pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.end,
                                          children: [
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("دسترسی",
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("نام ماشین",
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("نام و نام خانوادگی",
                                                  style: pw.TextStyle(
                                                      font: ttf, fontSize: 8.0),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("ساعت ورود",
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("تاریخ ورود",
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text("شماره پلاک",
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                          ]),
                                      pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.end,
                                          children: [
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                  Get.find<Boxes>()
                                                          .regBox
                                                          .where(
                                                            (element) =>
                                                                element
                                                                    .plateNumber ==
                                                                tcontroller.selectedmodel
                                                                    .plateNum,
                                                          )
                                                          .isEmpty
                                                      ? "-"
                                                      : Get.find<Boxes>()
                                                          .regBox[Get.find<Boxes>()
                                                              .regBox
                                                              .indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .plateNumber ==
                                                                    tcontroller.selectedmodel
                                                                        .plateNum,
                                                              )]
                                                          .role!,
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                  Get.find<Boxes>()
                                                          .regBox
                                                          .where(
                                                            (element) =>
                                                                element
                                                                    .plateNumber ==
                                                                tcontroller.selectedmodel
                                                                    .plateNum,
                                                          )
                                                          .isEmpty
                                                      ? "-"
                                                      : Get.find<Boxes>()
                                                          .regBox[Get.find<Boxes>()
                                                              .regBox
                                                              .indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .plateNumber ==
                                                                    tcontroller.selectedmodel
                                                                        .plateNum,
                                                              )]
                                                          .carName!,
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                  Get.find<Boxes>()
                                                          .regBox
                                                          .where(
                                                            (element) =>
                                                                element
                                                                    .plateNumber ==
                                                                tcontroller.selectedmodel
                                                                    .plateNum,
                                                          )
                                                          .isEmpty
                                                      ? "-"
                                                      : Get.find<Boxes>()
                                                          .regBox[Get.find<Boxes>()
                                                              .regBox
                                                              .indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .plateNumber ==
                                                                    tcontroller.selectedmodel
                                                                        .plateNum,
                                                              )]
                                                          .name!,
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                  tcontroller.selectedmodel.eTime!
                                                      .toPersianDigit(),
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                  tcontroller.selectedmodel.eDate!
                                                      .toPersianDate(),
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                            pw.SizedBox(width: 0),
                                            pw.Container(
                                              height: 30,
                                              width: 70,
                                              alignment: pw.Alignment.center,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                              child: pw.Text(
                                                tcontroller.selectedmodel.isarvand=='arvand' ? tcontroller.selectedmodel.plateNum!.toPersianDigit() :
                                                  convertToPersianString(
                                                      tcontroller.selectedmodel.plateNum!,
                                                      alphabetP2),
                                                  style: pw.TextStyle(
                                                    font: ttf,
                                                  ),
                                                  textDirection:
                                                      pw.TextDirection.rtl),
                                            ),
                                          ]),
                                      pw.SizedBox(height: 25),
                                      pw.SizedBox(
                                          height: 15,
                                          child: pw.Align(
                                              alignment: pw.Alignment.topRight,
                                              child: pw.Text('توضیحات',
                                                  textDirection:
                                                      pw.TextDirection.rtl,
                                                  style: pw.TextStyle(font: ttf))))
                                    ]));
                          })); // Page
                      await Printing.layoutPdf(
                          format: PdfPageFormat.a5,
                          dynamicLayout: true,
                          usePrinterSettings: true,
                          onLayout: (PdfPageFormat format) async => doc.save());
                    }, icon: Icon(Icons.print)),
                  ),
                )
                ,
                Visibility(visible: Get.find<Boxes>().settingbox.last.isRfid!,child: IconButton(onPressed: (){
                  onRelayOne();
                }, icon: Icon(Icons.door_back_door)),)
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

      textDirection: TextDirection.rtl,
      children: [
        headerOftable("شماره پلاک"),
        headerOftable("عکس پلاک"),
        headerOftable(" نام و نام خانوادگی"),
        headerOftable("نوع ماشین"),
        headerOftable("دقت تشخیص پلاک"),
        headerOftable("دقت تشخیص حروف"),
        headerOftable("تاریخ ورود"),
        headerOftable("ساعت ورود"),
        headerOftable("چاپ اطلاعات")
      ],
    ),
  );
}

Container headerOftable(String title) {

  return Container(
      decoration:
          BoxDecoration(border: Border(left: BorderSide(color: purpule))),
      height: 50,
      width: 10.w,
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
      width: 10.w,
      child: Center(
          child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      )));
}
