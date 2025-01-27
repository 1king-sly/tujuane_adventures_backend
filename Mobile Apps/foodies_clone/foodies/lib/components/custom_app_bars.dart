import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';


class CustomAppBarOne extends StatelessWidget {
  const CustomAppBarOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 30,
      leading: Container(
          // alignment: const Alignment(0, 0),
          // width: 45,
          // height: 45,
          // decoration: const BoxDecoration(
          //   color: Color.fromARGB(17, 218, 98, 23),
          //   borderRadius: BorderRadius.all(Radius.circular(15)),
          // ),
          // child: Center(
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: const Icon(
          //       Icons.arrow_left_sharp,
          //       color: Color(0xFFDA6317),
          //       size: 30,
          //     ),
          //   ),
          // ),
          ),
      title: Container(),

      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 5),
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(15),
      //         ),
      //       ),
      //       child: IconButton(
      //         icon: const Icon(Icons.notifications, color: primaryColor),
      //         onPressed: () {},
      //       ),
      //     ),
      //   ),
      // ],
      elevation: 0.0,
      backgroundColor: Colors.white,
      pinned: true,
      bottom: PreferredSize(
        // Add this code
        preferredSize: const Size.fromHeight(-8), // Add this code
        child: Container(), // Add this code
      ),
    );
  }
}

class CustomAppBarTwo extends StatefulWidget {
  final String text;
  const CustomAppBarTwo({super.key, required this.text});

  @override
  State<CustomAppBarTwo> createState() => _CustomAppBarTwoState();
}

class _CustomAppBarTwoState extends State<CustomAppBarTwo> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      title: Container(),
      titleSpacing: 30,
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: 90,
      floating: true,
      snap: true,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: FlexibleSpaceBar(
          // collapseMode: CollapseMode.parallax,
          background: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/pattern2.webp'),
                  fit: BoxFit.cover),
              color: Colors.white,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      width: 233,
                      height: 82,
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 31),
                        maxLines: 3,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: const Offset(
                            5.0, // Move to right 5  horizontally
                            5.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.notifications, color: primaryColor),
                      onPressed: () {},
                    ),
                  ),
                ]),
          ),
        ),
      ),
      bottom: PreferredSize(
        // Add this code
        preferredSize: const Size.fromHeight(-8), // Add this code
        child: Container(), // Add this code
      ),
    );
  }
}

class CustomAppBarThree extends StatefulWidget {
  const CustomAppBarThree({super.key});

  @override
  State<CustomAppBarThree> createState() => _CustomAppBarThreeState();
}

class _CustomAppBarThreeState extends State<CustomAppBarThree> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      elevation: 10,
      bottom: const PreferredSize(
        // Add this code
        preferredSize: Size.fromHeight(-20), // Add this code
        child: Text(''), // Add this code
      ),
      backgroundColor: Colors.white,
      pinned: true,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: FlexibleSpaceBar(
          background: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "What do you want to order?",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(100, 218, 98, 23),
                            fontSize: 12,
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(20, 249, 169, 77),
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFFDA6317)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(20, 249, 169, 77),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Color(0xFFDA6317),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
