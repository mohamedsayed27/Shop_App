import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/modules/search/cubit/searchCubit.dart';
import 'package:shop_app/modules/search/cubit/searchStates.dart';
import '../../models/search_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: textController,
                        validate: (value) {
                          if (value.isEmpty) {
                            return ' please enter text';
                          }
                          return null;
                        },
                        hint: 'Search',
                        label: 'Search',
                        preIcon: const Icon(Icons.search),
                        submit: (c) {
                          SearchCubit.get(context).getSearch(txt: c);
                        }),
                    ConditionalBuilder(
                      condition: SearchCubit.get(context).model != null,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return buildFavItem(
                                  SearchCubit.get(context).model!.data!.data![index],
                                  context , index);
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 4,
                                color: Colors.black,
                              );
                            },
                            itemCount:SearchCubit.get(context).model!.data!.data!.length),
                      ),
                      fallback: (context) => const Center(child:  CircularProgressIndicator(),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          listener: (context , state){

          }),
    );
  }

  Widget buildFavItem(Product data, context,index) {
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
                  image: NetworkImage(data.image!),
                  width: 120,
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
                    data.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${data.price}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.deepPurple.shade500),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
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
