import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer< ShopCubit , ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  const Text('Software Team',style:  TextStyle(fontSize: 25),),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchScreen()));
                  },
                  icon: const Icon(Icons.search), iconSize: 30),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SettingsScreen()));
                  },
                  icon:  const Icon(Icons.settings) , iconSize: 30,),
            ],
          ),
          body: cubit.bottomNavModules[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: const [
              Icon(Icons.category, size: 30),
              Icon(Icons.home, size: 30),
              Icon(Icons.favorite, size: 30),
            ],
            index: cubit.currentIndex,
            backgroundColor: Colors.transparent,
            color: Colors.grey.shade100,
            buttonBackgroundColor: Colors.deepPurple.shade500,
            height: 60,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            
          ),
        );
      }  ,
    );
  }
}
