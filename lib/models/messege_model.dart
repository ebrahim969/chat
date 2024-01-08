import 'package:chat_app/constants.dart';

class Messege {
  final String messege;
  final String id;

  Messege(this.messege, this.id);
  
  factory Messege.fromJson(jsonData){
     return Messege(jsonData[kMessegeModel], jsonData['id']);
  }
}