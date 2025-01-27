import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';
import 'package:foodies/pages/intro_pages/intro_screen_1.dart';
import 'package:foodies/pages/intro_pages/intro_screen_2.dart';
import 'package:foodies/pages/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreens extends StatefulWidget {
  const IntroScreens({super.key});

  @override
  State<IntroScreens> createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  PageController controller = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              lastPage = (index == 1) ? true : false;
            });
          },
          controller: controller,
          children: const [
            IntroScreen1(),
            IntroScreen2(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(1);
                      },
                      child: const Text("Skip")),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 2,
                    effect: WormEffect(
                      dotWidth: 12.0,
                      dotHeight: 12.0,
                      activeDotColor: primaryColor,
                      dotColor: Colors.grey.shade500,
                    ),
                  ),
                  lastPage
                      ? TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text("Done"))
                      : TextButton(
                          onPressed: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text("Next")),
                ])),
      ]),
    );
  }
}
