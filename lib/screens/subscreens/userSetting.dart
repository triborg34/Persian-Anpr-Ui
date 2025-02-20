
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:unapwebv/model/storagedb/users.dart';
import 'package:unapwebv/widgets/Register.dart';

class UserSetting extends StatelessWidget {
  UserSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                  color: purpule, borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text(
                "کاربران",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<Boxes>(
              id: 6,
              builder: (controller) {
                return Container(
                  height: 110,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: purpule),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              UserRows(title: index.toString()),
                              VerticalDivider(
                                color: purpule,
                              ),
                              UserRows(
                                  title: controller.userbox
                                      .toList()[index]
                                      .nickname),
                              VerticalDivider(
                                color: purpule,
                              ),
                              UserRows(
                                  title: controller.userbox
                                      .toList()[index]
                                      .email),
                              VerticalDivider(
                                color: purpule,
                              ),
                              UserRows(
                                  title: controller.userbox
                                      .toList()[index]
                                      .accsesslvl),
                              VerticalDivider(
                                color: purpule,
                              ),
                              UserRows(
                                  title: controller.userbox
                                      .toList()[index]
                                      .id),
                              VerticalDivider(
                                color: purpule,
                              ),
                              IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => //TODO?::EDIT:;
                                        UserRegistrationDialog(
                                      isEditing: true,
                                      index: index,
                                    ),
                                  );
                                  Get.find<Boxes>().update([6]);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                onPressed: ()async {
                                  await pb.collection('users').delete(Get.find<Boxes>().userbox[index].id!);
                                  await Get.find<Boxes>().userbox.removeAt(index); //TODO:
                                  Get.find<Boxes>().update([6]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            color: purpule,
                            height: 0,
                          ),
                      itemCount: controller.userbox.length),
                );
              },
            ),
            Container(
                child: Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => UserRegistrationDialog(
                          isEditing: false,
                          index: 0,
                        ),
                      );
                      Get.find<Boxes>().update([6]);
                    },
                    child: Row(
                      children: [Text("اضافه کردن")],
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ذخیره شد')));
                    },
                    child: Row(
                      children: [Text("ذخیره")],
                    ))
              ],
            )),
            SizedBox(
              height: 25,
            ),
            Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                    color: purpule, borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  "افراد ثبت شده",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ))),
            SizedBox(
              height: 15,
            ),
GetBuilder<Boxes>(id: 9,builder: (controller) {
  return             Container(
              height: 150,
              child: ListView.separated(
                  itemBuilder: (context, index) {
  
                    return Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: purpule),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                        Get.find<Boxes>().regBox[index].isarvand=='arvand' ? UserRows(title:  Get.find<Boxes>().regBox[index].plateNumber) :   UserRows(
                              title: convertToPersianString(
                                  Get.find<Boxes>().regBox[index].plateNumber!,
                                  alphabetP2)),
                          VerticalDivider(
                            color: purpule,
                          ),
                          Container(
                            width: 240,
                            child: Center(
                              child: Get.find<Boxes>().regBox[index].plateImagePath=='' ?Text("-") : Image.network(
                                (
                                 "${imagesPath}${Get.find<Boxes>().regBox[index].plateImagePath}"),
                                width: 240,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: purpule,
                          ),
                          UserRows(title: Get.find<Boxes>().regBox[index].name),
                          VerticalDivider(
                            color: purpule,
                          ),
                          UserRows(
                              title: Get.find<Boxes>().regBox[index].carName),
                          VerticalDivider(
                            color: purpule,
                          ),
                          UserRows(
                              title: Get.find<Boxes>()
                                  .regBox[index]
                                  .eDate!
                                  .toPersianDate()),
                          VerticalDivider(
                            color: purpule,
                          ),
                          UserRows(
                              title: Get.find<Boxes>().regBox[index].eTime!),
                          VerticalDivider(
                            color: purpule,
                          ),
                          Get.find<Boxes>().regBox[index].role=="مجاز"
                              ? Icon(
                                  Icons.check_box,
                                  color: Colors.lightGreenAccent,
                                )
                              : Icon(
                                  Icons.block,
                                  color: Colors.red,
                                ),
                          VerticalDivider(
                            color: purpule,
                          ),
                          IconButton(
                              onPressed: ()async {
                             await    showDialog(context: context, builder: (context) {
                                return EnhancedCarRegistrationDialog(entry:  null,isEditing: true,isRegister: true,index: index,);
                             },) ;
                              },
                              icon:  Icon(Icons.edit)),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () async{
                                      await pb.collection('registredDb').delete(Get.find<Boxes>().regBox[index].id!);
                                    await Get.find<Boxes>().regBox.removeAt(index); //TODO:
                                     Get.find<Boxes>().getregData();
                                    Get.find<Boxes>().update([9]);
                              },
                              icon: Icon(
                               
                                   
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                  itemCount: Get.find<Boxes>().regBox.length),
            );
},),
            SizedBox(
              height: 15,
            ),
            Container(
                child: Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
            

                      await showDialog(context: context, builder: (context) {
                        return EnhancedCarRegistrationDialog(entry:  null,isEditing: false,isRegister: true,index: 0,);
                      },);
                    },
                    child: Row(
                      children: [Text("اضافه کردن")],
                    )),
                SizedBox(
                  width: 15,
                ),
         
              ],
            )),
          ],
        ));
  }
}

