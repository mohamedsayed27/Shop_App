import 'package:shop_app/models/favorites_model.dart';

import '../../../models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{
  final String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopFavoritesDataState extends ShopStates{}


class ShopSuccessFavoritesDataState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesDataState(this.model);
}

class ShopErrorFavoritesDataState extends ShopStates{
  final String error;
  ShopErrorFavoritesDataState(this.error);
}


class ShopLoadingGetFavDataState extends ShopStates{}


class ShopSuccessGetFavDataState extends ShopStates{}

class ShopErrorGetFavDataState extends ShopStates{
  final String error;
  ShopErrorGetFavDataState(this.error);
}




