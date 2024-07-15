import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:record_audio_chat_app/shared/app_cubit/register_cubit/register_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/app_cubit/register_cubit/register_screen_states.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_container_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_size_box_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_text_form_field_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_text_widget.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => RegisterScreenCubit(),
      child: BlocConsumer<RegisterScreenCubit, RegisterScreenStates>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          // Now it's safe to get the cubit instance
          var cubit = RegisterScreenCubit.get(context);

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
                          CommonTextWidget(
                            title: 'Register',
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonTextWidget(
                            title: 'Register now to communicate with your friends',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonTextFormFieldWidget(
                            labelText: "User Name",
                            validator: validator("User Name"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.userName,
                            keyboardType: TextInputType.name,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonTextFormFieldWidget(
                            labelText: "Email Address",
                            validator: validator("Email Address"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonTextFormFieldWidget(
                            labelText: "Password",
                            validator: validator("Password"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonTextFormFieldWidget(
                            labelText: "Phone Number",
                            validator: validator("Phone Number"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            controller: cubit.phoneNumber,
                            keyboardType: TextInputType.phone,
                          ),
                          CommonSizeBoxWidget(
                            height: 20.h,
                          ),
                          CommonContainerWidget(
                              height: 50.h,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.createUserAccount(
                                    cubit.userName.text.toString().trim(),
                                    cubit.emailController.text.toString().trim(),
                                    cubit.phoneNumber.text.toString().trim(),
                                    context,
                                    cubit.passwordController.text.toString().trim(),
                                  );
                                }
                              },
                              width: double.infinity,
                              color: Colors.black,
                              title: "Register",
                              colorFont: Colors.white,
                              fontSize: 20.sp),
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
