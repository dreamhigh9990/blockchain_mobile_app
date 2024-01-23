import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:blockchain_mobile_app/features/password_page/presentation/cubit/change_passwod_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool obscureTextCurrentPass = true;
  bool obscureTextNewPass = true;
  bool obscureTextConfirmPass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(109), // Adjust the height as needed
        child: Stack(
          children: [
            Container(
              height: 188,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 54, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      // fontFamily: 'Jumper PERSONAL USE ONLY',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Image.asset("assets/images/down-arrow 6.png"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is ChangePasswordSuccess) {
            final message = state.message;
            successDialog(context, message);
          } else if (state is ChangePasswordLoading) {
            showAppLoading(context);

            // Handle loading state
          } else if (state is ChangePasswordFailure) {
            final errorMessage = state.error;

            log("$errorMessage");
            errorDialog(context, errorMessage);
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Change Your Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _currentPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {},

                  obscureText: obscureTextCurrentPass,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureTextCurrentPass = !obscureTextCurrentPass;
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff7A7A7A),
                          size: 16,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Color(0xff7A7A7A),
                        size: 16,
                      ),
                      labelStyle: GoogleFonts.lato(
                        color: const Color(0xFF7A7A7A),
                        fontSize: 12,
                        // fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.24,
                      ),
                      labelText: "Current Password",
                      hintText: "Current Password",
                      fillColor: const Color(0xff181328), // Fill color
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  obscureText: obscureTextNewPass,
                  controller: _newPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {},
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureTextNewPass = !obscureTextNewPass;
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff7A7A7A),
                          size: 16,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Color(0xff7A7A7A),
                        size: 16,
                      ),
                      labelStyle: GoogleFonts.lato(
                        color: const Color(0xFF7A7A7A),
                        fontSize: 12,
                        // fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.24,
                      ),
                      labelText: "New Password",
                      hintText: "New Password",
                      fillColor: const Color(0xff181328), // Fill color
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  obscureText: obscureTextConfirmPass,
                  controller: _confirmPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {},
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureTextConfirmPass = !obscureTextConfirmPass;
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff7A7A7A),
                          size: 16,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Color(0xff7A7A7A),
                        size: 16,
                      ),
                      labelStyle: GoogleFonts.lato(
                        color: const Color(0xFF7A7A7A),
                        fontSize: 12,
                        // fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.24,
                      ),
                      labelText: "New Password",
                      hintText: "New Password",
                      fillColor: const Color(0xff181328), // Fill color
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'You Can’t Change Password in Next 60 Days',
                    style: TextStyle(
                      color: Color(0xFF9963B7),
                      fontSize: 12,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              // const Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(

                    // color: const Color(0xff1974B3),
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: MaterialButton(
                  onPressed: () {
                    BlocProvider.of<ChangePasswordCubit>(context)
                        .changePassword(_currentPassword.text,
                            _newPassword.text, _confirmPassword.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
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
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    ));
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
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushNamed(context, RouteName.signInRoute);
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
}
