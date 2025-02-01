class plateModel {
  double? charPercent;
  String? eDate;
  String? eTime;
  String? plateNum;
  double? platePercent;
  String? status;
  String? imgpath;
  String? scrnPath;
  String? isarvand;
  String? rtpath;

  plateModel(
      {this.charPercent,
      this.eDate,
      this.eTime,
      this.plateNum,
      this.platePercent,
      this.status,this.imgpath,this.scrnPath,this.isarvand,this.rtpath});

  plateModel.fromJson(Map<String, dynamic> json) {
    charPercent = json['charPercent'];
    eDate = json['eDate'];
    eTime = json['eTime'];
    plateNum = json['plateNum'];
    platePercent = json['platePercent'];
    status = json['status'];
    imgpath = json['imgpath'];
    scrnPath = json['scrnPath'];
    isarvand=json['isarvand'];
    rtpath=json['rtpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charPercent'] = this.charPercent;
    data['eDate'] = this.eDate;
    data['eTime'] = this.eTime;
    data['plateNum'] = this.plateNum;
    data['platePercent'] = this.platePercent;
    data['status'] = this.status;
    data['imgpath'] = this.imgpath;
    data['scrnPath'] = this.scrnPath;
    data['isarvand']=this.isarvand;
    data['rtpath']=this.rtpath;
    return data;
  }
}