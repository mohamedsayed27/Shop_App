import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/network/local/cash_helper.dart';

import 'package:shop_app/style.dart';
import 'components.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/shop_layout/cubit/shop_cubit.dart';
import 'modules/shop_layout/shop_layout.dart';
import 'network/remote/dio_helper.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
   Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding != null){
    if(token != null) {
      widget =  const ShopLayout();
    }if(token == null) {
      widget = LoginScreen();
    }
  }else {
    widget =  const OnBoardingScreen();
  }
  runApp(MyApp(onBoarding: onBoarding,startWidget: widget,));
}

class MyApp extends StatelessWidget {
   final bool? onBoarding;
   final Widget? startWidget;
    const MyApp({Key? key, this.onBoarding, this.startWidget}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getCartsData()),
        BlocProvider(
     create : (context) => ShopLoginCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // darkTheme: darkTheme,
        home:  startWidget,
      ),
    );
  }
}
