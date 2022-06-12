import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/end_points.dart';
import '../../../models/login_model.dart';
import '../../../network/remote/dio_helper.dart';
import 'RegStates.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone ,
    required String name
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: registerUrl,
        data: {
          'email': email,
          'password': password,
          'phone' : phone,
          'name' : name,
        },

    )
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  Icon suffix = const Icon(Icons.visibility);
  bool isVisible = false;
  void passwordVisible(){
    isVisible = !isVisible;
    suffix = Icon(isVisible ? Icons.visibility_off : Icons.visibility);
    emit(ShopChangePasswordVisibilityState());
  }
}