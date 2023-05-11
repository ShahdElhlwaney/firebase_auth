

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/controller/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(loginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);


  void logIn({required String emailAddress,required String password})async{
    emit(loginLoadig());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      emit(loginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(loginError(e.code));
      } else if (e.code == 'wrong-password') {
        emit(loginError(e.code));
        print('Wrong password provided for that user.');
      }
    }
  }



}