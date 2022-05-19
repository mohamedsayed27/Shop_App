import 'package:flutter/material.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import '../register/register_screen.dart';
import '../../components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      body: BackGround(
          // image: Image.asset('lib/assets/images/main_top.png',width: size.width*0.3,),
          // image2: Image.asset('lib/assets/images/main_bottom.png',width: size.width*0.2),
          positioned2: positioned(
            top: 0,
              left: 0,
              image: Image.asset('lib/assets/images/main_top.png',width: size.width*0.3,),),
          positioned1: positioned(
            bottom: 0,
              left: 0,
              image: Image.asset('lib/assets/images/main_bottom.png',width: size.width*0.2),),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome to Shop App',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: size.height*0.05,),
                  Image.asset('lib/assets/images/Mobile login-amico.png',height: size.height*0.4),
                  SizedBox(height: size.height*0.05,),
                  SpecialButton(bColor: Colors.deepPurple.shade500, tColor: Colors.white, text: 'Login', press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return  LoginScreen();
                    }));
                  }, oLayColor: Colors.indigo,),
                  SpecialButton(bColor: Colors.grey.shade300, tColor: Colors.black, text: 'Register',press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return  RegisterScreen();
                    }));
                  }, oLayColor: Colors.grey,),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

