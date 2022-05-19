import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_items_model.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_states.dart';

class FavoriteScreen extends StatelessWidget {

   const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! ShopLoadingGetFavDataState,
              builder: (context){
                return ListView.separated(
                    itemBuilder: ( context,index){
                      return buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context);
                    },
                    separatorBuilder: (context,index){
                      return Container(
                        color: Colors.black,
                        height: 2.0,
                      );
                    },
                    itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length);
              },
              fallback: (context){
                return const Center(child: CircularProgressIndicator());
              });
        },
        listener: (context , state){
        });
  }

  Widget buildFavItem(FavData data , context) {
    return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
               Image(
                image: NetworkImage(data.product!.image!),
                width: 120,
              ),
              if (data.product!.discount! != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'Discount',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
            alignment: AlignmentDirectional.bottomStart,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.product!.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${data.product!.price!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.deepPurple.shade500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (1 != 0)
                       Text(
                        '${data.product!.oldPrice!}',
                        style: const TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:ShopCubit.get(context).favorites[data.product!.id!]! ? Colors.red : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).getFavorites(data.product!.id!);
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 15,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}
