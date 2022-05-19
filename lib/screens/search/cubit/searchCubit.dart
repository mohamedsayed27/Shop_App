import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/search/cubit/searchStates.dart';

import '../../../components.dart';
import '../../../models/search_model.dart';
import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? model ;

  void getSearch({required String txt}){
    emit(ShopLoadingSearchDataState());
    DioHelper.postData(
        url: searchUrl,
        data: {
          'text' : txt,},
        token: token
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchDataState());
    }).catchError((e){
      print(e.toString());
      emit(ShopErrorSearchDataState(e.toString()));
    });

  }

}