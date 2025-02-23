import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:unapwebv/model/consts.dart';

class TableTitle extends StatelessWidget {
  const TableTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
        decoration: BoxDecoration(color: purpule),
        margin:
            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 50,
        child: Row(
          textDirection: TextDirection.rtl,
          
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Container(
                width: 10.w,
                child: Center(
                  child: Text(
                    "شماره پلاک",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
            ),
            Container(
                  width: 10.w,
              
              child: Center(
                child: Text(
                  "عکس پلاک",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
            ),
            Container(
                  width: 8.5.w,
              child: Center(
                child: Text(
                  "ثبت خودرو",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
            ,
                        VerticalDivider(
              color: Colors.black,
            ),
            Container(
                  width: 10.w,
              child: Text(
                "جهت دوربین",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ));
  }
}
