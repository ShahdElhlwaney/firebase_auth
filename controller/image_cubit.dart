

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageCubit extends Cubit<XFile?>{
  ImageCubit():super(null);
  ImageCubit get(context)=>BlocProvider.of(context);
  final imagePicer=ImagePicker();


  Future<void>selectImage()async{
    final pickedFile=await imagePicer.pickImage(source: ImageSource.gallery);
    emit(pickedFile);



  }

}