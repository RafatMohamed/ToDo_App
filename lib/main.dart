import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/constants/app_constant.dart';
import 'core/network/api_helper.dart';
import 'core/resources/Colors/my_colors.dart';
import 'core/resources/route_name/route_page.dart';
import 'features/home_task/manager/home_cubit.dart';
import 'features/login/manager/login_cubit.dart';
import 'features/login/views/login2_view.dart';
import 'features/on_boarding/views/splash_view.dart';
import 'features/register/data/model/register_model.dart';
import 'features/register/manager/pick_image_cubit.dart';
import 'features/register/manager/register_cubit.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initialization();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()..getTasks()),
        BlocProvider(create: (context) => PickImageCubit(
          userModelRegi: UserModelRegi(),
          apiHelper: ApiHelper(),
        )),
      ],
      child: MyApp(),
    ),
  );
}

Future initialization() async {
  await Future.wait([
    Future.delayed(const Duration(seconds: 2)),
  ]);
  FlutterNativeSplash.remove();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppConstant.initialRoute,
      routes: {AppRoutePage.login: (context) => LoginTwoView(),},
      theme: ThemeData(
        fontFamily: AppConstant.fontFamily,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: MyColors.backgroundScaffoldColor,
          elevation: 0,
        ),
        scaffoldBackgroundColor: MyColors.backgroundScaffoldColor,
      ),
      title: AppConstant.appName,
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
