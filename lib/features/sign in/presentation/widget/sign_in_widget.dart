// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/cubit/login_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/screen/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? accessTokenSignIn;

  saveAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accessToken', accessTokenSignIn!);
  }

  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff7A7A7A),
            ),
          ),
          centerTitle: true,
          title: Text(
            "LOGIN",
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginLoading) {
              showAppLoading(context);

              // Handle loading state
            } else if (state is LoginSuccess) {
              final loginResponse = state.loginResponse;

              final message = state.loginResponse['message'];
              accessTokenSignIn = state.loginResponse['access_token'];
              print(message);
              log("$accessTokenSignIn");
              saveAccessToken();

              print(loginResponse);
              successDialog(context, message);

              // Handle success state
              // Do something with the response
            } else if (state is LoginError) {
              // Handle error state
              final errorMessage = state.errorMessage;

              log("$errorMessage");
              errorDialog(context, errorMessage);

              // Handle the error
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    height: 284,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email/username';
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return 'Invalid email address';
                        }
                        // You can add more complex validation here
                        // e.g., check if it's a valid email address
                        return null;
                      },
                      decoration: InputDecoration(
                          labelStyle: GoogleFonts.lato(
                              color: const Color(0xff7A7A7A),
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                          labelText: "Email",
                          hintText: "info@xyrontech.com",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        // You can add more complex password validation here
                        // e.g., check for a minimum length
                        return null;
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelStyle: GoogleFonts.lato(
                              color: const Color(0xff7A7A7A),
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                          labelText:
                              "Password", // Change "Phone Number" to "Password"
                          hintText: "Enter your password", // Adjust hint text
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    decoration: BoxDecoration(
                        // color: const Color(0xff1974B3),
                        gradient: const LinearGradient(
                            colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                        borderRadius: BorderRadius.circular(5)),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final userName = _emailController.text;
                          final password = _passwordController.text;
                          print("$userName and $password");
                          // Form is valid, you can proceed with login
                          // final email = _emailController.text;
                          // final password = _passwordController.text;

                          // // Perform your login logic here
                          BlocProvider.of<LoginCubit>(context).login(
                              email: _emailController.text,
                              password: _passwordController.text,
                              device: "app");
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                        child: Text(
                          "  Login  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: GoogleFonts.lato(
                            // color: Colors.black,
                            fontSize: 12,
                            // fontFamily: GoogleFonts.montserrat,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Single tapped.
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => const SignUpScreen()),
                                  );
                                },
                              text: ' Sign up',
                              style: GoogleFonts.lato(
                                  color: const Color(0xff7200e0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Forgot the password?',
                        style: GoogleFonts.lato(
                            // color: Colors.black,
                            fontSize: 12,
                            // fontFamily: GoogleFonts.montserrat,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // _showCustomDialog(context);
                                  // _showCustomDialog(context);
                                  // Single tapped.
                                  // Navigator.pushNamed(
                                  //     context, RouteName.forgotPasswordRoute);
                                },
                              text: ' Recover ',
                              style: GoogleFonts.lato(
                                  color: const Color(0xff7200e0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> errorDialog(BuildContext context, String errorMessage) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.error_sharp, size: 50),
          backgroundColor: const Color(0xff161828),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(
              //     'assets/images/quality.png'), // Replace with your image asset
              const Text(
                textAlign: TextAlign.center,
                'ERROR',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),

              // const Text("Yahoo!"),
              // const SizedBox(height: 20),

              Text(
                '$errorMessage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                      borderRadius: BorderRadius.circular(5)),
                  // color: const Color(0xff1974B3),
                  // borderRadius: BorderRadius.circular(40),

                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.pushNamed(
                      //     context, RouteName.signInRoute);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Okay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> successDialog(BuildContext context, message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // icon: Image.asset('assets/images/quality.png'),
          backgroundColor: const Color(0xff161828),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  'assets/images/quality.png'), // Replace with your image asset
              const Text(
                textAlign: TextAlign.center,
                'CONGRATULATIONS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),

              const Text("Yahoo!"),
              const SizedBox(height: 20),

              Text(
                message,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                      borderRadius: BorderRadius.circular(5)),
                  // color: const Color(0xff1974B3),
                  // borderRadius: BorderRadius.circular(40),

                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.dashboardRoute);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // icon: Image.asset('assets/images/quality.png'),
          backgroundColor: const Color(0xff161828),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  'assets/images/quality.png'), // Replace with your image asset
              const Text(
                textAlign: TextAlign.center,
                'CONGRATULATIONS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),

              const Text("Yahoo!"),
              const SizedBox(height: 20),

              const Text(
                'You have successfully verified Your Account',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                    borderRadius: BorderRadius.circular(5)),
                // color: const Color(0xff1974B3),
                // borderRadius: BorderRadius.circular(40),

                child: MaterialButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
