import 'package:flutter/material.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 435,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/illustration.webp'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 244,
                height: 122,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Find Your Comfort Food Here',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 10),
                      Text(
                        'Here you can find a Chef or dish for every taste and color.Enjoy!',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
