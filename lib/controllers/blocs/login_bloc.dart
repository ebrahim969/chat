import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if(event is LoginButtonEvent)
      {
       var auth = FirebaseAuth.instance;

       emit(LoginLoading());
    try{
     await auth.signInWithEmailAndPassword(
        email: event.email, password: event.password);
        emit(LoginSuccess());
        }on FirebaseAuthException catch(e){
     if(e.code == "user-not-found"){
      emit(LoginFailure(errorMessage: "User not found"));
      // Get.snackbar("Opss!", "User not found", borderColor: kButtonColor);
     }
     else if(e.code == "wrong-password"){
      emit(LoginFailure(errorMessage: "Wrong password"));
      // Get.snackbar("Wrong", "Your password is wrong",borderColor: Colors.red );
      }
     }catch (e){
         emit(LoginFailure(errorMessage: "Something went wrong, please try again"));
        }
      }
    });
  }
}
