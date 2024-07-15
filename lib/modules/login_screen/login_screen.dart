import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:record_audio_chat_app/modules/register_screen/register_screen.dart';
import 'package:record_audio_chat_app/shared/app_cubit/login_cubit/login_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/app_cubit/login_cubit/login_screen_states.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_container_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_size_box_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_text_form_field_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_text_widget.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  // Initialize the form key once
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginScreenStates>(
        listener: (context, state) {
          // Handle state changes if necessary
        },
        builder: (context, state) {
          // Move cubit access inside builder
          var cubit = LoginScreenCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Text
                          CommonTextWidget(
                            title: 'Login',
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          // Vertical Spacer
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          // Subtitle Text
                          CommonTextWidget(
                            title: 'Login now to communicate with your friends',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          // Vertical Spacer
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          // Email Field
                          CommonTextFormFieldWidget(
                            validator: validator("Email Address"),
                            labelText: "Email Address",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          // Vertical Spacer
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          // Password Field
                          CommonTextFormFieldWidget(
                            labelText: "Password",
                            validator: validator("Password"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          // Vertical Spacer
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          // Login Button or Loading Indicator
                          state is LoginLoad
                              ? Center(child: CircularProgressIndicator())
                              : CommonContainerWidget(
                            height: 50.h,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.signIn(
                                  cubit.emailController.text.trim(),
                                  cubit.passwordController.text.trim(),
                                  context,
                                );
                              }
                            },
                            width: double.infinity,
                            color: Colors.black,
                            title: "Login",
                            colorFont: Colors.white,
                            fontSize: 20.sp,
                          ),
                          // Vertical Spacer
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          // Register Navigation
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget(
                                title: 'Don\'t have an account?',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              CommonSizeBoxWidget(
                                width: 5.h,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigatorToScreen(context, '/register_screen');
                                },
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                child: CommonTextWidget(
                                  title: 'Register',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
