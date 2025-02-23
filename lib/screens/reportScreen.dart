import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/model.dart';
import 'package:unapwebv/screens/detailedScreen.dart';
import 'package:unapwebv/widgets/alphabetselector.dart';
import 'package:unapwebv/widgets/arvand_pelak.dart';
import 'package:unapwebv/widgets/licancenumber.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    try {
      Get.find<ReportController>().selectedItem = null;
      Get.find<ReportController>().firstime = null;
      Get.find<ReportController>().lastTime = null;
      Get.find<ReportController>().firstdate = null;
      Get.find<ReportController>().lastdate = null;
      Get.find<ReportController>().persianalhpabet.value = '';
      Get.find<ReportController>().platePicker = null;
      Get.find<ReportController>().selectedModel.clear();

      Get.find<ReportController>().engishalphabet = null;
      Get.find<ReportController>().lastTwoDigits.text = '';
      Get.find<ReportController>().threedigits.text = '';
    } catch (e) {
      print(e);
    }

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: purpule, borderRadius: BorderRadius.circular(15)),
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: false,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "جستجوی پیشرفته",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )),
                      ),
                      Text(
                        "صفحه گزارش",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<ReportController>(
                  builder: (rcontroller) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            tooltip: "ذخیره",
                            onPressed: () async {
                              if (rcontroller.selectedModel.isNotEmpty) {
                                final List<Map<String, dynamic>> data =
                                    await List.generate(
                                  rcontroller.selectedModel.length,
                                  (index) {
                                    return {
                                      "arvand": rcontroller
                                          .selectedModel[index].isarvand,
                                      "Plate Number": rcontroller
                                          .selectedModel[index].plateNum!
                                      //  convertToPersianString(
                                      //     rcontroller
                                      //         .selectedModel[index].plateNum!,
                                      //     alphabetP2),
                                      ,
                                      "Name": Get.find<Boxes>()
                                              .regBox
                                              .where(
                                                (element) =>
                                                    element.plateNumber ==
                                                    rcontroller
                                                        .selectedModel[index]
                                                        .plateNum,
                                              )
                                              .isEmpty
                                          ? "-"
                                          : Get.find<Boxes>()
                                              .regBox[Get.find<Boxes>()
                                                  .regBox
                                                  .indexWhere(
                                                    (element) =>
                                                        element.plateNumber ==
                                                        rcontroller
                                                            .selectedModel[
                                                                index]
                                                            .plateNum,
                                                  )]
                                              .name!,
                                      "Car name": Get.find<Boxes>()
                                              .regBox
                                              .where(
                                                (element) =>
                                                    element.plateNumber ==
                                                    rcontroller
                                                        .selectedModel[index]
                                                        .plateNum,
                                              )
                                              .isEmpty
                                          ? '-'
                                          : Get.find<Boxes>()
                                              .regBox[Get.find<Boxes>()
                                                  .regBox
                                                  .indexWhere(
                                                    (element) =>
                                                        element.plateNumber ==
                                                        rcontroller
                                                            .selectedModel[
                                                                index]
                                                            .plateNum,
                                                  )]
                                              .carName!,
                                      "Image Path":
                                          "${imagesPath}${rcontroller.selectedModel[index].id}/${rcontroller.selectedModel[index].imgpath}",
                                      "ScreenShot Path":
                                          "${imagesPath}${rcontroller.selectedModel[index].id}/${rcontroller.selectedModel[index].scrnPath}",
                                      "Plate Percsent": rcontroller
                                          .selectedModel[index].platePercent,
                                      "Char Percent": rcontroller
                                          .selectedModel[index].charPercent,
                                      "Date": rcontroller
                                          .selectedModel[index].eDate!,
                                      "Time": rcontroller
                                          .selectedModel[index].eTime!,
                                      "Status": Get.find<Boxes>()
                                              .regBox
                                              .where(
                                                (element) =>
                                                    element.plateNumber ==
                                                    rcontroller
                                                        .selectedModel[index]
                                                        .plateNum,
                                              )
                                              .isEmpty
                                          ? '-'
                                          : Get.find<Boxes>()
                                              .regBox[Get.find<Boxes>()
                                                  .regBox
                                                  .indexWhere(
                                                    (element) =>
                                                        element.plateNumber ==
                                                        rcontroller
                                                            .selectedModel[
                                                                index]
                                                            .plateNum,
                                                  )]
                                              .role!,
                                      "Camera Name": Get.find<Boxes>()
                                          .camerabox
                                          .firstWhere(
                                            (element) =>
                                                element.rtpath ==
                                                rcontroller.selectedModel[index]
                                                    .rtpath,
                                          )
                                          .nameCamera
                                    };
                                  },
                                );
                                await saveToCsv(data);

                                Get.snackbar("ذخیره شد", rcontroller.savePath!,
                                    backgroundColor: purpule,
                                    colorText: Colors.white,
                                    snackStyle: SnackStyle.FLOATING,
                                    snackPosition: SnackPosition.BOTTOM);
                              } else {
                                Get.snackbar("", "خطا گزارشی یافت نشد",
                                    colorText: Colors.white);
                              }
                            },
                            icon: Icon(
                              Icons.save_alt,
                              color: Colors.white,
                              size: 30,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                            height: 40,
                            width: 180,
                            child: ElevatedButton(
                              onPressed: () async {
                                await rcontroller.getData();
                                await searchfuncion(rcontroller);
                                rcontroller.update([2]);
                              },
                              //Here is on tab
                              child:
                                  Text("جستجو", style: TextStyle(fontSize: 16)),
                            )),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: FilledButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: purpule),
                              onPressed: () async {
                                var t = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  helpText: "ساعت را وارد کنید",
                                  confirmText: "تایید",
                                  cancelText: "لغو",
                                  hourLabelText: "ساعت",
                                  minuteLabelText: "دقیقه",
                                  initialEntryMode: TimePickerEntryMode.input,
                                  builder: (context, child) {
                                    return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!);
                                  },
                                );
                                rcontroller.lastTime = '${t!.hour}:${t.minute}';

                                rcontroller.update([1]);
                              },
                              child: Text(
                                rcontroller.lastTime == null
                                    ? " به ساعت"
                                    : rcontroller.lastTime.toString(),
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: FilledButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: purpule),
                              onPressed: () async {
                                var t = await showTimePicker(
                                  context: context,
                                  helpText: "ساعت را وارد کنید",
                                  confirmText: "تایید",
                                  cancelText: "لغو",
                                  hourLabelText: "ساعت",
                                  minuteLabelText: "دقیقه",
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input,
                                  builder: (context, child) {
                                    return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!);
                                  },
                                );
                                rcontroller.firstime = '${t!.hour}:${t.minute}';

                                rcontroller.update([1]);
                              },
                              child: Text(
                                rcontroller.firstime == null
                                    ? " از ساعت"
                                    : rcontroller.firstime.toString(),
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: FilledButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: purpule),
                              onPressed: () async {
                                Jalali? picked = await showPersianDatePicker(
                                    context: context,
                                    initialDate: Jalali.now(),
                                    firstDate: Jalali(1385),
                                    lastDate: Jalali(1499));

                                var d = picked!.toGregorian();
                                rcontroller.lastdate =
                                    d.toDateTime().toString().split(' ')[0];

                                rcontroller.update([1]);
                              },
                              child: Text(
                                  rcontroller.lastdate == null
                                      ? "به تاریخ"
                                      : rcontroller.lastdate!.toPersianDate(),
                                  style: TextStyle(fontSize: 14))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: FilledButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: purpule),
                              onPressed: () async {
                                Jalali? picked = await showPersianDatePicker(
                                    context: context,
                                    initialDate: Jalali.now(),
                                    firstDate: Jalali(1385),
                                    lastDate: Jalali(1499));

                                var d = picked!.toGregorian();
                                rcontroller.firstdate =
                                    d.toDateTime().toString().split(' ')[0];

                                rcontroller.update([1]);
                              },
                              child: Text(
                                  rcontroller.firstdate == null
                                      ? "از تاریخ"
                                      : rcontroller.firstdate!.toPersianDate(),
                                  style: TextStyle(fontSize: 14))),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              rcontroller.persianalhpabet.value = '';
                              rcontroller.firtTwodigits.clear();
                              rcontroller.lastTwoDigits.clear();
                              rcontroller.engishalphabet = null;
                              rcontroller.threedigits.clear();
                              showDialog(
                                context: context,
                                builder: (context) => Center(
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    width: 400,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: purpule,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Text(
                                          " اطلاعات پلاک را وارد کنید",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ReportTextField(
                                              tcontroller:
                                                  rcontroller.firtTwodigits,
                                              width: 50,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepPurple),
                                                onPressed: () async {
                                                  await showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder: (context) =>
                                                        DraggableScrollableSheet(
                                                      initialChildSize:
                                                          0.47, // You can adjust the size of the bottom sheet
                                                      minChildSize: 0.3,
                                                      maxChildSize: 0.7,
                                                      expand: false,
                                                      builder: (context,
                                                          scrollController) {
                                                        return Alphabetselector(
                                                          scrollController:
                                                              scrollController,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Obx(() => Text(
                                                      rcontroller.persianalhpabet
                                                                  .value ==
                                                              ''
                                                          ? "انتخاب حرف"
                                                          : rcontroller
                                                              .persianalhpabet
                                                              .value,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            ReportTextField(
                                              tcontroller:
                                                  rcontroller.threedigits,
                                              width: 75,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "/",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            ReportTextField(
                                              tcontroller:
                                                  rcontroller.lastTwoDigits,
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                            height: 35,
                                            child: FilledButton(
                                                onPressed: () {
                                                  rcontroller.platePicker =
                                                      "${rcontroller.firtTwodigits.text}${rcontroller.engishalphabet == null ? '' : rcontroller.engishalphabet}${rcontroller.threedigits.text}${rcontroller.lastTwoDigits.text}";

                                                  rcontroller.update([1]);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("تایید")))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "انتخاب",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                        // rcontroller.platePicker == null
                        //     ? DropFunc(rcontroller)
                        Container(
                          height: 40,
                          width: 210,
                          decoration: BoxDecoration(
                              color: purpule,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: rcontroller.firtTwodigits.text.length != 0 &&
                                    rcontroller.threedigits.text.length != 0 &&
                                    rcontroller.lastTwoDigits.text.length !=
                                        0 &&
                                    rcontroller.engishalphabet != null
                                ? Text(
                                    convertToPersianString(
                                        rcontroller.platePicker!, alphabetP2),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        height: 30,
                                        width: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            rcontroller.firtTwodigits.text
                                                        .length !=
                                                    0
                                                ? rcontroller.firtTwodigits.text
                                                : '-',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        height: 30,
                                        width: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            rcontroller.engishalphabet != null
                                                ? rcontroller
                                                    .persianalhpabet.value
                                                : '?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        height: 30,
                                        width: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            rcontroller.threedigits.text
                                                        .length !=
                                                    0
                                                ? rcontroller.threedigits.text
                                                : '-',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '/',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            rcontroller.lastTwoDigits.text
                                                        .length !=
                                                    0
                                                ? rcontroller.lastTwoDigits.text
                                                : '-',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  },
                  id: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                header2(),
                Container(
                    color: Colors.transparent,
                    width: Get.width,
                    height: 500,
                    child: GetBuilder<ReportController>(
                      id: 2,
                      builder: (rcontroller) {
                        return ListView.builder(
                          controller: ScrollController(
                              initialScrollOffset: 0, debugLabel: "Controller"),
                          reverse: false,
                          itemCount: rcontroller.selectedModel.length, //todo
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: rcontroller
                                          .selectedModel[index].isarvand ==
                                      'arvand'
                                  ? rcontroller.selectedModel[index].plateNum!
                                          .contains(RegExp('[a-zA-Z]'))
                                      ? false
                                      : true
                                  : convertToPersian(
                                          rcontroller
                                              .selectedModel[index].plateNum!,
                                          alphabetP2)[0] !=
                                      '-',

                              // rcontroller.selectedModel[index].isarvand ==
                              //         'arvand'
                              //     ? true
                              //     : convertToPersian(
                              //             rcontroller.selectedModel[index]
                              //                 .plateNum!,
                              //             alphabetP2)[0] !=
                              //         '-',
                              child: Container(
                                width: Get.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: purpule))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: purpule))),
                                        width: 12.w,
                                        child: Center(
                                          child: Text(
                                            rcontroller
                                                .selectedModel[index].eTime!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: purpule))),
                                        width: 12.w,
                                        child: Center(
                                          child: Text(
                                            rcontroller
                                                .selectedModel[index].eDate!
                                                .toPersianDate(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: purpule))),
                                        width: 12.w,
                                        child: Center(
                                          child: Text(
                                            Get.find<Boxes>()
                                                        .camerabox
                                                        .firstWhere(
                                                          (element) =>
                                                              element.rtpath ==
                                                              rcontroller
                                                                  .selectedModel[
                                                                      index]
                                                                  .rtpath,
                                                        )
                                                        .gate ==
                                                    "exit"
                                                ? "دوربین خروجی"
                                                : "دوربین ورودی",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: purpule))),
                                        width: 12.w,
                                        child: Center(
                                          child: Text(
                                            rcontroller.selectedModel[index]
                                                    .platePercent
                                                    .toString() +
                                                "%",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left:
                                                  BorderSide(color: purpule))),
                                      width: 12.w,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          Get.find<Boxes>()
                                                  .regBox
                                                  .where(
                                                    (element) =>
                                                        element.plateNumber ==
                                                        rcontroller
                                                            .selectedModel[
                                                                index]
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
                                                            rcontroller
                                                                .selectedModel[
                                                                    index]
                                                                .plateNum,
                                                      )]
                                                  .carName!,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left:
                                                  BorderSide(color: purpule))),
                                      width: 12.w,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          Get.find<Boxes>()
                                                  .regBox
                                                  .where(
                                                    (element) =>
                                                        element.plateNumber ==
                                                        rcontroller
                                                            .selectedModel[
                                                                index]
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
                                                            rcontroller
                                                                .selectedModel[
                                                                    index]
                                                                .plateNum,
                                                      )]
                                                  .name!,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: purpule))),
                                        width: 12.w,
                                        child: Center(
                                          child: InkWell(
                                              onTap: () {
                                                Get.to(() => Detailedscreen(
                                                      selectedModel: rcontroller
                                                          .selectedModel[index],
                                                      index: index,
                                                    ));
                                              },
                                              child: Hero(
                                                  tag: "heroTag${index}",
                                                  child: Image.network(
                                                    "${imagesPath}${rcontroller.selectedModel[index].id}/${rcontroller.selectedModel[index].imgpath}",
                                                    fit: BoxFit.fill,
                                                    width: 12.w,
                                                    height: 48,
                                                  ))),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(5.0),
                                        height: 50,
                                        width: 12.w,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right:
                                                    BorderSide(color: purpule),
                                                left: BorderSide(
                                                    color: purpule))),
                                        child: rcontroller
                                                    .selectedModel[index]
                                                    .isarvand ==
                                                "arvand"
                                            ? SizedBox(
                                                width: 12.w,
                                                height: 50,
                                                child: ArvandPelak(
                                                    entry: rcontroller
                                                            .selectedModel[
                                                        index]))
                                            : LicanceNumber(
                                                entry: rcontroller
                                                    .selectedModel[index])),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ))
              ],
            ),
          ),
        ));
  }

  bool searchfuncion(var rcontroller) {
    if (rcontroller.selectedItem != null &&
        rcontroller.firstdate != null &&
        rcontroller.firstime != null) {
      //3 true
      rcontroller.lastdate == null
          ? rcontroller.lastdate = rcontroller.firstdate!
          : rcontroller.lastdate = rcontroller.lastdate;
      rcontroller.lastTime == null
          ? rcontroller.lastTime = rcontroller.firstime!
          : rcontroller.firstime = rcontroller.firstime;

      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          DateTime fd = DateTime.parse(rcontroller.firstdate!);
          DateTime ld = DateTime.parse(rcontroller.lastdate!);
          DateTime ed = DateTime.parse(element.eDate!);
          bool isdate = rcontroller.lastdate == rcontroller.firstdate!
              ? element.eDate == rcontroller.firstdate
              : ed.isBefore(ld) && ed.isAfter(fd);
          TimeOfDay ft = TimeOfDay(
              hour: int.parse(rcontroller.firstime!.split(':')[0]),
              minute: int.parse(rcontroller.firstime!.split(':')[1]));
          TimeOfDay lt = TimeOfDay(
              hour: int.parse(rcontroller.lastTime!.split(':')[0]),
              minute: int.parse(rcontroller.lastTime!.split(':')[1]));
          TimeOfDay et = TimeOfDay(
              hour: int.parse(element.eTime!.split(':')[0]),
              minute: int.parse(element.eTime!.split(':')[1]));
          bool isTime = rcontroller.lastTime == rcontroller.firstime!
              ? element.eDate == rcontroller.firstdate
              : getTime(ft, lt, et);
          // print( isdate);
          return element.plateNum == rcontroller.selectedItem &&
              isdate &&
              isTime;
        },
      ).toList();
    } else if (rcontroller.selectedItem == null &&
        rcontroller.firstdate != null &&
        rcontroller.firstime != null) {
      //2 true (plate not true)
      rcontroller.lastdate == null
          ? rcontroller.lastdate = rcontroller.firstdate!
          : rcontroller.lastdate = rcontroller.lastdate;
      rcontroller.lastTime == null
          ? rcontroller.lastTime = rcontroller.firstime!
          : rcontroller.firstime = rcontroller.firstime;
      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          DateTime fd = DateTime.parse(rcontroller.firstdate!);
          DateTime ld = DateTime.parse(rcontroller.lastdate!);
          DateTime ed = DateTime.parse(element.eDate!);
          bool isdate = rcontroller.lastdate == rcontroller.firstdate!
              ? element.eDate == rcontroller.firstdate
              : ed.isBefore(ld) && ed.isAfter(fd);
          TimeOfDay ft = TimeOfDay(
              hour: int.parse(rcontroller.firstime!.split(':')[0]),
              minute: int.parse(rcontroller.firstime!.split(':')[1]));
          TimeOfDay lt = TimeOfDay(
              hour: int.parse(rcontroller.lastTime!.split(':')[0]),
              minute: int.parse(rcontroller.lastTime!.split(':')[1]));
          TimeOfDay et = TimeOfDay(
              hour: int.parse(element.eTime!.split(':')[0]),
              minute: int.parse(element.eTime!.split(':')[1]));
          bool isTime = rcontroller.lastTime == rcontroller.firstime!
              ? element.eDate == rcontroller.firstdate
              : getTime(ft, lt, et);
          if (rcontroller.platePicker != null) {
            return isdate &&
                isTime &&
                element.plateNum!.contains(rcontroller.platePicker!);
          } else
            return isdate && isTime;
          // print( isdate);
        },
      ).toList();
    } else if (rcontroller.selectedItem == null &&
        rcontroller.firstdate == null &&
        rcontroller.firstime != null) {
      //1 true (plate and date)
      rcontroller.lastTime == null
          ? rcontroller.lastTime = rcontroller.firstime!
          : rcontroller.firstime = rcontroller.firstime;
      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          TimeOfDay ft = TimeOfDay(
              hour: int.parse(rcontroller.firstime!.split(':')[0]),
              minute: int.parse(rcontroller.firstime!.split(':')[1]));
          TimeOfDay lt = TimeOfDay(
              hour: int.parse(rcontroller.lastTime!.split(':')[0]),
              minute: int.parse(rcontroller.lastTime!.split(':')[1]));
          TimeOfDay et = TimeOfDay(
              hour: int.parse(element.eTime!.split(':')[0]),
              minute: int.parse(element.eTime!.split(':')[1]));
          bool isTime = rcontroller.lastTime == rcontroller.firstime!
              ? element.eDate == rcontroller.firstdate
              : getTime(ft, lt, et);
          // print( isdate);
          if (rcontroller.platePicker != null) {
            return isTime &&
                element.plateNum!.contains(rcontroller.platePicker!);
          } else
            return isTime;
        },
      ).toList();
      //time handled in above
    } else if (rcontroller.selectedItem != null &&
        rcontroller.firstdate != null &&
        rcontroller.firstime == null) {
      // 2 true (time not)
      rcontroller.lastdate == null
          ? rcontroller.lastdate = rcontroller.firstdate!
          : rcontroller.lastdate = rcontroller.lastdate;
      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          DateTime fd = DateTime.parse(rcontroller.firstdate!);
          DateTime ld = DateTime.parse(rcontroller.lastdate!);
          DateTime ed = DateTime.parse(element.eDate!);
          bool isdate = rcontroller.lastdate == rcontroller.firstdate!
              ? element.eDate == rcontroller.firstdate
              : ed.isBefore(ld) && ed.isAfter(fd);

          // print( isdate);
          return element.plateNum == rcontroller.selectedItem && isdate;
        },
      ).toList();
    } else if (rcontroller.selectedItem == null &&
        rcontroller.firstdate != null &&
        rcontroller.firstime == null) {
      //one true (time and plate not)
      rcontroller.lastdate == null
          ? rcontroller.lastdate = rcontroller.firstdate!
          : rcontroller.lastdate = rcontroller.lastdate;
      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          DateTime fd = DateTime.parse(rcontroller.firstdate!);
          DateTime ld = DateTime.parse(rcontroller.lastdate!);
          DateTime ed = DateTime.parse(element.eDate!);
          bool isdate = rcontroller.lastdate == rcontroller.firstdate!
              ? element.eDate == rcontroller.firstdate
              : ed.isBefore(ld) && ed.isAfter(fd);

          if (rcontroller.platePicker != null) {
            return isdate &&
                element.plateNum!.contains(rcontroller.platePicker!);
          } else
            return isdate;
        },
      ).toList();
    } else if (rcontroller.selectedItem != null &&
        rcontroller.firstdate == null &&
        rcontroller.firstime == null) {
      //one true (time and date not)
      rcontroller.selectedModel = rcontroller.pModel.where(
        (element) {
          return element.plateNum == rcontroller.selectedItem;
        },
      ).toList();
    } else if (rcontroller.selectedItem == null &&
        rcontroller.firstdate == null &&
        rcontroller.firstime == null &&
        rcontroller.platePicker != null) {
      //plate picker is not null

      rcontroller.selectedModel = rcontroller.pModel.where(
        (plateModel element) {
          return element.plateNum!.contains(rcontroller.platePicker!);
        },
      ).toList();
    } else {
      // all is null

      rcontroller.selectedModel = rcontroller.pModel;
    }

    return true;
  }

  DropdownButtonHideUnderline DropFunc(ReportController rcontroller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textDirection: TextDirection.ltr,
              expands: true,
              maxLines: null,
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintTextDirection: TextDirection.rtl,
                hintText: 'جستجو...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        alignment: Alignment.centerRight,
        dropdownStyleData: DropdownStyleData(
          elevation: 0,
          scrollbarTheme: ScrollbarThemeData(),
          direction: DropdownDirection.right,
          decoration: BoxDecoration(
              color: purpule, borderRadius: BorderRadius.circular(15)),
        ),
        style: TextStyle(color: Colors.white),
        isExpanded: true,
        hint: Text(
          'پلاک را انتخاب کنید',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        items: rcontroller.pModel
            .map((var item) => DropdownMenuItem<String>(
                  value: item.plateNum,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      convertToPersianString(item.plateNum!, alphabetP2),
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ))
            .toList(),
        value: rcontroller.selectedItem,
        onChanged: (String? value) {
          rcontroller.selectedItem = value;
          rcontroller.update([1]);
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              color: purpule, borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 180,
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.purple),
          height: 40,
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
      ),
    );
  }
}

