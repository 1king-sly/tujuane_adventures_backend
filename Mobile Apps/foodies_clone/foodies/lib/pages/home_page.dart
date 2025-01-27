import 'package:flutter/material.dart';
import 'package:foodies/components/custom_app_bars.dart';
import 'package:foodies/constants/constants.dart';
import 'package:foodies/pages/home.dart';
import 'package:foodies/pages/nearest_restaurant_page.dart';
import 'package:foodies/pages/popular_menu_page.dart';
import 'package:foodies/pages/popular_restaurants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int currentScreenIndex = 0;
  List<Widget> screens = [];

  void setCurrentScreenIndex(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    screens = [
      Home(setCurrentScreenIndex: setCurrentScreenIndex),
      const NearestRestaurantPage(),
      const PopularMenuPage(),
      const PopularRestaurantsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            // const CustomAppBarOne(),
            const CustomAppBarTwo(
              text: 'Find Your Favorite Food',
            ),
            const CustomAppBarThree(),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: screens[currentScreenIndex]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.white,
        elevation: 1,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                    currentScreenIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home_outlined,
                  color:
                      currentIndex == 0 ? primaryColor : Colors.grey.shade400,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.person,
                  color:
                      currentIndex == 1 ? primaryColor : Colors.grey.shade400,
                  size: 25,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: Icon(Icons.shopping_cart,
                    color:
                        currentIndex == 3 ? primaryColor : Colors.grey.shade400,
                    size: 25),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.chat_outlined,
                  color:
                      currentIndex == 4 ? primaryColor : Colors.grey.shade400,
                  size: 25,
                ),
              ),
            ]),
      ),
    );
  }
}
