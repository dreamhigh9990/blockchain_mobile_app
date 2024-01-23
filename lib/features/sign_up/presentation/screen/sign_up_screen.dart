import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/widget/sign_in_widget.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/country_list_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

int id = 0;
String emailForOtpScreen = "";

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<CountryListCubit>().fetchCountryList();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _callingCodeController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _referalCodeController = TextEditingController();
  // final TextEditingController _countryController = TextEditingController();

  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  int country_id = 0;

  callSignUpApi() {
    final String name = _firstNameController.text + _lastNameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String mobile = _mobileController.text;
    final String callingCode = _callingCodeController.text;
    final String referalCode = _referalCodeController.text;

    BlocProvider.of<SignUpCubit>(context).signUp(
      country_id: country_id,
      name: name,
      email: email,
      password: password,
      phone: mobile,
      calling_code: callingCode,
      referral_code: referalCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff7A7A7A),
            ),
          ),
          centerTitle: true,
          title: Text(
            "REGISTRATION",
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        body: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignUpLoading) {
              showAppLoading(context);
            }
            if (state is SignUpError) {
              final error = state.errorMessage;
              final errorMessage = error.toString();

              debugPrint(
                  "Error: $errorMessage"); // Convert the error to a string
              errorDialog(context, errorMessage);
            }

            if (state is SignUpSuccess) {
              final response = state.userData;
              id = int.parse(response['id'].toString());
              log("response:$response");
              log("id:$id");
              print("Success");
              _showCustomDialog(context);
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const SizedBox(height: 10),
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
                        return null;
                      },
                      decoration: InputDecoration(
                          labelStyle: GoogleFonts.lato(
                              color: const Color(0xff7A7A7A),
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                          labelText: "Email",
                          hintText: "Enter your email",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // CountryDropDownScreen(),
                  BlocBuilder<CountryListCubit, CountryListState>(
                    builder: (context, state) {
                      if (state is CountryListLoading) {
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 200,
                        );
                      }
                      if (state is CountryListSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              // title: Text("data"),
                              showSearchBox: true,
                              showSelectedItems: true,

                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: state.countryList
                                .map((country) =>
                                    (country['full_name'] as String?) ??
                                    'Unknown Country')
                                .toList(), // Use the countryNames from the widget
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelStyle: GoogleFonts.lato(
                                    color: const Color(0xff7A7A7A),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                                fillColor:
                                    const Color(0xff181328), // Fill color
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: "Country List",
                                hintText: "Please Select Country",
                              ),
                            ),
                            onChanged: (selectedCountry) {
                              // Find the selected country's mobile code and id
                              final selectedCountryData =
                                  state.countryList.firstWhere(
                                (country) =>
                                    country['full_name'] == selectedCountry,
                                orElse: () => {
                                  'calling_code': '+1',
                                  'id': '0', // Default to ID 0 if not found
                                },
                              );

                              final mobileCode =
                                  selectedCountryData['calling_code'] as String;
                              country_id = int.parse(selectedCountryData['id']);
                              _callingCodeController.text = mobileCode;

                              // Now you can use the `mobileCode` and `country_id` where needed.
                              // Example:
                              debugPrint('Calling Code: $mobileCode');
                              debugPrint('Country ID: $country_id');
                            },
                            selectedItem: "Select country",
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownSearch<String>(
                          enabled: false,
                          // ignore: prefer_const_constructors
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            // disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          items: [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ], // Use the countryNames from the widget
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              fillColor: const Color(0xff181328), // Fill color
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: "Country List",
                              hintText: "Please Select Country",
                            ),
                          ),
                          onChanged: print,
                          selectedItem: "Select country",
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // Uneditable country code
                        Container(
                          width: 60, // Adjust the width as needed
                          child: TextFormField(
                            controller: _callingCodeController,
                            // initialValue:
                            //     '+1', // Initial country code (e.g., +1 for the United States)
                            readOnly: true, // Make it uneditable
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xff181328),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Editable mobile number
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: _mobileController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              ;
                              // You can add more complex validation here
                              // e.g., check if it's a valid mobile number
                              return null;
                            },
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.lato(
                                    color: const Color(0xff7A7A7A),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                                labelText: "Mobile",
                                hintText: "Enter your mobile",
                                fillColor: const Color(0xff181328),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
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
                          labelText: "First Name",
                          hintText: "Enter your first name",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
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
                          labelText: "Last Name",
                          hintText: "Enter your Last name",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
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
                          labelText: "Password",
                          hintText: "Enter your password",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please re-enter your password';
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return 'Password does not match';
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
                        labelText: "Confirm Password",
                        hintText: "Re enter your password",
                        fillColor: const Color(0xff181328), // Fill color
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _referalCodeController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your email/username';
                      //   }
                      //   if (!emailRegex.hasMatch(value)) {
                      //     return 'Invalid email address';
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: GoogleFonts.lato(
                              color: const Color(0xff7A7A7A),
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                          labelText: "Referal Code",
                          hintText: "Enter Referal Code",
                          fillColor: const Color(0xff181328), // Fill color
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                        borderRadius: BorderRadius.circular(5)),
                    // color: const Color(0xff1974B3),
                    // borderRadius: BorderRadius.circular(40),

                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, you can proceed with registration
                          // Extract and use the input data as needed
                          setState(() {
                            emailForOtpScreen = _emailController.text;
                          });
                          callSignUpApi();
                          print(callSignUpApi);
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (_) => CheckOtpScreen()),
                          // );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                        child: Text(
                          "  Sign Up  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: const TextStyle(
                        // color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to the login screen
                              // Navigator.pushNamed(context, RouteName.signInRoute);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => SignInWidget()),
                              );
                            },
                          text: ' Login',
                          style: const TextStyle(
                            color: Color(0xff7200e0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
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
                'Check Your Mail to Verify please',
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
                      Navigator.pushNamed(context, RouteName.checkOtpRoute);
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

  Future<dynamic> errorDialog(BuildContext context, String errorMessage) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error_sharp, size: 50),
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
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                    child: const Text(
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
}
