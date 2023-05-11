


import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVesibilityCubit extends Cubit<bool>{
  PasswordVesibilityCubit():super(true);

  PasswordVesibilityCubit get(context)=>BlocProvider.of(context);
  void changeVisibility(){
    emit(!state);
  }
}