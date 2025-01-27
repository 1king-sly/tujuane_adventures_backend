import 'package:flutter/material.dart';
import 'package:foodies/pages/popular_restaurants_page.dart';

class PopularRestaurants extends StatefulWidget {
  const PopularRestaurants({super.key});

  @override
  State<PopularRestaurants> createState() => _PopularRestaurantsState();
}

class _PopularRestaurantsState extends State<PopularRestaurants> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Restaurants",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PopularRestaurantsPage()));
                },
                child: const Text("View More"),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("name",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("10", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
