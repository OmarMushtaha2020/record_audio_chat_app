import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:record_audio_chat_app/modules/chat_screen/chat_screen.dart';
import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_states.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_size_box_widget.dart';
import 'package:record_audio_chat_app/shared/components/common_widget/common_text_widget.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserScreenCubit cubit=UserScreenCubit.get(context);

    return BlocConsumer<UserScreenCubit, UserScreenStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CommonTextWidget(
                  title: 'Chat',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: (){
                        uidOfUser=cubit.users[index].userUid!;
                        navigatorToScreen(context,'/chat_screen',value:  cubit.users[index].userUid!);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.h, // Adjust the radius as needed
                            backgroundImage: const NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/recordapp-aaf3c.appspot.com/o/voice%2Fdc9e1a00-2978-106e-b222-dfb24995da7b?alt=media&token=bec342f8-b7ed-457e-b873-5faf0ff8aa50'),
                          ),
                          CommonSizeBoxWidget(
                            width: 20.h,
                          ),
                          CommonTextWidget(
                            title: '${cubit.users[index].name}',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount:cubit.users.length),
          ),
        );
      },
    );
  }
}
