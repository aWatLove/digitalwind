import 'package:dw/shared/lib/JsonRepository/JsonRepository/json_repository.dart';
import 'package:dw/shared/lib/JsonRepository/json_serializable.dart';
import 'package:flutter/material.dart';

class UserPartial  extends JsonSerializable{
  final int id;
  UserPartial({required this.id});
  
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      'id':id
    };
  }
  factory UserPartial.fromJson(Map<String, dynamic> json){
    try{
        return UserPartial(id: json['id']);
    }catch(e){
        throw ErrorDescription("user json is invalid");
    }
  }

}
class TestsRepo extends JsonRepository<UserPartial> {
  @override
  UserPartial fromJson(Map<String, dynamic> json) {
    return  UserPartial.fromJson(json);
  }
  
}