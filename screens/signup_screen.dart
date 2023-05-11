import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_app/controller/signup_cubit.dart';
import 'package:tasks_app/controller/signup_states.dart';
import 'package:tasks_app/screens/login_screen.dart';
import '../components/image_component.dart';
import '../controller/image_cubit.dart';
import '../controller/password_visibility_cubit.dart';
import '../core/utils/app_color.dart';
import '../core/utils/app_routes.dart';
import '../functions/show_toast_function.dart';



class SignUpScreen extends StatelessWidget {
  ImagePicker picker = ImagePicker();

  XFile? image;

  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  // bool _passwordVisible=true;

  var imageFile;
  
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
    listener: (context, state) {
      if(state is signUpSuccess){

        showToast(message:'your acount is created successefuly go to Login Page',color:AppColor.greenColor  );
      }
      else if(state is signUpError){
        showToast(message: state.error, color: AppColor.redColor);

      }
    },
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top:10,left: 20,right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<ImageCubit, XFile?>(
              builder: (context, state) {
                if(state !=null){
                   imageFile=File(state.path);
                }
                   return ImageComponent(widget: state==null
                      ?Icon(Icons.perm_identity,size: 65,color: AppColor.whiteColor,)
                       :ClipRRect(borderRadius:BorderRadius.all(Radius.circular(80)),child: Image.file(File(state.path))
                       ), height: 90, width: 90);

    },
),
                ),
                 Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Row(
                                children: [
                                  Icon(Icons.camera_alt_outlined),
                                  SizedBox(width: 5,),
                                  Column(
                                    children: const [
                                      Text('Add Image'),
                                      Text('from Camera'),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.read<ImageCubit>().selectImage();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.image),
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        Text('Add Image'),
                                        Text('from Gallery')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],),
              SizedBox(height: 15,),
                 Text( 'Sign Up',style: TextStyle(
                   color: Colors.black,
                   fontSize: 30,
                   fontWeight: FontWeight.bold,
                 ),
                   ),
                 SizedBox(height: 8,),
                 const Text(
                    'Enter your credentials to continue',style: TextStyle(
                   fontSize: 20,color: AppColor.greyColor
                 ),
                   ),
                    SizedBox(height: 18,),
                    SizedBox(height: 15,),
                    const Text( 'Email',style: TextStyle(
                      color: AppColor.greyColor,  fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                 TextFormField(
                   controller: emailController,
                   onChanged: (value) {},
                   validator: (value) {
                     if (value == null) {
                       return "* Required";
                     }
                     else if (!value.contains('@')) {
                       return "email should have '@'";
                     }
                   },
                   decoration: const InputDecoration(
                       hintText: 'email',
                       contentPadding: EdgeInsets.symmetric(
                           vertical: 35)
                   ),
                   style: const TextStyle(
                       color: Colors.black, fontSize: 20),),
                    SizedBox(height: 15,),
                    const Text( 'Password',style: TextStyle(
                      color: AppColor.greyColor,  fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                 BlocBuilder<PasswordVesibilityCubit,bool>(
                    builder: (context, _passwordVisible) {
                   return TextFormField(
                              controller: passwordController,
                              onChanged: (pass) {},
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return "* Required";
                                } else if (data.length < 6) {
                                  return "Password should be atleast 6 characters";
                                } else if (data.length > 15) {
                                  return "Password should not be greater than 15 characters";
                                } else
                                  return null;
                              },
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                        onTap: (){
                                          context.read<PasswordVesibilityCubit>().changeVisibility();
                                        },
                                    child: Icon(
                                        _passwordVisible ? Icons.visibility : Icons
                                            .visibility_off)
                                  ),
                                  hintText: ' Password',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 35)
                              ),
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            );
                 },
),
                 SizedBox(height: 10,),
                 Column(children: [
                   Row(children: [
                     Text(
                        'By continuing you agree to our',style: TextStyle(
                         fontSize: 13
                     ),
                       ),
                     Text( 'Terms of Service',style: TextStyle(
                         color: Theme.of(context).primaryColor,
                         fontSize: 13
                     ),
                       ),
                   ],
                   ),
                   Row(children: [
                     Text('and',),
                     Text( 'privacy policy',style: TextStyle(
                       color: Theme.of(context).primaryColor
                     ),
                      )
                   ],)
                 ],),
               SizedBox(height: 20,),
               GestureDetector(
               onTap:(){
                 if (formKey.currentState!.validate()) {
                   SignUpCubit.get(context).signUp(
                       emailAddress: emailController.text
                       , password: passwordController.text);
                 }
               } ,
               child: Container(
                   width: 364,
                   height: 67,
                   alignment: Alignment.center,
                   child: Text('Sing Up',style: TextStyle(color: Colors.white,fontSize: 20),),
                   decoration:BoxDecoration(
                       color: Theme.of(context).primaryColor,
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),
                           bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                   )
               ),
               ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                   Text('Already have an account? ',style: TextStyle(
                     color: Colors.black,
                     fontSize: 17,
                   ),
                     ),
                   TextButton(
                     onPressed: ()async{
                       Navigator.pushNamed(context, AppRoutes.loginScreen
                           ,arguments: imageFile);
                     },

                     child: Text( 'Login',style: TextStyle(
                       color: Theme.of(context).primaryColor,
                       fontSize: 17,
                     ),
                     ),
                   )
                 ]
                 ),
               ]
               ),
            ),
          ),
        )
      );
    },
);
  }
}
