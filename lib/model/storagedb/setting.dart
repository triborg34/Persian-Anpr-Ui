

class Setting {
  
  double? plateConf;

  double? charConf;

  String? hardWare;


  
  String? timeZone;
  
  String? clockType;
  
  String? port;
  
  String? connect;
  
  bool? isRfid;
  
  bool? rl1;
  
  bool? rl2;
  
  String? rfidip;
  
  int? rfidport;
  
  bool? alarm;

  double? qualitySliderValue;

  Setting(
      {this.plateConf,
      this.charConf,
      this.hardWare,
       this.qualitySliderValue,
      this.timeZone,
      this.clockType,
      this.connect,this.port,this.isRfid,this.rfidip,this.rfidport,this.rl1,this.rl2,required this.alarm});

  Setting.fromJson(Map<String, dynamic> json) {
    plateConf = json['plateConf'];
    charConf = json['charConf'];
    hardWare = json['hardWare'];

    timeZone = json['timeZone'];
    clockType = json['clockType'];
    connect = json['connect'];
    port = json['port'];
    isRfid = json['isRfid'];
    rl1 = json['rl1'];
    rl2 = json['rl2'];
    rfidip = json['rfidip'];
    rfidport = json['rfidport'];
    alarm = json['alarm'];
    qualitySliderValue=json['quality'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plateConf'] = this.plateConf;
    data['charConf'] = this.charConf;
    data['hardWare'] = this.hardWare;

    data['timeZone'] = this.timeZone;
    data['clockType'] = this.clockType;
    data['connect'] = this.connect;
    data['port'] = this.port;
    data['isRfid'] = this.isRfid;
    data['rl1'] = this.rl1;
    data['rl2'] = this.rl2;
    data['rfidip'] = this.rfidip;
    data['rfidport'] = this.rfidport;
    data['alarm'] = this.alarm;
    data['quality']=this.qualitySliderValue;
    return data;
  }
}