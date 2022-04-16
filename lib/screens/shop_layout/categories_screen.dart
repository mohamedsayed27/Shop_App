import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context , state){
          return ConditionalBuilder(
              condition: ShopCubit.get(context).categoriesModel !=null,
              builder: (context){
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          physics:  const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                        shrinkWrap: true,
                          itemBuilder: (context,index){
                            return buildCategoriesScreenItems(ShopCubit.get(context).categoriesModel!.data!.data![index]);
                          },
                          separatorBuilder: (context,index) {
                            return Container(
                              height: 2,
                              color: Colors.grey,
                            );
                          },
                          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length),
                    ],
                  ),
                );

              },
              fallback: (context){
                return const Center(child: CircularProgressIndicator());
              });
        },
        listener: (context , state){

        });
  }

  SizedBox buildCategoriesScreenItems(HData? hData) {
    return SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Image.network(hData!.image!,height: 100,width: 100,fit: BoxFit.cover,),
                                const SizedBox(width: 15,),
                                Text(hData.name!,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          );
  }
}
