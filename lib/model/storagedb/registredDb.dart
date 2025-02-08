class RegistredDb {
  String? id;
  String? plateNumber;

  String? plateImagePath;

  String? name;

  String? carName;

  String? eDate;

  String? eTime;

  bool? status;

  String? screenImg;

  String? role;

  String? socialNumber;

  String? isarvand;

  String? rtpath;

  RegistredDb(
      {required this.plateNumber,
      required this.plateImagePath,
      this.name = '-',
      this.carName = '-',
      required this.eDate,
      required this.eTime,
      this.status = false,
      required this.screenImg,
      required this.role,
      required this.socialNumber,
      required this.isarvand,
      required this.rtpath,this.id});

  RegistredDb.fromJson(Map<String, dynamic> json) {
    plateNumber = json['plateNumber'];
    plateImagePath = json['plateImagePath'];
    name = json['name'];
    carName = json['carName'];
    eDate = json['eDate'];
    eTime = json['eTime'];
    status = json['status'];
    screenImg = json['screenImg'];
    role = json['role'];
    isarvand=json['isarvand'];
    socialNumber = json['socialNumber'];
    id=json['id'];
    rtpath=json['rtpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plateNumber'] = this.plateNumber;
    data['plateImagePath'] = this.plateImagePath;
    data['name'] = this.name;
    data['carName'] = this.carName;
    data['eDate'] = this.eDate;
    data['eTime'] = this.eTime;
    data['status'] = this.status;
    data['screenImg'] = this.screenImg;
    data['role'] = this.role;
    data['socialNumber'] = this.socialNumber;
    data['id']=this.id;
    data['isarvand']=this.isarvand;
    data['rtpath']=this.rtpath;
    return data;
  }
}
