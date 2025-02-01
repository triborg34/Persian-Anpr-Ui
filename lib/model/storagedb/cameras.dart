


class Cameras  {

    String? id;

    String? nameCamera;

    String? ip;

    String? gate;

    bool? status;

    String? username;

    String? password;

    String? licance;

    String? rtspname;

    bool? isNotrtsp;

    String? rtpath;

     Cameras(
      
      {required this.id,
      required this.nameCamera,
      required this.rtspname,required this.rtpath,
      required this.ip,required this.gate,required this.status,required this.username,required this.password,required this.isNotrtsp, this.licance});

  Cameras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCamera=json['nameCamera'];
    ip=json['ip'];
    gate=json['gate'];
    status=json['status'];
    username=json['username'];
    password=json['password'];
    rtspname=json['rtspname'];
    isNotrtsp=json['isNotrtsp'];
    rtpath=json['rtpath'];
    licance=json['licance'];
    

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameCamera'] = this.nameCamera;
    data['ip']=this.ip;
    data['gate']=this.gate;
    data['status']=this.status;
    data['username']=this.username;
    data['password']=this.password;
    data['rtspname']=this.rtspname;
    data['isNotrtsp']=this.isNotrtsp;
    data['rtpath']=this.rtpath;
    data['licance']=this.licance;
    

    return data;
  }


}