class UserRows extends StatelessWidget {
  UserRows({
    super.key,
    required this.title,
  });

  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: Center(
          child: Text(
            title.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ));
  }
}

class UserRegistrationDialog extends StatefulWidget {
  final bool? isEditing;
  final int? index;
  UserRegistrationDialog(
      {Key? key, required this.isEditing, required this.index})
      : super(key: key);

  @override
  _UserRegistrationDialogState createState() => _UserRegistrationDialogState();
}

class _UserRegistrationDialogState extends State<UserRegistrationDialog> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Roles list
  final List<String> _roles = [
    'مدیر',
    'ناظر',
    'کاربر ساده',
  ];

  String? _selectedRole;

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _nicknameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect form data
      final registrationData = {
        'email': _emailController.text,
        'nickname': _nicknameController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'role': _selectedRole,
      };
 
 String id=Random().nextInt(9999).toString();

  if(widget.isEditing==false){
     
       Get.find<Boxes>().userbox.add(Users(
          id: id,
          username: registrationData['username'],
          password: registrationData['password'],
          accsesslvl: registrationData['role'],
          email: registrationData['email'],
          nickname: registrationData['nickname']));
          var body={
              "id":id,
          "username": registrationData['username'],
          "password": registrationData['password'],
          "accsesslvl": registrationData['role'],
          "email": registrationData['email'],
          "nickname": registrationData['nickname']

          };
      await pb.collection('users').create(body: body);
  }else{
         String tempemail=Get.find<Boxes>().userbox[widget.index!].email!;
    Get.find<Boxes>().userbox[widget.index!]=(Users(
          id: id,
          username: registrationData['username'],
          password: registrationData['password'],
          accsesslvl: registrationData['role'],
          email: registrationData['email'],
          nickname: registrationData['nickname']));

            var body={
            
          "username": registrationData['username'],
          "password": registrationData['password'],
          "accsesslvl": registrationData['role'],
          "email": registrationData['email'],
          "nickname": registrationData['nickname']

          };
          final record = await pb.collection('users').getFirstListItem(
  'email="${tempemail}"',
);
await pb.collection('users').update(record.id, body: body);

  }
 
      // Close the dialog
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing!) {
      _emailController.text =
          Get.find<Boxes>().userbox.toList()[widget.index!].email!;
      _nicknameController.text =
          Get.find<Boxes>().userbox.toList()[widget.index!].nickname!;
      _usernameController.text =
          Get.find<Boxes>().userbox.toList()[widget.index!].username!;
      _passwordController.text =
          Get.find<Boxes>().userbox.toList()[widget.index!].password!;
      _selectedRole =
          Get.find<Boxes>().userbox.toList()[widget.index!].accsesslvl!;
    }
    return AlertDialog(
      title: Text(widget.isEditing! ? "ویرایش" : 'ثبت نام'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email TextField
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'ایمیل',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // Basic email validation
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Nickname TextField
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: 'نام و نام خانوادگی',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a nickname';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Username TextField
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'نام کاربری',
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password TextField
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'رمز عبور',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Role Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.assignment_ind),
                  border: OutlineInputBorder(),
                ),
                value: _selectedRole,
                hint: const Text('نوع کاربری'),
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
                validator: (value) {
                  if (value == null) {
                    return 'نوع کاربری';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('انصراف'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('ثبت'),
        ),
      ],
    );
  }
  //TODO:EDIT??? MAYBE 
  //TODO:ARVAND EDIT>??????
}