Container header2() {
  return Container(
    alignment: Alignment.center,
    height: 50,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: purpule),
            top: BorderSide(color: purpule))),
    child: Row(

      textDirection: TextDirection.rtl,
      children: [
        headerOftable2("شماره پلاک"),
        headerOftable2("عکس پلاک"),
        headerOftable2(" نام و نام خانوادگی"),
        headerOftable2("نوع ماشین"),
        headerOftable2("درصد تشخیص پلاک"),
        headerOftable2("دوربین"),
        headerOftable2("تاریخ ورود"),
        headerOftable2("ساعت ورود"),
      ],
    ),
  );
}

Container contactOfTable2(String title) {
  return Container(
      decoration:
          BoxDecoration(border: Border(left: BorderSide(color: purpule))),
      height: 98,
      width: 12.w,
      child: Center(
          child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )));
}

bool getTime(TimeOfDay ft, TimeOfDay lt, TimeOfDay et) {
  int ftMin = ft.hour * 60 + ft.minute;
  int ltMin = lt.hour * 60 + ft.minute;
  int etMin = et.hour * 60 + et.minute;

  return ftMin < etMin && etMin <= ltMin;
}

Container headerOftable2(String title) {
  return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: purpule),
              right: title == "شماره پلاک"
                  ? BorderSide(color: purpule)
                  : BorderSide.none)),
      height: 50,
      width: 12.w,
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white),
      )));
}

