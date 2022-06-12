import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/cubit/settings_cubit.dart';
import 'package:shop_app/modules/settings/cubit/settings_states.dart';
import '../../components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsCubit()..getUserProfileData(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
          builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    body: ConditionalBuilder(
                        condition: SettingsCubit.get(context).userModel != null ,
                        builder: (context) {
                          var cubit = SettingsCubit.get(context);
                          if(cubit.userModel!.status!){
                            var model = cubit.userModel;
                            nameController.text = model!.data!.name! ;
                            emailController.text = model.data!.email! ;
                            phoneController.text = model.data!.phone!  ;
                          } else {
                            if (kDebugMode) {
                              print(cubit.userModel!.message);
                            }
                          }
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if(state is ShopUpdateUserLoadingState)
                                    const LinearProgressIndicator(),
                                    const SizedBox(height: 10,),
                                    defaultFormField(
                                        label: 'name',
                                        hint: 'Enter your name',
                                        preIcon: const Icon(Icons.person),
                                        validate: (value){
                                          if(value.isEmpty) {
                                            return 'please enter your name';
                                          }
                                        },
                                        controller: nameController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                        label: 'Email',
                                        hint: 'Enter Your e-mail',
                                        preIcon: const Icon(Icons.alternate_email_outlined),
                                        validate: (value){
                                          if(value.isEmpty) {
                                            return 'please enter your email';
                                          }
                                        },
                                        controller: emailController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                        label: 'Phone',
                                        hint: 'Enter Your Phone',
                                        preIcon: const Icon(Icons.phone),
                                        validate: (value){
                                          if(value.isEmpty) {
                                            return 'please enter your phone';
                                          }
                                        },
                                        controller: phoneController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SpecialButton(
                                      bColor: Colors.deepPurple.shade500,
                                      tColor: Colors.white,
                                      text: "Update",
                                      press: () {
                                        if(formKey.currentState!.validate()){
                                          SettingsCubit.get(context).updateUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      oLayColor: Colors.deepPurple, isThereSuffixIcon: false,),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SpecialButton(
                                      bColor: Colors.deepPurple.shade500,
                                      tColor: Colors.white,
                                      text: "LogOut",
                                      press: () {
                                        SettingsCubit.get(context)
                                            .signOut(fcm_token: token!, context: context);
                                      },
                                      oLayColor: Colors.deepPurple,
                                      isThereSuffixIcon: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        fallback:(context) => const Center(child: CircularProgressIndicator())),
                  );
                },
          listener: (context, state) {}),
    );
  }
}



