// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../constants.dart';
import '../../../models/messege_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messeges =
      FirebaseFirestore.instance.collection(kMessegeCollection);
      List<Messege> messageList = [];
  void sendMessege({required String messege, required String email}) {
    try {
  messeges.add({
    kMessegeModel: messege,
    kCreatedAt: DateTime.now(),
    'id': email,
  });
} on Exception catch (e) {

}
  }

  void getMessege()
  {
    messeges.orderBy(kCreatedAt, descending: true).snapshots().listen((event) { 
       messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Messege.fromJson(doc));
      }
      emit(ChatSuccess(messageList:messageList ));
    });
  }
}
