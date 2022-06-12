import '../../../models/login_model.dart';

abstract class SettingsStates{}

class SettingsInitialState extends SettingsStates{}

class ShopLoadingGetUserDataState extends SettingsStates{}


class ShopSuccessGetUserDataState extends SettingsStates{}

class ShopErrorGetUserDataState extends SettingsStates{
  final String error;
  ShopErrorGetUserDataState(this.error);
}

class ShopUpdateUserLoadingState extends SettingsStates{}
class ShopUpdateUserSuccessState extends SettingsStates{
  final ShopLoginModel updateModel;

  ShopUpdateUserSuccessState(this.updateModel);
}
class ShopUpdateUserErrorState extends SettingsStates{
  final String error;
  ShopUpdateUserErrorState(this.error);
}

class ShopLogoutSuccessState extends SettingsStates{}
