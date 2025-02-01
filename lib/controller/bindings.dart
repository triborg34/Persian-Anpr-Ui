import 'package:get/get.dart';
import 'package:unapwebv/controller/mianController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(videoController());
    Get.put(tableController());
    Get.lazyPut(()=>feildController());
    Get.put(Boxes());
    Get.put(ReportController());
    Get.put(navController());
    Get.put( settingController(),);
    Get.put(ViedoSocket());

  }

}