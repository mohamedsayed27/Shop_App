import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/screens/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String img;
  final String title;
  final String bodyTitle;

  BoardingModel({
    required this.title,
    required this.img,
    required this.bodyTitle,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      bodyTitle: 'Boarding 1',
      title: 'Boarding 1',
      img: 'lib/assets/images/mannetjes.png',
    ),
    BoardingModel(
      bodyTitle: 'Boarding 1',
      title: 'Boarding 1',
      img: 'lib/assets/images/phone_shopping.png',
    ),
    BoardingModel(
      bodyTitle: 'Boarding 1',
      title: 'Boarding 1',
      img: 'lib/assets/images/google-shopping-feed-ecommerce-final.jpg',
    ),
  ];
  var pageViewController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) {
            return false;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    //setstate
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageViewController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBorderItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      // if(isLast == false)
                      //   {
                      pageViewController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                      // } else{
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                      // }
                    },
                    child: const Icon(Icons.arrow_back_ios)),
                const Spacer(),
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 2,
                      dotWidth: 10,
                      spacing: 2.0,
                      activeDotColor: Colors.deepPurple),
                ),
                const Spacer(),
                isLast
                    ? Container( padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),color: Colors.deepPurple.shade500,child: TextButton(onPressed: submit, child: const Text('Get Start',style:  TextStyle(color: Colors.white),)))
                    : FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          pageViewController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: const Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBorderItem(BoardingModel model) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(model.img)),
            const SizedBox(
              height: 50,
            ),
            Text(
              model.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(model.bodyTitle),
          ],
        ),
      );
}
