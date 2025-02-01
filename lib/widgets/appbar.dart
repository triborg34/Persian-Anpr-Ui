import 'package:flutter/material.dart';

import 'package:unapwebv/model/consts.dart';

AppBar MyAppBar() {
  return AppBar(
    foregroundColor: Colors.white,
    centerTitle: true,
    title: Image.network('assets/images/mainlogo.png',width: 200,),
    backgroundColor: purpule,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "تشخیص خودکار پلاک امن آفرین",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
