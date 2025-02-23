import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';


import 'package:unapwebv/widgets/dbContant.dart';
import 'package:unapwebv/widgets/extendetTableData.dart';
import 'package:unapwebv/widgets/newvideogetter.dart';
import 'package:unapwebv/widgets/tableTitle.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  
  });


  int gridselector = 0;
  int selectedVideo=1;
  String port=Get.find<Boxes>().settingbox.last.port!;
  

  @override
  Widget build(BuildContext context) {
     Get.find<Boxes>().getregData();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  TableTitle(),
                  DbContant()
                ],
              )),
              // VideoRtsp(context),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      VidGridBuild(gridselector, context),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    gridselector = 0;
                                  },
                                );
                              },
                              icon: Icon(Icons.rectangle_outlined)),
                          IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    gridselector = 1;
                                  },
                                );
                              },
                              icon: Icon(Icons.grid_view)),
                          IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    gridselector = 2;
                                  },
                                );
                              },
                              icon: Icon(Icons.grid_on))
                        ],
                      )
                    ],
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ExtendetTableData(),
          SizedBox(
            height: 20,
          ),
          
        ],
      ),
    );
  }

  Widget VidGridBuild(int index, context) {
    if (index == 0) {
      return VideoStream(
        url: "ws://${pathurl}:${port}/rt${selectedVideo}",
      );
    } else if (index == 1) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: 40.h,
        child: Wrap(
          children: [
            for (int i = 1; i <= 4; i++)
              Container(
                width: ((MediaQuery.sizeOf(context).width * 0.5) / 2) - 10,
                height: 350 * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    selectedVideo=i;
                  },
                    child: VideoStream(
                  url: "ws://${pathurl}:${port}/rt${i}",
                )),
              )
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: 350,
        child: Wrap(
          children: [
            for (int i = 1; i <= 9; i++)
              Container(
                width: ((MediaQuery.sizeOf(context).width * 0.5) / 3) - 10,
                height: 350 / 3,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                color: Colors.transparent,
                child: VideoStream(
                  url: "ws://${pathurl}:${port}/rt${i}",
                ),
              )
          ],
        ),
      );
    }
  }
}
