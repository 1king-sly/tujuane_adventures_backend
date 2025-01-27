import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';
import 'package:foodies/pages/bio_page.dart';
import 'package:foodies/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 215,
                          width: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Text(
                          "Login To Your Account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 30),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscured = isObscured ? false : true;
                        });
                      },
                      child: isObscured
                          ? Icon(Icons.visibility, color: Colors.grey.shade500)
                          : Icon(Icons.visibility_off,
                              color: Colors.grey.shade500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                      height: 5,
                    ),
                    Text('Or Continue With'),
                    Divider(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/facebook.webp'),
                                        fit: BoxFit.cover,
                                      ))),
                              const Text("Facebook")
                            ]),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/google.webp'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Text("Google")
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
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
                            builder: (context) => const BioPage()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        maintainState: false,
                        builder: (context) => const SignupPage()));
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
