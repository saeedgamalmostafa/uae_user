import 'dart:convert';
AddToCartModel addToCartModelFromJson(String str) => AddToCartModel.fromJson(json.decode(str));
String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());
class AddToCartModel {
  AddToCartModel({
      int? status, 
      String? message, 
      List<dynamic>? account,}){
    _status = status;
    _message = message;
    _account = account;
}

  AddToCartModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    // if (json['Account'] != null) {
    //   _account = [];
    //   json['Account'].forEach((v) {
    //     _account?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int? _status;
  String? _message;
  List<dynamic>? _account;

  int get status => _status ?? 0;
  String get message => _message ?? '';
  List<dynamic> get account => _account ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_account != null) {
      map['Account'] = _account?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}