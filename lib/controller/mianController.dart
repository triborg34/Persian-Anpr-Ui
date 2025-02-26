
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:unapwebv/model/model.dart';
import 'package:unapwebv/model/storagedb/cameras.dart';
import 'package:unapwebv/model/storagedb/registredDb.dart';
import 'package:unapwebv/model/storagedb/setting.dart';
import 'package:unapwebv/model/storagedb/users.dart';
import 'package:unapwebv/widgets/videogetter.dart';

import '../model/consts.dart';

class videoController extends GetxController {
  late final WebSocket soccket;
  bool isconnected = false;

  void connect(String url) {
    soccket = WebSocket(url);
    soccket.connect();
  }

  @override
  void onReady() {
    super.onReady();
  }
}

class tableController extends GetxController {
  var selectedIndex = -1;
  plateModel selectedmodel = plateModel();
}

class feildController extends GetxController {
  var carName = TextEditingController();
  var name = TextEditingController();
  var Fname = TextEditingController();
  TextEditingController socialNumber = TextEditingController();
  var role;
}

class Boxes extends GetxController {
  var nol = 1.obs;

  //

  List<RegistredDb> regBox = <RegistredDb>[];
  //
  List<Users> userbox = <Users>[];

  //
  List<Cameras> camerabox = <Cameras>[];

  //
  List<Setting> settingbox = <Setting>[];

  void getUsers() async {
    final resultList = await pb.collection('users').getFullList();
    userbox =
        resultList.map((item) => Users.fromJson(item.toJson())).toList();
  }

  void getregData() async {
    final resultList = await pb.collection('registredDb').getFullList();
    regBox = resultList
        .map((item) => RegistredDb.fromJson(item.toJson()))
        .toList();
  }

  void getCamera() async {
    final resultList = await pb.collection('cameras').getFullList();
    camerabox = resultList
        .map((item) => Cameras.fromJson(item.toJson()))
        .toList();
  }

  void getSetting() async {
    final resultList = await pb.collection('setting').getFullList();
    settingbox = resultList
        .map((item) => Setting.fromJson(item.toJson()))
        .toList();

    if (settingbox.isEmpty) {
      var body = {
        "charConf": 0.75,
        "clockType": '24',
        "plateConf": 0.8,
        "hardWare": 'cuda',
        "timeZone": 'Asia/Tehran',
        "connect": '9993',
        "isRfid": false,
        "port": '9992',
        "rl1": false,
        "rl2": false,
        "rfidip": '192.168.1.91',
        "rfidport": '2000',
        "alarm": false
        ,"quality":10.0
      };

      await pb.collection('setting').create(body: body);
      final resultList = await pb.collection('setting').getFullList();
      settingbox = resultList
          .map((item) => Setting.fromJson(item.toJson()))
          .toList();
    }
  }

  @override
  void onReady() {
    // getregData();
  getUsers();
 getSetting();
getregData();
  getCamera();
    super.onReady();
  }
}

class ReportController extends GetxController {
  List<plateModel> pModel = <plateModel>[];
  List<plateModel> selectedModel = <plateModel>[];
  String? selectedItem;
  String? firstdate;
  String? lastdate;
  String? firstime;
  String? lastTime;
  String? engishalphabet;
  var persianalhpabet = ''.obs;
  TextEditingController firtTwodigits = TextEditingController();
  TextEditingController threedigits = TextEditingController();
  TextEditingController lastTwoDigits = TextEditingController();
  String? platePicker;
  String? savePath;
  @override

  
  @override
  void onReady() async {
    await getData();
    super.onReady();
  }
  

  getData() async {
    pModel.clear();
    // Fetch 100 records per request
    // ignore: unused_local_variable

    final resultList = await pb.collection('database').getFullList(batch: 100);

    pModel = resultList
        .map((item) => plateModel.fromJson(item.toJson()))
        .toList();

    // await databaseHelper.getEntriesAsList().then((value) {
    //   for (var json in value) {
    //     pModel.add(plateModel(
    //         imgpath: json.imgpath,
    //         plateNum: json.plateNum,
    //         charPercent: json.charPercent,
    //         eDate: json.eDate,
    //         eTime: json.eTime,
    //         isarvand: json.isarvand,
    //         rtpath: json.rtpath,
    //         scrnPath: json.scrnPath,
    //         platePercent: json.platePercent,
    //         status: json.status));
    //   }
    // });
  }
}

class navController extends GetxController {
  int navIndex = 3;
  Widget? body;
}

class settingController extends GetxController {
  var psliderValue = 0.8.obs;
  var csliderValue = 0.75.obs;
  var qualitySladierValue=10.0.obs;
  var hardWareValue = 'cuda';
  var pathOfdb = '../../../../engine/database/entrieses.db'.obs;
  var pathOfOutput = '../engine/'.obs;
  var clockType = '24';
  String timezoneseleted = "Asia/Tehran";
  String port = 9992.toString();
  String connect = 9993.toString();
  var isRfid = false.obs;
  var rl1 = false.obs;
  var rl2 = false.obs;
  String rfidip = '192.168.1.91';
  int rfidport = 2000;
  var alarm = false.obs;

  @override
  void onReady() async {
    if (Get.find<Boxes>().settingbox.isEmpty) {
      Get.find<Boxes>().settingbox.add(Setting(
          charConf: csliderValue.value,
          clockType: clockType,
          qualitySliderValue: qualitySladierValue.value,
          plateConf: psliderValue.value,
          hardWare: hardWareValue,
          timeZone: timezoneseleted,
          connect: connect,
          isRfid: isRfid.value,
          port: port,
          rl1: rl1.value,
          rl2: rl2.value,
          rfidip: rfidip,
          rfidport: rfidport,
          alarm: alarm.value));

      // var body={
      //     "charConf": csliderValue.value,
      //   "clockType": clockType,
      //   "plateConf": psliderValue.value,
      //   "dbPath": pathOfdb.value,
      //   "outPutPath": pathOfOutput.value,
      //   "hardWare": hardWareValue,
      //   "timeZone": timezoneseleted,
      //   "connect": connect,
      //   "isRfid": isRfid.value,
      //   "port": port,
      //   "rl1": rl1.value,
      //   "rl2": rl2.value,
      //   "rfidip": rfidip,
      //   "rfidport": rfidport,
      //   "alarm": alarm.value

      // };
      //   await pb.collection('setting').create(body: body);
    } else {}
    super.onReady();
  }
}

class ViedoSocket extends GetxController {
  late final WebSocket socket;
  bool isConnected = false;

  void connect(BuildContext context, String url) async {
    socket = WebSocket(url);

    socket.connect();
    isConnected = true;
    update();
  }

  void disconnect() {
    socket.disconnect();

    isConnected = false;
    update();
  }
}
