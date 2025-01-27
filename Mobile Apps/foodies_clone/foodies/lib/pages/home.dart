import 'package:flutter/material.dart';
import 'package:foodies/components/nearest_restaurants.dart';
import 'package:foodies/components/popular_menu.dart';
import 'package:foodies/components/popular_restaurants.dart';
import 'package:foodies/constants/constants.dart';

class Home extends StatefulWidget {
  final Function(int) setCurrentScreenIndex;

  const Home({super.key, required this.setCurrentScreenIndex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pattern2.webp'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
          foregroundDecoration: const BoxDecoration(
              color: Color.fromARGB(50, 21, 190, 120),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: 5,
                child: Column(
                  children: [
                    const Text(
                      "Special Deal For October",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                top: 30,
                child: Image.asset(
                  'assets/images/ice_cream.webp', // Replace with your image path
                  height: 100,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Nearest Restaurant Section
        const NearestRestaurants(),

        const SizedBox(height: 10),

        const PopularMenu(),
        const SizedBox(height: 10),

        const PopularRestaurants(),
      ],
    );
  }
}
