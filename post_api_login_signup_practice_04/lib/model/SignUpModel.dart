/// id : 4
/// token : "QpwL5tke4Pnpja7X4"

class SignUpModel {
  SignUpModel({
      num? id, 
      String? token,}){
    _id = id;
    _token = token;
}

  SignUpModel.fromJson(dynamic json) {
    _id = json['id'];
    _token = json['token'];
  }
  num? _id;
  String? _token;
SignUpModel copyWith({  num? id,
  String? token,
}) => SignUpModel(  id: id ?? _id,
  token: token ?? _token,
);
  num? get id => _id;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['token'] = _token;
    return map;
  }

}