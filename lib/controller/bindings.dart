import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    if(kIsWeb ){
    Get.lazyPut(()=>videoController());
    Get.put(tableController());
    Get.lazyPut(()=>feildController());
    Get.lazyPut(()=>Boxes());
    Get.put(ReportController());
    Get.lazyPut(()=>navController());
    Get.lazyPut(()=>settingController(),);
    Get.lazyPut(()=>ViedoSocket());
    }else{
          Get.put(videoController());
    Get.put(tableController());
    Get.put(feildController());
    Get.put(Boxes());
    Get.put(ReportController());
    Get.put(navController());
    Get.put(settingController(),);
    Get.put(ViedoSocket());
    }
  }

}