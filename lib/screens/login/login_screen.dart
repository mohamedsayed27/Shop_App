import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/screens/login/cubit/cubit.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import 'package:shop_app/screens/shop_layout/shop_layout.dart';
import '../register/register_screen.dart';
import '../../components.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token).
              then((value) {
                token = state.loginModel.data!.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopLayout()),
                      (Route<dynamic> route) => false,
                );
              });
              Fluttertoast.showToast(
                  msg: "${state.loginModel.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              // Navigator.pushReplacementNamed(context, '/shopscreen');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ShopLayout()),
                    (Route<dynamic> route) => false,
              );
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopLayout()));
            } else {
              Fluttertoast.showToast(
                  msg: "${state.loginModel.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (BuildContext context, state) => Scaffold(
            body: BackGround(
          positioned1: positioned(
            top: 0,
            left: 0,
            image: Image.asset(
              'lib/assets/images/main_top.png',
              width: size.width * 0.3,
            ),
          ),
          positioned2: positioned(
            bottom: 0,
            right: 0,
            image: Image.asset('lib/assets/images/login_bottom.png',
                width: size.width * 0.4),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 32, bottom: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Image.asset('lib/assets/images/Mobile login.png',
                        height: size.height * 0.4),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your E-mail';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'E-mail',
                            labelText: 'Enter Your E-mail',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        obscureText: ShopLoginCubit.get(context).isVisible,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ShopLoginCubit.get(context).passwordVisible();
                                },
                                icon: ShopLoginCubit.get(context).suffix),
                            hintText: 'Password ',
                            labelText: 'Enter Your Password',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (BuildContext context) => SpecialButton(
                        bColor: Colors.deepPurple.shade500,
                        tColor: Colors.white,
                        text: 'Login',
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        oLayColor: Colors.deepPurple.shade700,
                      ),
                      fallback: (BuildContext context) {
                        return const CircularProgressIndicator();
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You don't have Email ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: Text('Register now',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 17)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         RegisterScreen()));
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      );

  }
}
