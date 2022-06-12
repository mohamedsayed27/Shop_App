import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register/cubit/RegCubit.dart';
import 'package:shop_app/modules/register/cubit/RegStates.dart';
import '../../components.dart';
import '../../network/local/cash_helper.dart';
import '../shop_layout/shop_layout.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
   final nameController = TextEditingController();
   final phoneController = TextEditingController();
   final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  BlocProvider(
        create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
          listener: (context,state) {
            if (state is ShopRegisterSuccessState) {
              if (state.registerModel.status == true) {
                CacheHelper.saveData(
                    key: 'token',
                    value: state.registerModel.data!.token).
                then((value) {
                  token = state.registerModel.data!.token;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopLayout()),
                        (Route<dynamic> route) => false,
                  );
                });
                Fluttertoast.showToast(
                    msg: "${state.registerModel.message}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopLayout()),
                      (Route<dynamic> route) => false,
                );
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopLayout()));
              } else {
                Fluttertoast.showToast(
                    msg: "${state.registerModel.message}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          },
          builder: (context, state) => Scaffold(
              body: BackGround(
                positioned1: positioned(
                  top: 0,
                  left: 0,
                  image: Image.asset(
                    'assets/images/main_top.png',
                    width: size.width * 0.3,
                  ),
                ),
                positioned2: positioned(
                  bottom: 0,
                  right: 0,
                  image: Image.asset('assets/images/login_bottom.png',
                      width: size.width * 0.4),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(27.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Register',
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Image.asset('assets/images/Personal site-rafiki.png',
                              height: size.height * 0.3),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          defaultFormField(
                              controller: nameController,
                              validate: (value){
                                if(value.isEmpty) {
                                  return 'you must enter your name';
                                }
                              },
                              hint: "Enter Your Name",
                              label: "Name",
                              preIcon: const Icon(Icons.person)),
                          SizedBox(height: size.height * 0.02),
                          defaultFormField(
                              controller: emailController,
                              validate: (value){
                                if(value.isEmpty) {
                                  return 'you must enter your mail';
                                }
                              },
                              hint: "Enter Your Email",
                              label: "E-mail",
                              preIcon: const Icon(Icons.alternate_email_outlined)),
                          SizedBox(height: size.height * 0.02),
                          defaultFormField(
                              controller: passwordController,
                              validate: (value){
                                if(value.isEmpty) {
                                  return 'your password is too short !!';
                                }
                              },
                              hint: "Enter Your password",
                              label: "Password",
                              sufIcon:  IconButton(
                                  onPressed: (){
                                    ShopRegisterCubit.get(context).passwordVisible();
                                  },
                                  icon: ShopRegisterCubit.get(context).suffix,

                              ),
                              preIcon: const Icon(Icons.password),
                            f: ShopRegisterCubit.get(context).isVisible

                          ),
                          SizedBox(height: size.height * 0.02),
                          defaultFormField(
                              controller: phoneController,
                              validate: (value){
                                if(value.isEmpty) {
                                  return 'you must enter your phone';
                                }
                              },
                              hint: "Enter Your Phone",
                              label: "Phone",
                              preIcon: const Icon(Icons.phone)),
                          SizedBox(height: size.height * 0.02),
                          ConditionalBuilder(
                            builder: (BuildContext context) {
                              return SpecialButton(
                                bColor: Colors.deepPurple.shade500,
                                isThereSuffixIcon: false,
                                tColor: Colors.white,
                                text: "Register",
                                press: (){
                                  if (_formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text
                                    );
                                  }
                                },
                                oLayColor: Colors.deepPurple.shade900); },
                            condition: state is! ShopRegisterLoadingState,
                            fallback: (BuildContext context) { return  const Center(child: CircularProgressIndicator()); },
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              )),
          ),
    );
  }
}
