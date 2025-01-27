import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

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
                      image: AssetImage('assets/images/illustration2.webp'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 250,
                height: 122,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Foodies Is Where Your Comfort Food Lives',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 10),
                      Text(
                        'Enjoy a fast and smooth Food delivery at your doorstep',
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
