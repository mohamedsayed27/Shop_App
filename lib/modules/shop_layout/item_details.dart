
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/models/chart_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/shop_layout/cubit/shop_states.dart';

class ItemDetails extends StatelessWidget {

  ItemDetails( {Key? key,required this.product}) : super(key: key);
  final Products product;
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      builder: (context, state) {
        CartItem? cartItem;
        return Scaffold(
          appBar: AppBar(
            title:  const Text(''),
          ),
          body:   Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children:  [
                  Image(image: NetworkImage(product.image!),height: 300,width: 300,),
                  Text(product.name!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  const SizedBox(height: 10, ),
                  Text(product.description!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  SpecialButton(
                    bColor: Colors.deepPurple.shade500,
                    tColor: Colors.white,
                    text: "Add to Chart",
                    press: (){
                      ShopCubit.get(context).changeCarts(cartItem!.id!);
                    },
                    oLayColor: Colors.deepPurple.shade900,
                    icon: Icons.show_chart, isThereSuffixIcon: true,
                  ),
                  const SizedBox(height: 15,)
                ],
              ),
            ),
          ),
        );
      },
      listener: (context,state){},
    );
  }
}
