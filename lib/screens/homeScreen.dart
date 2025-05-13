import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unapwebv/controller/mianController.dart';
import 'package:unapwebv/model/consts.dart';


import 'package:unapwebv/widgets/dbContant.dart';
import 'package:unapwebv/widgets/extendetTableData.dart';
import 'package:unapwebv/widgets/memryguard.dart';
import 'package:unapwebv/widgets/newvideogetter.dart';
import 'package:unapwebv/widgets/tableTitle.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int gridselector = 0;

  int selectedVideo=1;



  String port=Get.find<Boxes>().settingbox.last.port!;
  Future<void> _updateGridSelector(int newValue) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      gridselector = newValue;
    });
    await prefs.setInt('gridselector', newValue);
  }


  @override
  void initState() {
        _loadGridSelector();
    super.initState();
  }

    Future<void> _loadGridSelector() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      gridselector = prefs.getInt('gridselector') ?? 0;
    });
  }


  @override
  Widget build(BuildContext context) {
     Get.find<Boxes>().getregData();
          Get.find<Boxes>().getSetting();
    return KeyboardListener(
      focusNode: FocusNode(),

      autofocus: true,
      onKeyEvent: (event) {
        print(event.logicalKey);
                  if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            onRelayOne();
          }
      },
      child: Container(
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
                        MemoryGuard(),
                        
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _updateGridSelector(0);
                                    },
                                  );
                                },
                                icon: Icon(Icons.rectangle_outlined)),
                                                       IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                       _updateGridSelector(4);
                                    },
                                  );
                                },
                                
                                
                                icon: Icon(Icons.grid_goldenratio_sharp)),
                            IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                       _updateGridSelector(1);
                                    },
                                  );
                                },
                                
                                
                                icon: Icon(Icons.grid_view)),
           
                                
                            IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _updateGridSelector(2);
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
      ),
    );
  }

  Widget VidGridBuild(int index, context) {
    if (index == 0) {

      return VideoStream(
        url: "http://${pathurl}:${port}/video_feed/rt${selectedVideo}",
      );
    } else if (index == 1) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: 350,
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
                  url: "http://${pathurl}:${port}/video_feed/rt${i}",
                )),
              )
          ],
        ),
      );
    }else if(index == 4){
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: 350,
        child: Wrap(
          children: [
            for (int i = 1; i <= 2; i++)
              Container(
                width: ((MediaQuery.sizeOf(context).width * 0.5) / 2) - 10,
                height: 350 ,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    selectedVideo=i;
                  },
                    child: VideoStream(
                  url: "http://${pathurl}:${port}/video_feed/rt${i}",
                )),
              )
          ],
        ),
      );
    } 
    else {
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
                  url: "http://${pathurl}:${port}/video_feed/rt${i}",
                ),
              )
          ],
        ),
      );
    }
  }
}
