import 'package:flutter/material.dart';
import 'package:foodies/components/input.dart';
import 'package:foodies/pages/upload_photo.dart';

class BioPage extends StatefulWidget {
  const BioPage({super.key});

  @override
  State<BioPage> createState() => _BioPageState();
}

class _BioPageState extends State<BioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 200,
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
        SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        // alignment: const Alignment(0, 0),
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(17, 218, 98, 23),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_left_sharp,
                              color: Color(0xFFDA6317),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 264,
                      height: 129,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fill in your bio to get started',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            // SizedBox(height: 10),
                            Text(
                              'This data will be displayed in your account profile for security',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            )
                          ]),
                    ),
                    const SizedBox(height: 15),
                    const InputComponent(hintText: "First Name"),
                    const SizedBox(height: 10),
                    const InputComponent(hintText: "Last Name"),
                    const SizedBox(height: 10),
                    const InputComponent(
                        hintText: "Phone Number",
                        keyboardType: TextInputType.phone),
                  ],
                ),
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
                        MaterialPageRoute(
                            builder: (context) => const UploadPhoto()),
                      );
                    },
                    child: const Text(
                      "Next",
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
        ),
      ]),
    );
  }
}
