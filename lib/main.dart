import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/event.dart';
import 'package:record_audio_chat_app/shared/app_route/app_route.dart';

import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/bloc_observer/bloc_observer.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'shared/network/local/cacth_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserverToApp();

  await Cacth_Helper.inti();
token=Cacth_Helper.getToken("token")??"";
print("the token is$token");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  AppRoute appRoute=AppRoute();
  @override
  Widget build(BuildContext context) {
    print("the screenWidth is$screenWidth");
    print("the screenHeight is$screenHeight");

    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      // Set your design size (width, height)
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UserBloc()..add(GetUserData())..add(GetAllUser())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            onGenerateRoute: appRoute.generateRoute,

            // Important for DevicePreview

            locale: DevicePreview.locale(context),
            // Add the locale
            builder: DevicePreview.appBuilder,
            // Add the DevicePreview builder
          ),
        );
      },
    );
  }
}