class ReportTextField extends StatelessWidget {
  double? width;
  TextEditingController tcontroller;
  ReportTextField({this.width, required this.tcontroller});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: purpule,
        height: 40,
        width: width,
        child: Material(
          color: purpule,
          borderOnForeground: false,
          child: TextField(
            controller: tcontroller,
            style: TextStyle(color: Colors.white, fontSize: 16),
            cursorColor: Colors.white,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
                focusColor: Colors.white,
                filled: true,
                fillColor: Colors.deepPurpleAccent,
                disabledBorder: OutlineInputBorder(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ));
  }
}

// void saveToExel(List<Map<String, dynamic>> data) {
//   if (data.isNotEmpty) {
//     final simplexlsx = SimpleXLSX();
//     simplexlsx.sheetName = 'sheet';

//     //adiciona os dados
//     var idx = 0;
//     data.forEach((item) {
//       if (idx == 0) {
//         //adiciona os titulos
//         simplexlsx.addRow(item.keys.toList());
//       }
//       {
//         //adiciona os valores
//         simplexlsx.addRow(item.values.map((i) => i.toString()).toList());
//       }
//       idx++;
//     });

//     final bytes = simplexlsx.build();

//     File('teste.xlsx').writeAsBytesSync(bytes);
//   }
// }

Future<void> saveToCsv(List<Map<String, dynamic>> data) async {
  
  final doc = pw.Document();
  final ttf = await fontFromAssetBundle('assets/fonts/arial.ttf');
  doc.addPage(
    pw.MultiPage(
      textDirection: pw.TextDirection.rtl,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      build: (pw.Context context) {
        return [
          // Replace the Column with a list of widgets
          pw.Row(children: [
 pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'پلاک',
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
               pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'تاریخ',
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
               pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'ساعت',
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
               pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'نام و نام خانوادگی',
                    style: pw.TextStyle(font: ttf,fontSize: 8) // Apply the font
                    ),
              ),
               pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'ماشین',
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
               pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                   'نام دوربین',
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
          ]),
          for (var i in data)
   i['arvand'] == 'arvand'   || convertToPersianString(i['Plate Number'], alphabetP2) !='-'  ?      pw.Container(
              child: pw.Row(children: [
                  pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['arvand'] == 'arvand'
                        ? i['Plate Number'].contains(RegExp('[a-zA-Z]'))
                            ? "-"
                            : i['Plate Number'].toString().toPersianDigit()
                        : convertToPersianString(i['Plate Number'], alphabetP2),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
              pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['Date'].toString().toPersianDate(),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
                         pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['Time'].toString().toPersianDigit(),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
                                 pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['Name'].toString(),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
                    
              ),
                                 pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['Car name'].toString(),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
                                        pw.Container(
                height: 30,
                width: 75,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    i['Camera Name'].toString(),
                    style: pw.TextStyle(font: ttf) // Apply the font
                    ),
              ),
            ])
            ) : pw.SizedBox()
        ];
      },
      // Optional: Add header/footer to all pages
      footer: (pw.Context context) => pw.Text(' صفحه  ${context.pageNumber}',style: pw.TextStyle(font: ttf),textDirection: pw.TextDirection.rtl),
    ),
  );
  await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      dynamicLayout: true,
      usePrinterSettings: true,
      onLayout: (PdfPageFormat format) async => doc.save());

  // Define the custom directory path
  // final directory = Directory('../output/');
  // if (!await directory.exists()) {
  //   await directory.create(recursive: true);

  // }

  // Get.find<ReportController>().savePath =
  //     '${directory.path}/Report ${DateTime.now().month}-${DateTime.now().day} ${DateTime.now().hour}-${DateTime.now().minute}.csv';

  // // Create a CSV file
  // final File file = File(Get.find<ReportController>().savePath!);
  // final sink = file.openWrite();

  // // Write headers
  // final headers = data.first.keys.toList();
  // sink.writeln(headers.join(','));

  // // Write data
  // for (final row in data) {
  //   final values =
  //       headers.map((header) => row[header]?.toString() ?? '').toList();
  //   sink.writeln(values.join(','));
  // }

  // await sink.flush();
  // await sink.close();
}

