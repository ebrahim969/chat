import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  var auth = FirebaseAuth.instance;
  // Sign-in user with email and password
   Future<void> signInUser({required String email ,required String password}) async{
    emit(LoginLoading());
    try{
     await auth.signInWithEmailAndPassword(
        email: email, password: password);
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

   // register user with email and password
  Future registerUser({required String email,required String password}) async {
        emit(RegisterLoading());
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
        emit(RegisterSuccess());  
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        emit(RegisterFailure(errorMessage: "Please enter strong password"));
      } else if (e.code == "email-already-in-use") {
        emit(RegisterFailure(errorMessage: "This email is already in use"));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: "Something went wrong, please try again"));
    }
  }
}
