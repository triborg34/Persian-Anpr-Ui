import 'package:flutter/material.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/widgets/extntedtable.dart';


class ExtendetTableData extends StatelessWidget {
  const ExtendetTableData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: purpule),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          header(),
          contant()
        ],
      ),
    );
  }
}
