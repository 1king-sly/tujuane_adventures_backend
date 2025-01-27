import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';
import 'package:foodies/pages/home_page.dart';

class ProfileSuccess extends StatefulWidget {
  const ProfileSuccess({super.key});

  @override
  State<ProfileSuccess> createState() => _ProfileSuccessState();
}

class _ProfileSuccessState extends State<ProfileSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/pattern2.webp'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey.shade100,
                  // Colors.white,
                  Colors.white,
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/success.webp',
                  width: 172, height: 162, fit: BoxFit.cover),
              const SizedBox(height: 10),
              const Text(
                "Congrats!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your Profile Is Ready To Use",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF53E88B),
                    Color(0xFF15BE77),
                  ],
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
