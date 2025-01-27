import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';
import 'package:foodies/pages/profile_success.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? position;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    String locationMessage = "Location not set";

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      setState(() {
        locationMessage = "Location services are disabled.";
      });

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setState(() {
          locationMessage = "Location permission denied.";
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        locationMessage =
            "Location permissions are permanently denied. Please enable them in settings.";
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    setState(() {
      locationMessage =
          "Latitude: ${position?.latitude}, Longitude: ${position?.longitude}";
    });

    debugPrint(position.toString());
    debugPrint(locationMessage);

    return position!;
  }

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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Set Your Location',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
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
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: const Offset(
                              5.0, // Move to right 5  horizontally
                              5.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              Container(
                                width: 33,
                                height: 33,
                                // shape:BoxShape.circle,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8D52B),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.location_pin,
                                    color: Color(0xFFE86D28)),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Your Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextButton(
                                  onPressed: position == null
                                      ? _determinePosition
                                      : null,
                                  child: Text(
                                    position != null
                                        ? "Location Captured"
                                        : "Set Location",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: position != null
                                          ? primaryColor
                                          : Colors.black,
                                    ),
                                  )),
                            )
                          ]),
                    ),
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
                    onPressed: position == null
                        ? null
                        : () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const ProfileSuccess()),
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
