import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/modules/login/login_screen.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  final Widget positioned1;
  final Widget positioned2;

  const BackGround({
    Key? key,
    required this.child,
    required this.positioned1,
    required this.positioned2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          positioned1,
          positioned2,
          child,
        ],
      ),
    );
  }
}

class SpecialButton extends StatelessWidget {
  final Color bColor;
  final Color oLayColor;

  final Color tColor;
  final String text;
  final Function press;
  IconData? icon;
   bool isThereSuffixIcon = false;
   SpecialButton({
    Key? key,
    required this.bColor,
    required this.tColor,
    required this.text,
    required this.press,
     required this.oLayColor,
     this.icon,
     required this.isThereSuffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 20,horizontal: 40)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => bColor),
                overlayColor: MaterialStateProperty.resolveWith((states) => oLayColor)
             ),
              onPressed: () {
                press();
              },
              child: isThereSuffixIcon?
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(color: tColor),
                  ),
                  const Spacer(),
                  Icon(icon,color: Colors.white,),
                ],
              ) :
              Text(
                text,
                style: TextStyle(color: tColor),
              )
          )
      ),
    );
  }
}

Widget positioned({
  required Widget image,
  double? bottom,
  double? left,
  double? right,
  double? top,
}) {
  return Positioned(
      bottom: bottom, left: left, right: right, top: top, child: image);
}
 String? token  ;



Widget defaultFormField({
  required TextEditingController controller,
  required Function validate,
  TextInputType? type,
  required String hint,
  required String label,
  required Icon preIcon,
   IconButton? sufIcon,
  Function? submit,
  bool f =false

}){
  return TextFormField(
    obscureText: f,
    controller: controller,
    keyboardType: type,
    validator: (v){
      return validate(v);
    },
    decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25))),
    onFieldSubmitted: (s){
      submit!(s);
    },
  );
}

void signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (context){
                return LoginScreen();
              }),
              (route) => false
      );
    }
  });
}

