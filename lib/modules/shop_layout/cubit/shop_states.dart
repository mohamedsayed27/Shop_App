import 'package:shop_app/models/ChangeCartModel.dart';
import 'package:shop_app/models/chart_model.dart';
import 'package:shop_app/models/favorites_model.dart';


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

class ShopLoadingFavoritesDataState extends ShopStates{}


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


class ShopLoadingCartDataState extends ShopStates{}





class ShopLoadingCartsDataState extends ShopStates{}


class ShopSuccessCartsDataState extends ShopStates{
  final ChangeCartModel model;

  ShopSuccessCartsDataState(this.model);
}

class ShopErrorCartsDataState extends ShopStates{
  final String error;
  ShopErrorCartsDataState(this.error);
}


class ShopLoadingGetCartDataState extends ShopStates{}


class ShopSuccessGetCartDataState extends ShopStates{}

class ShopErrorGetCartDataState extends ShopStates{
  final String error;
  ShopErrorGetCartDataState(this.error);
}






