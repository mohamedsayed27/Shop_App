abstract class SearchStates{}

class InitialSearchState extends SearchStates{}



class ShopLoadingSearchDataState extends SearchStates{}

class ShopSuccessSearchDataState extends SearchStates{}

class ShopErrorSearchDataState extends SearchStates{
  final String error;
  ShopErrorSearchDataState(this.error);
}