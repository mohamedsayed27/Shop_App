import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/cubit/settings_states.dart';

import '../../../components.dart';
import '../../../models/login_model.dart';
import '../../../network/end_points.dart';
import '../../../network/local/cash_helper.dart';
import '../../../network/remote/dio_helper.dart';
import '../../login/login_screen.dart';

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);


  ShopLoginModel? userModel ;
  void getUserProfileData(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: profile,
      lang: 'en',
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error){
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopUpdateUserLoadingState());
    DioHelper.putData(
        url: updateProfile,
        data: {
          'phone' :phone ,
          'email' : email ,
          'name' : name,
        }, token: token,).
    then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateUserSuccessState(userModel!));
    }).catchError((e){
      emit(ShopUpdateUserErrorState(e.toString()));
    });
  }

  void signOut({
    required String fcm_token,
    required BuildContext context,

  }
      ){
    DioHelper.postData(
        url: logout,
        data: {
          'token' : fcm_token
        }
    ).
    then((value) {
      CacheHelper.removeData(key: 'token').then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return LoginScreen();}), (route) => false);
      });
      emit(ShopLogoutSuccessState());
    });
  }

}