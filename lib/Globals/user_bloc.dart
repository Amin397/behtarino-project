import 'dart:async';
import '../MainModel/api_result_model.dart';

class User {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;


  UserModel user = UserModel();

  void setKey(String? userKey, String? mobile,) {
    user.key = userKey;
    user.mobile = mobile;
    streamController.sink.add(user);
  }


  void setToken(String? token){
    user.token = token;
    streamController.sink.add(user);
  }

}