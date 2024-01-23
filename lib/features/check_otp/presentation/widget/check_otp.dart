import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:blockchain_mobile_app/features/check_otp/presentation/cubit/verify_otp_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/resend_otp_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/screen/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class CheckOtpScreen extends StatefulWidget {
  const CheckOtpScreen({super.key});

  @override
  State<CheckOtpScreen> createState() => _CheckOtpScreenState();
}

class _CheckOtpScreenState extends State<CheckOtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  callCheckOtp() {
    BlocProvider.of<VerifyOtpCubit>(context)
        .verifyOtp(id: id, model_type: "email", otp: pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white, // Change text color to black
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
          color:
              const Color(0xff1F2033) // Change input background color to white
          ),
    );
    return Scaffold(
      backgroundColor: const Color(0xff1F2033),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff7A7A7A),
          ),
        ),
        centerTitle: true,
        title: Text(
          "CHECK OTP",
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        actions: [Image.asset("assets/images/messenger.png")],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VerifyOtpCubit, VerifyOtpState>(
            listener: (context, state) {
              // TODO: implement listener

              if (state is VerifyOtpLoading) {
                showAppLoading(context);
              }
              if (state is VerifyOtpError) {
                final error = state.errorMessage;
                final errorMessage = error.toString();
                errorDialog(context, errorMessage);

                debugPrint(
                    "Error:$errorMessage "); // Convert the error to a string
                // showAppDialog(context, message: errorMessage, title: "Error");
              }

              if (state is VerifyOtpSuccess) {
                final response = state.message;

                debugPrint("Success");
                log("response:$response");
                _showCustomDialog(context);
              }
            },
          ),
          BlocListener<ResendOtpCubit, ResendOtpState>(
            listener: (context, state) {
              if (state is ResendOtpLoading) {
                showAppLoading(context);

                // Handle loading state
              } else if (state is ResendOtpSuccess) {
                final otpResendResponse = state.otpResendResponse;

                final message = state.otpResendResponse['message'];
                print(message);
                print(otpResendResponse);
                successDialog(context, message);

                // Handle success state
                // Do something with the response
              } else if (state is ResendOtpError) {
                // Handle error state
                final errorMessage = state.errorMessage;

                log("$errorMessage");
                errorDialog(context, errorMessage);

                // Handle the error
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 284,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                          text: 'VERIFICATION CODE',
                          style: GoogleFonts.lato(

                              // color: Colors.black,
                              fontSize: 16,
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
                                text: ' (SMS)',
                                style: GoogleFonts.lato(
                                    color: const Color(0xff7200e0),
                                    fontSize: 16,
                                    // foreground: Paint().shader = gradient
                                    //     .createShader(Rect.fromLTWH(0, 0, 100, 0)),
                                    fontWeight: FontWeight.w500))
                          ]),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Please enter the 6 Digit Code Sent to $emailForOtpScreen ",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff7A7A7A))),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Text("Please check and verify"),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      // validator: (value) {
                      //   // return value == '123456' ? null : 'Pin is incorrect';
                      // },
                      // onClipboardFound: (value) {
                      //   debugPrint('onClipboardFound: ');
                      //   pinController.setText(value);
                      // },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: ');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: ');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      length: 6,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<ResendOtpCubit>(context)
                        .resendOtp(email: emailForOtpScreen);
                  },
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff9963B7)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                      borderRadius: BorderRadius.circular(5)),
                  // color: const Color(0xff1974B3),
                  // borderRadius: BorderRadius.circular(40),

                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        focusNode.unfocus();
                        formKey.currentState!.validate();
                        callCheckOtp();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                      child: Text(
                        "  Confirm  ",
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
                      // Navigator.pushNamed(context, RouteName.signInRoute);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                      Navigator.pushNamed(context, RouteName.signInRoute);
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
