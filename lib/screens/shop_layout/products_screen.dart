import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/screens/shop_layout/cubit/shop_states.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null&& ShopCubit.get(context).categoriesModel !=null,
              builder: (context) {
                return screenBuilder(ShopCubit.get(context).homeModel,context ,ShopCubit.get(context).categoriesModel! );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {
          if(state is ShopSuccessFavoritesDataState) {
            if(! state.model.status!){
              Fluttertoast.showToast(
                  msg: "${state.model.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            else{
              Fluttertoast.showToast(
                  msg: "${state.model.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }


        });
  }

  Widget screenBuilder(HomeModel? model,context,CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  scrollDirection: Axis.horizontal,
                  autoPlayCurve: Curves.fastOutSlowIn)),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return buildCategoriesItems(categoriesModel.data!.data![index]);
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(width: 10,);
                      },
                      itemCount: categoriesModel.data!.data!.length),
                ),
                const SizedBox(height: 12,),
                const Text('New Products',style:  TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            color: Colors.grey.shade300,
            child: buildGridView(model,context),
          )
        ],
      ),
    );
  }

  Widget buildCategoriesItems(HData hData) {
    return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children : [
              Image.network(hData.image!,width: 100,height: 100,fit: BoxFit.cover,),
              Container(
                width: 100,
                color: Colors.black.withOpacity(0.8),
                  child: Text(hData.name!,style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),)
              ),
            ]
        );
  }

  Widget buildGridView(HomeModel model , context) {
    return GridView.count(
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio:  1 /1.59 ,
            children: List.generate(
              model.data!.products!.length,
                (index) => Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // ConditionalBuilder(
                          //     condition: ShopCubit.get(context).homeModel!.data!.products![index].image != null,
                          //     builder: (context)=>Image(
                          //       image: NetworkImage(model.data!.products![index].image!)
                          //       ,height: 170,
                          //       width: double.infinity,
                          //     ),
                          //     fallback: (context) => const Image(image: AssetImage('lib/assets/images/google-shopping-feed-ecommerce-final.jpg'))),
                          FadeInImage(placeholder: const AssetImage('lib/assets/images/phone_shopping.png') , image:NetworkImage(model.data!.products![index].image!),height: 170, width: double.infinity, ),
                          if(model.data!.products![index].discount != 0)
                            Container(
                              color: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: const Text(
                                'Discount',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                      ],
                        alignment: AlignmentDirectional.bottomStart,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                                model.data!.products![index].name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  '${model.data!.products![index].price.round()}',
                                  style: TextStyle(color: Colors.deepPurple.shade500),
                                ),
                                const SizedBox(width: 5,),
                                if(model.data!.products![index].discount != 0)
                                Text(
                                    '${model.data!.products![index].oldPrice.round()}',
                                  style: const TextStyle(fontSize: 11.0,color: Colors.grey,decoration: TextDecoration.lineThrough),
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ShopCubit.get(context).favorites[model.data!.products![index].id]! ? Colors.red : Colors.grey,
                                  child: IconButton(
                                      onPressed: (){
                                        ShopCubit.get(context).getFavorites(model.data!.products![index].id!);
                                      },
                                      icon: const Icon(Icons.favorite_border,size: 15,color: Colors.white,)),
                                )

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          );
  }
}