// Future<void> saveToExel(List<Map<String, dynamic>> data) async {
//   // Create a new Excel workbook
  
//   final Excel.Workbook workbook = Excel.Workbook();

//   // Access the first worksheet
//   final Excel.Worksheet sheet = workbook.worksheets[0];
//   Excel.Style globalStyle = workbook.styles.add('style');
//   // Set the worksheet direction to RTL
//   sheet.isRightToLeft = true;

//   globalStyle.bold = true;
//   globalStyle.backColor = '#37D8E9';
//   // Add headers to the first row
//   final headers = data.first.keys.toList();
//   for (int i = 0; i < headers.length; i++) {
//     sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
//   }

//   // Populate data starting from the second row
//   for (int row = 0; row < data.length; row++) {
//     final rowData = data[row];
//     for (int col = 0; col < headers.length; col++) {
//       final cellValue = rowData[headers[col]];
//       sheet
//           .getRangeByIndex(row + 2, col + 1)
//           .setText(cellValue?.toString() ?? '');
//     }
//   }

//   // Save the workbook as a stream
//   final List<int> bytes = workbook.saveAsStream();
//   try {
//     workbook.dispose();
//   } catch (e) {
//     print(e);
//   }

//   // Get the path to save the file
// final directory = Directory('D:/Codes/uianprt/output/');

//   Get.find<ReportController>().savePath =
//       '${directory.path}/Report ${DateTime.now().month}/${DateTime.now().day} - ${DateTime.now().hour}:${DateTime.now().minute}.xlsx';

//   // Write the file
//   final File file = File(Get.find<ReportController>().savePath!);
//   await file.writeAsBytes(bytes, flush: true);

//   print('Excel file saved as RTL at: ${Get.find<ReportController>().savePath}');
// }
