

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tasks_app/controller/signup_states.dart';


class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit():super(signUpInitial());
  static SignUpCubit get(context)=>BlocProvider.of(context);

void signUp({required String emailAddress,required String password})async{
  emit(signUpLoading());
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    print('success');
   // print(credential.user!.email);
     emit(signUpSuccess());
  } on FirebaseAuthException catch (e) {
    print('object');

    if (e.code == 'weak-password') {
      emit(signUpError(error:e.code));
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      emit(signUpError(error:e.code));

      print('The account already exists for that email.');
    }
  } catch (e) {
    emit(signUpError(error:e.toString()));
    //print('object');

    print(e);
  }
}



}