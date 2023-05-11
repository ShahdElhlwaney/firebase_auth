

//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/controller/login_states.dart';
import 'package:tasks_app/controller/password_visibility_cubit.dart';
import 'package:tasks_app/core/utils/app_color.dart';
import 'package:tasks_app/functions/show_toast_function.dart';
import 'package:tasks_app/screens/signup_screen.dart';
import 'package:tasks_app/screens/tasks_screen.dart';
import '../controller/login_cubit.dart';
import '../core/utils/app_routes.dart';
class LoginScreen extends StatelessWidget {
   TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var image = ModalRoute.of(context)!.settings.arguments as File ;

    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginStates>(
  listener: (context, state) {
    if(state is loginSuccess){//
      showToast(message: 'Logged in successfully', color: AppColor.greenColor);
     Navigator.push(context, MaterialPageRoute(builder: (context)=>TasksScreen(image: image,)));
  }
    else if(state is loginError){
      showToast(message: state.error, color: AppColor.redColor);
    }
    },
  builder: (context, state) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70,left: 20,right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
    Text( 'Loging',style: TextStyle(
      color: Colors.black,  fontSize: 30,
      fontWeight: FontWeight.bold,

    ),),
    SizedBox(height: 10,),
    Text( 'Enter your emails and password',style: TextStyle(
    color: AppColor.greyColor,  fontSize: 20,
    fontWeight: FontWeight.bold,

    )),
    SizedBox(height: 35,),
                Text( 'Email',style: TextStyle(
                  color: AppColor.greyColor,  fontSize: 20,
                  fontWeight: FontWeight.bold,

                )),
    TextFormField(
      //key: formKey,
    controller: emailController,
    onChanged: (value) {
    },
    validator: (value) {
    if (value!.isEmpty ) {
    return "* required";
    }
    },
    decoration: const InputDecoration(
    hintText: 'email',

    contentPadding: EdgeInsets.symmetric(
    vertical: 35)
    ),
    style: TextStyle(
    color: AppColor.greyColor, fontSize: 20),
    ),
    SizedBox(height: 20,),
      Text( 'Password',style: TextStyle(
        color: AppColor.greyColor,  fontSize: 20,
       fontWeight: FontWeight.bold,

                )),
    BlocProvider(
  create: (context) => PasswordVesibilityCubit(),
  child: BlocBuilder<PasswordVesibilityCubit, bool>(
  builder: (context, _passwordVisible) {
    return TextFormField(
    controller: passwordController,
    onChanged: (value) {},
    validator: (data) {
    if (data!.isEmpty) {
    return "* Required";
    }
    },
    obscureText: !_passwordVisible,
    decoration: InputDecoration(
    suffixIcon: IconButton(onPressed: () {

       context.read<PasswordVesibilityCubit>().changeVisibility();

    }, icon: Icon(_passwordVisible
    ? Icons.visibility
              : Icons.visibility_off)),
    hintText: ' Password',
    contentPadding: EdgeInsets.symmetric(
    vertical: 35)
    ),
    style: TextStyle(
    color: Colors.black, fontSize: 20));
  },
),
),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
              Text( 'Forgot Password?',style: TextStyle(

              ),),
        SizedBox(width: 15,)
      ]),
                SizedBox(height: 30,),

                GestureDetector(
                  onTap:(){
                    if(formKey.currentState!.validate()){
                      LoginCubit.get(context).logIn(emailAddress: emailController.text
                          , password: passwordController.text);
                    }
                  } ,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 364,
                        height: 67,
                        alignment: Alignment.center,
                        child: Text('login',style: TextStyle(color: Colors.white,fontSize: 20),),
                        decoration:BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        )
                    ),
                  ),
                ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
    Text( ' Don’t have an account?',style: TextStyle(
              fontSize: 17 ,   color: Colors.black,

    ),
    ),
    TextButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
    },
    child: Text( ' Singup',style: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 17,

    ),
    )
    )
    ]
    ),
   ] ),
            ),
          ),
        ));
  },
),
);
  }
}
