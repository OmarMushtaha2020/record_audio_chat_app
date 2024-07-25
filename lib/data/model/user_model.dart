class UserModel{
  String? name;
  String ?email;
  String ?phoneNumber;
  String ? userUid;
  String ? token;

  UserModel({this.name,this.email,this.phoneNumber,this.userUid,this.token});
  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phoneNumber=json['phoneNumber'];
    userUid=json['userUid'];
    token=json['token'];
  }
  Map<String,dynamic >toMap(){
   return{
     "name":name,
     "email": email,
     "phoneNumber":phoneNumber,
     "userUid":userUid,
     "token":token,
   };
  }

}