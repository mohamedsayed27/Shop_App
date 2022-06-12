import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/chart_model.dart';
import 'package:shop_app/models/favorites_items_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import '../../../models/ChangeCartModel.dart';
import '../categories_screen.dart';
import 'package:shop_app/modules/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/modules/shop_layout/favorite_screen.dart';
import 'package:shop_app/modules/shop_layout/products_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> bottomNavModules = [
    const CategoriesScreen(),
    const ProductScreen(),
     const FavoriteScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: home,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id! : element.inFavorites!});
      }
      for (var element in homeModel!.data!.products!) {
        carts.addAll({element.id! : element.inCart!});
      }
      print(carts.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }
  void getCategoriesData(){
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: getCategories,lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){

      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  Map<int , bool> favorites = {} ;
  ChangeFavoritesModel? changeFavoritesModel;
  void getFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingFavoritesDataState());
    DioHelper.postData(
        url: favoritesUrl,
        data: {'product_id' : productId} ,
        token: token
    )
        .then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          if(! changeFavoritesModel!.status!) {
            favorites[productId] = !favorites[productId]!;
          }else{
            getFavoriteData();
          }
          emit(ShopSuccessFavoritesDataState(changeFavoritesModel!));
    })
        .catchError((error){
          favorites[productId] = !favorites[productId]!;
          emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }

   FavoritesModel? favoritesModel;
  void getFavoriteData(){
    emit(ShopLoadingGetFavDataState());
    DioHelper.getData(
        url: favoritesUrl,
        lang: 'en',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavDataState());
    }).catchError((error){
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }



  Map<int , bool> carts = {} ;
  ChangeCartModel? changeCartModel;
  void changeCarts(int productId){
    carts[productId] = !carts[productId]!;
    emit(ShopLoadingCartsDataState());
    DioHelper.postData(
        url: cartUrl,
        data: {'product_id' : productId} ,
        token: token
    )
        .then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if(! changeCartModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getCartsData();
      }
      print(carts[productId].toString());
      emit(ShopSuccessCartsDataState(changeCartModel!));
    })
        .catchError((error){
      carts[productId] = !carts[productId]!;
      emit(ShopErrorCartsDataState(error.toString()));
    });
  }

  CartModel? cartModel;
  void getCartsData(){
    emit(ShopLoadingGetCartDataState());
    DioHelper.getData(
      url: cartUrl,
      lang: 'en',
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessGetCartDataState());
    }).catchError((error){
      emit(ShopErrorCartsDataState(error.toString()));
    });
  }

}
