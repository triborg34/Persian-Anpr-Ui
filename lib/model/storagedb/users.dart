



class Users  {

  String? id;

  String? username;

  String? password;

  String? accsesslvl;

  String? email;

  String? nickname;



  Users(
      {required this.id,
      required this.username,
      required this.password,required this.accsesslvl,required this.email,required this.nickname});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    accsesslvl = json['accsesslvl'];
    email=json['email'];
    nickname=json['nickname'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['accsesslvl'] = this.accsesslvl;
    data['email']=this.email;
    data['nickname']=this.nickname;

    return data;
  }
}
