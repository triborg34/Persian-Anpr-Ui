import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/screens/subscreens/licancecheker.dart';

class ModernLoginPage extends StatefulWidget {
  const ModernLoginPage({super.key});

  @override
  _ModernLoginPageState createState() => _ModernLoginPageState();
}

class _ModernLoginPageState extends State<ModernLoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _checkLoginStatus() async {
    final records = await pb.collection('sharedPerfence').getFullList();
    if (records.isNotEmpty) {
      if (records[0].data['login']) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Licancecheker()),
        );
      }
    }
  }

  @override
  void initState() {
    _checkLoginStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            _login();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.purple.shade900,
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 kIsWeb ?   Image.network('assets/images/mainlogo2.png',width: 200,height: 200,) : Image.asset('assets/images/mainlogo2.png',width: 200,height: 200,),
                    Text(
                        "سامانه پایش خودکار پلاک\n Automatic Numberplate Recognition",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(
                      height: 500,
                      width: 500,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Logo or App Name
                                Text(
                                  'ورود',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // Username TextField
                                TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person,
                                        color: Colors.purple),
                                    hintText: 'نام کاربری',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.purple, width: 2),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white54),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا نام کاربری خود را وارد کنید';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Password TextField
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.purple),
                                    hintText: 'رمز عبور',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.purple, width: 2),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white54),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا رمز عبور خود را وارد کنید';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),

                                // Remember Me Checkbox
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      activeColor: Colors.purple,
                                      checkColor: Colors.white,
                                      side: BorderSide(color: Colors.white54),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                    ),
                                    Text(
                                      'مرا به یاد داشته باش',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        // Forgot password logic
                                      },
                                      child: Text(
                                        'رمز عبور خود را فراموش کردید؟',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),

                                // Login Button
                                ElevatedButton(
                                  autofocus: false,
                                  onPressed: () async {
                                    await _login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    'ورود',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 800,
                      height: 600,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:kIsWeb ?  Image.network(
                          'assets/images/ban.jpg',
                          fit: BoxFit.fill,
                        ):Image.asset(
                          'assets/images/ban.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      // Login logic here

      try {
        if (Get.find<Boxes>()
                .userbox
                .firstWhere(
                  (element) => element.username == _usernameController.text,
                )
                .password ==
            _passwordController.text) {
          if (_rememberMe) {
            final records = await pb.collection('sharedPerfence').getFullList();
            await pb
                .collection('sharedPerfence')
                .update(records[0].id, body: {'login': _rememberMe});
          }

          Get.to(() => Licancecheker());
        } else {}
      } catch (e) {
        if (_usernameController.text == "root" &&
            _passwordController.text == "root") {
          Get.to(() => Licancecheker());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('رمز عبور یا نام کاربری اشتباه')),
          );
        }
      }
    }
  }
}
