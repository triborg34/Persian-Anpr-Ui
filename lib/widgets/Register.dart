// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/reportScreen.dart';
import 'package:unapwebv/widgets/alphabetselector.dart';
import 'package:unapwebv/widgets/arvand_pelak.dart';
import 'package:unapwebv/widgets/licancenumber.dart';

class EnhancedCarRegistrationDialog extends StatefulWidget {

  final dynamic
      entry; // Assuming this is the entry object from your original code
  final bool isEditing;
  final bool isRegister;
  int index;

  EnhancedCarRegistrationDialog(
      {Key? key,
      required this.index,
      required this.entry,
      required this.isEditing,
      required this.isRegister})
      : super(key: key);

  @override
  _EnhancedCarRegistrationDialogState createState() =>
      _EnhancedCarRegistrationDialogState();
}

class _EnhancedCarRegistrationDialogState
    extends State<EnhancedCarRegistrationDialog> {
  String? _selectedRole;
  final List<String> _roles = ['مجاز', 'غیر مجاز'];
  bool arvandSwith = true;
  TextEditingController arvandController = TextEditingController();
  @override
  void initState() {
    if (widget.isEditing) {
      print(Get.find<Boxes>().regBox[widget.index].isarvand );
      if (Get.find<Boxes>().regBox[widget.index].isarvand != 'arvand') {
        Get.find<feildController>().Fname.text =
            Get.find<Boxes>().regBox[widget.index].name!.split(' ').toList()[1];
        Get.find<feildController>().carName.text =
            Get.find<Boxes>().regBox[widget.index].carName!;
        Get.find<feildController>().socialNumber.text =
            Get.find<Boxes>().regBox[widget.index].socialNumber!;
        Get.find<feildController>().name.text =
            Get.find<Boxes>().regBox[widget.index].name!.split(' ').toList()[0];
        _selectedRole = Get.find<Boxes>().regBox[widget.index].role;

        //

        var d = Get.find<Boxes>()
            .regBox[widget.index]
            .plateNumber!
            .split(RegExp(r'[0-9]'))
            .toList()[2]
            .toString();
        var ind = plateAlphabet.keys.toList().indexOf(d);
        var f = plateAlphabet.values.elementAt(ind);

        Get.find<ReportController>().persianalhpabet.value = f;
        Get.find<ReportController>().engishalphabet = d;
        Get.find<ReportController>().firtTwodigits.text = Get.find<Boxes>()
            .regBox[widget.index]
            .plateNumber!
            .split(RegExp(r'[a-z,A-Z]'))
            .toList()[0];

        try {
          Get.find<ReportController>().threedigits.text = Get.find<Boxes>()
              .regBox[widget.index]
              .plateNumber!
              .split(RegExp(r'[a-z,A-Z]'))
              .toList()[1]
              .substring(0, 3);

          Get.find<ReportController>().lastTwoDigits.text = Get.find<Boxes>()
              .regBox[widget.index]
              .plateNumber!
              .split(RegExp(r'[a-z,A-Z]'))
              .toList()[1]
              .substring(3, 5);
        } catch (e) {
          Get.find<ReportController>().threedigits.text = '-';
          Get.find<ReportController>().lastTwoDigits.text = '-';
        }
      } else {
        arvandController.text =
            Get.find<Boxes>().regBox[widget.index].plateNumber!;
        print(Get.find<Boxes>().regBox[widget.index].plateNumber!);
      }
    } else {
      Get.find<feildController>().Fname.clear();
      Get.find<feildController>().carName.clear();
      Get.find<feildController>().socialNumber.clear();
      Get.find<feildController>().name.clear();
      arvandController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: 450,
        decoration: BoxDecoration(
          color: const Color(0xFF6A5ACD), // A nice purple shade
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.deepPurpleAccent.shade700, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isEditing ? "ویرایش اطلاعات خودرو" : "ثبت اطلاعات خودرو",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    arvandSwith = !arvandSwith;
                    setState(() {});
                  },
                  child: Text(
                    " نوع پلاک",
                    style: TextStyle(color: Colors.white),
                  )),
              // Car Name and License Number Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.isEditing
                        ? Get.find<Boxes>().regBox[widget.index].isarvand ==
                                'arvand'
                            ? arvandEditor(arvandController: arvandController)
                            : EditPlateNum(widget: widget)
                        : widget.isRegister
                            ? Visibility(
                                visible: arvandSwith,
                                replacement: arvandEditor(
                                    arvandController: arvandController),
                                child: licanceField())
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100),
                                  child: widget.entry.isarvand == 'arvand'
                                      ? ArvandPelak(entry: widget.entry)
                                      : LicanceNumber(entry: widget.entry),
                                ),
                              ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Name and Family Name Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: TextField(
                          controller: Get.find<feildController>().name,
                          decoration: InputDecoration(
                            hintText: "نام خانوادگی",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: TextField(
                          controller: Get.find<feildController>().Fname,
                          decoration: InputDecoration(
                            hintText: "نام",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Social Security Number (کد ملی)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: Get.find<feildController>().carName,
                        decoration: InputDecoration(
                          hintText: "نام خودرو",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: TextField(
                        controller: Get.find<feildController>().socialNumber,
                        decoration: InputDecoration(
                          hintText: "کد ملی",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Role Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        "انتخاب وضعیت",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      value: _selectedRole,
                      items: _roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Register Button
              ElevatedButton(
                onPressed: () async {
                  if (arvandSwith) {
                    Get.find<ReportController>().platePicker =
                        "${Get.find<ReportController>().firtTwodigits.text}${Get.find<ReportController>().engishalphabet == null ? '' : Get.find<ReportController>().engishalphabet}${Get.find<ReportController>().threedigits.text}${Get.find<ReportController>().lastTwoDigits.text}";
                  } else {
                    Get.find<ReportController>().platePicker =
                        arvandController.text;
                  }
                  // Create RegistredDb object with the new fields
                

                  // String id = Random().nextInt(9999).toString();
                 
                    // print(widget.entry.plateNum);
                    // registredDb = RegistredDb(
                    //     id: id,
                    //     role: _selectedRole ?? '',
                    //     socialNumber: Get.find<feildController>()
                    //         .socialNumber
                    //         .text, // Add the social security number here
                    //     plateImagePath: widget.entry.imgpath,
                    //     plateNumber: widget.entry.plateNum,
                    //     rtpath: widget.entry.rtpath,
                    //     carName: Get.find<feildController>().carName.text,
                    //     name:
                    //         "${Get.find<feildController>().Fname.text} ${Get.find<feildController>().name.text}",
                    //     status: true,
                    //     eDate: widget.entry.eDate,
                    //     eTime: widget.entry.eTime,
                    //     screenImg: widget.entry.scrnPath,
                    //     isarvand: widget.entry.isarvand);
                if(widget.isRegister==false && widget.isEditing==false){
                      try {
                      final body = <String, dynamic>{
                     
                        "plateImagePath": widget.entry.imgpath,
                        "plateNumber": widget.entry.plateNum,
                        "name":
                            "${Get.find<feildController>().Fname.text} ${Get.find<feildController>().name.text}",
                        "carName": Get.find<feildController>().carName.text,
                        "eDate": widget.entry.eDate,
                        "eTime": widget.entry.eTime,
                        "status": true,
                        "screenImg": widget.entry.scrnPath,
                        "role": _selectedRole ?? '',
                        "socialNumber":
                            Get.find<feildController>().socialNumber.text,
                        "isarvand": widget.entry.isarvand,
                        "rtpath": widget.entry.rtpath,
                      };
                      await pb.collection('registredDb').create(body: body);
                      // Get.find<Boxes>().regBox.add(registredDb);
                      Get.find<Boxes>().getregData();
                    } catch (e) {
                      print(e);
                    }
                }
                
                else if(widget.isRegister==true && widget.isEditing==false){
                                 try {
                      final body = <String, dynamic>{
                     
                        "plateImagePath":'',
                        "plateNumber":Get.find<ReportController>().platePicker,
                        "name":
                            "${Get.find<feildController>().Fname.text} ${Get.find<feildController>().name.text}",
                        "carName": Get.find<feildController>().carName.text,
                        "eDate": DateTime.now().toString(),
                        "eTime":"${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                        "status": true,
                        "screenImg":'',
                        "role": _selectedRole ?? '',
                        "socialNumber":
                            Get.find<feildController>().socialNumber.text,
                        "isarvand": arvandSwith ? "notarvand" : 'arvnad',
                        "rtpath":'/rt1',
                      };
                      await pb.collection('registredDb').create(body: body);
                      // Get.find<Boxes>().regBox.add(registredDb);
                      Get.find<Boxes>().getregData();
                    } catch (e) {
                      print(e);
                    }

                }
                    // print(e);
           
         
                  
                  // Add to Hive and refresh
                  else  {
                    String tempplate =
                        Get.find<Boxes>().regBox[widget.index].plateNumber!;
                    
                    try {
                      final body = <String, dynamic>{
                        "plateImagePath": Get.find<Boxes>()
                            .regBox[widget.index]
                            .plateImagePath,
                        "plateNumber": Get.find<ReportController>().platePicker,
                        "name":
                            "${Get.find<feildController>().Fname.text} ${Get.find<feildController>().name.text}",
                        "carName": Get.find<feildController>().carName.text,
                        "eDate": Get.find<Boxes>().regBox[widget.index].eDate,
                        "eTime": Get.find<Boxes>().regBox[widget.index].eTime,
                        "status": true,
                        "screenImg":
                            Get.find<Boxes>().regBox[widget.index].screenImg,
                        "role": _selectedRole,
                        "socialNumber":
                            Get.find<feildController>().socialNumber.text,
                        "isarvand":
                            Get.find<Boxes>().regBox[widget.index].isarvand,
                        "rtpath": Get.find<Boxes>().regBox[widget.index].rtpath
                      };

                      final record =
                          await pb.collection('registredDb').getFirstListItem(
                                'plateNumber ="${tempplate}"',
                              );
                      print(record.id);
                      await await pb
                          .collection('registredDb')
                          .update(record.id, body: body);
                    } catch (e) {
                      print(e);
                    }
                    Get.find<Boxes>().getregData();
                  // } else {
                  //   try {
                  //     final body = <String, dynamic>{
                  //       "id": id,
                  //       "plateImagePath": "",
                  //       "plateNumber": Get.find<ReportController>().platePicker,
                  //       "name":
                  //           "${Get.find<feildController>().Fname.text} ${Get.find<feildController>().name.text}",
                  //       "carName": Get.find<feildController>().carName.text,
                  //       "eDate": DateTime.now().toString(),
                  //       "eTime":
                  //           "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                  //       "status": true,
                  //       "screenImg": "",
                  //       "role": _selectedRole,
                  //       "socialNumber":
                  //           Get.find<feildController>().socialNumber.text,
                  //       "isarvand": arvandSwith ? "notarvand" : 'arvnad',
                  //       "rtpath": "/rt1"
                  //     };
                  //     await pb.collection('registredDb').create(body: body);
                  //   } catch (e) {
                  //     print(e);
                  //   }
                  
                    Get.find<Boxes>().getregData();
                  }

                  // Show success notification
                  Get.snackbar(
                    "ثبت شد",
                    "",
                    colorText: Colors.white,
                    backgroundColor: Colors.green.shade600,
                    maxWidth: 200,
                  );
                  Get.find<Boxes>().update([9]);

                  // Close the dialog
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "ثبت",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class arvandEditor extends StatelessWidget {
  const arvandEditor({
    super.key,
    required this.arvandController,
  });

  final TextEditingController arvandController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 350,
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: arvandController,
          decoration: InputDecoration(
              enabled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15)),
              focusColor: purpule,
              hoverColor: purpule,
              filled: true,
              fillColor: purpule),
        ),
      ),
    );
  }
}

class EditPlateNum extends StatelessWidget {
  const EditPlateNum({
    super.key,
    required this.widget,
  });

  final EnhancedCarRegistrationDialog widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: TextField(
              controller: Get.find<ReportController>().firtTwodigits,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
              style: TextButton.styleFrom(backgroundColor: Colors.white),
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
                    style: TextStyle(color: Colors.black),
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
                controller: Get.find<ReportController>().threedigits,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                controller: Get.find<ReportController>().lastTwoDigits,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class licanceField extends StatefulWidget {
  const licanceField({super.key});

  @override
  State<licanceField> createState() => _licanceFieldState();
}

class _licanceFieldState extends State<licanceField> {
  @override
  void initState() {
    Get.find<ReportController>().persianalhpabet.value = '';
    Get.find<ReportController>().firtTwodigits.clear();
    Get.find<ReportController>().lastTwoDigits.clear();
    Get.find<ReportController>().engishalphabet = null;
    Get.find<ReportController>().threedigits.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        width: 400,
        height: 100,
        decoration: BoxDecoration(
            color: purpule, borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReportTextField(
                tcontroller: Get.find<ReportController>().firtTwodigits,
                width: 50,
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 40,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
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
                          Get.find<ReportController>().persianalhpabet.value ==
                                  ''
                              ? "انتخاب حرف"
                              : Get.find<ReportController>()
                                  .persianalhpabet
                                  .value,
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              SizedBox(
                width: 15,
              ),
              ReportTextField(
                tcontroller: Get.find<ReportController>().threedigits,
                width: 75,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "/",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                width: 15,
              ),
              ReportTextField(
                tcontroller: Get.find<ReportController>().lastTwoDigits,
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ]));
  }
}

//      var platePicker = "${firtTwodigits.text}${engishalphabet == null ? '' : engishalphabet}${threedigits.text}${lastTwoDigits.text}";
                                              //       