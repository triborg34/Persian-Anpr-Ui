import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>videoController());
    Get.put(tableController());
    Get.lazyPut(()=>feildController());
    Get.lazyPut(()=>Boxes());
    Get.lazyPut(()=>ReportController());
    Get.lazyPut(()=>navController());
    Get.lazyPut(()=>settingController(),);
    Get.lazyPut(()=>ViedoSocket());

  }

}