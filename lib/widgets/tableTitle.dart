import 'package:flutter/material.dart';

import 'package:unapwebv/model/consts.dart';

class TableTitle extends StatelessWidget {
  const TableTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: purpule),
        margin:
            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 50,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                "شماره پلاک",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
            ),
            Text(
              "عکس پلاک",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            VerticalDivider(
              color: Colors.black,
            ),
            Text(
              "ثبت خودرو",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )
            ,
                        VerticalDivider(
              color: Colors.black,
            ),
            Text(
              "جهت دوربین",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )
          ],
        ));
  }
}
