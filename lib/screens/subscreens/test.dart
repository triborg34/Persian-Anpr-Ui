import 'package:flutter/material.dart';
import 'package:unapwebv/model/model.dart';
import 'package:unapwebv/model/storagedb/db.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

 late DatabaseHelper _databaseHelper;
  @override
  void initState() {
    _databaseHelper=DatabaseHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<plateModel>>(
  stream: _databaseHelper.entryStream,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final plates = snapshot.data!;
    return ListView.builder(
      itemCount: plates.length,
      itemBuilder: (context, index) {
        final plate = plates[index];
        print(plate.charPercent);
        print(plate.eDate);
        print(plate.imgpath);
        return Column(
            children: [
              Text(plate.charPercent.toString())
              ,
              
            ],
        );
      },
    );
  },
)
,
    );
  }
}