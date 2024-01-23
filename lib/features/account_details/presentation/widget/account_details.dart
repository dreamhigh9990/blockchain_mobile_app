import 'dart:developer';
import 'dart:io';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/update_user_cubit.dart';
import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/user_info_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/country_list_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _callingCodeController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  // final String name = _fullNameController.text;
  // final String email = _emailController.text;
  // final String password = _passwordController.text;
  // final String mobile = _mobileController.text;
  // final String callingCode = _callingCodeController.text;

  int country_id = 0;
  File? _image;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    BlocProvider.of<UserInfoCubit>(context).getUserInfo();

    BlocProvider.of<CountryListCubit>(context).fetchCountryList();
  }

  double progress = 0.0;
  bool _isLoading = false;
  uploadPic() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("accessToken");

    log("accessToken:$accessToken");
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://blockchainapp.dkingsolution.com/graphql'));
    request.fields.addAll({
      'operations':
          '{ "query": "mutation (\$file: Upload!) { updateAvatar(file: \$file) { message, avatar_url } }", "variables": { "file": null } }',
      'map': '{ "0": ["variables.file"] }'
    });
    request.files.add(await http.MultipartFile.fromPath('0', _image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  String callCodeForUpdate = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoLoading) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: const Color(0xff1974B3),
              secondRingColor: const Color(0xffD9D9D9),
              thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
              size: 50,
            ),
          );
        }
        if (state is UserInfoLoaded) {
          final response = state.userInfo;
          log("$response");

          _fullNameController.text = response['name'] ?? '';
          _emailController.text = response['email'] ?? '';
          _addressController.text = response['address'] ?? '';
          _mobileController.text = response['phone'] ?? '';
          // _callingCodeController.text = response['country_id'] ?? '';
          String cId = response['country_id'] ?? '';
          country_id = int.parse(cId);
          String selectedCountryId = response['country_id'] ?? '';
          return Scaffold(
              appBar: PreferredSize(
                preferredSize:
                    const Size.fromHeight(260), // Adjust the height as needed
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
                      padding:
                          const EdgeInsets.only(top: 54, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          const Text(
                            'Profile & Setting',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          Image.asset("assets/images/down-arrow 6.png"),
                        ],
                      ),
                    ),
                    _isLoading == true
                        ? Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Color(0xff1974B3),
                              secondRingColor: Color(0xffD9D9D9),
                              thirdRingColor:
                                  Color.fromARGB(157, 217, 217, 217),
                              size: 50,
                            ),
                          )
                        : response['avatar'] == ""
                            ? _image == null
                                ? Positioned(
                                    top: 135.0,
                                    left: 150,
                                    child: InkWell(
                                      onTap: () {
                                        selectImage(context);
                                      },
                                      child: Container(
                                        width: 113,
                                        height: 113,
                                        decoration: ShapeDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/no_dp.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 135.0,
                                    left: 150,
                                    child: InkWell(
                                      onTap: () {
                                        selectImage(context);
                                      },
                                      child: Container(
                                        width: 113,
                                        height: 113,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                            : _image == null
                                ? Positioned(
                                    top: 135.0,
                                    left: 150,
                                    child: InkWell(
                                      onTap: () {
                                        selectImage(context);
                                      },
                                      child: Container(
                                        width: 113,
                                        height: 113,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                response['avatar']),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 135.0,
                                    left: 150,
                                    child: InkWell(
                                      onTap: () {
                                        selectImage(context);
                                      },
                                      child: Container(
                                        width: 113,
                                        height: 113,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Jumper PERSONAL USE ONLY',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        response['name'],
                        // ' Wollito',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          // fontFamily: 'Jumper PERSONAL USE ONLY',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        response['email'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          // fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 47,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        // obscureText: obscureTextNewPass,
                        controller: _fullNameController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_2_outlined,
                              color: Color(0xFF7A7A7A),
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
                            labelText: "Name",
                            hintText: "Name",
                            fillColor: const Color(0xff181328), // Fill color
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        // obscureText: obscureTextNewPass,
                        controller: _emailController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xFF7A7A7A),
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
                            labelText: "Email",
                            hintText: "Email",
                            fillColor: const Color(0xff181328), // Fill color
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<CountryListCubit, CountryListState>(
                      builder: (context, state) {
                        if (state is CountryListLoading) {
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 200,
                          );
                        }
                        if (state is CountryListSuccess) {
                          String callingCode = state.countryList
                                  .firstWhere((country) =>
                                      (country['id'] as String?) ==
                                      selectedCountryId)
                                  .containsKey('full_name')
                              ? state.countryList.firstWhere((country) =>
                                  (country['id'] as String?) ==
                                  selectedCountryId)['calling_code']
                              : null;
                          _callingCodeController.text = callingCode;
                          callCodeForUpdate = callingCode;

                          // setState(() {
                          // });
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
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
                                    selectedCountryData['calling_code']
                                        as String;
                                country_id =
                                    int.parse(selectedCountryData['id']);
                                _callingCodeController.text =
                                    mobileCode.toString();
                                callCodeForUpdate = mobileCode;
                                // Now you can use the `mobileCode` and `country_id` where needed.
                                // Example:
                                debugPrint('Calling Code: $mobileCode');
                                debugPrint('Country ID: $country_id');
                              },
                              selectedItem: state.countryList
                                      .firstWhere((country) =>
                                          (country['id'] as String?) ==
                                          selectedCountryId)
                                      .containsKey('full_name')
                                  ? state.countryList.firstWhere((country) =>
                                      (country['id'] as String?) ==
                                      selectedCountryId)['full_name']
                                  : null,
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
                            onChanged: print,
                            selectedItem: _callingCodeController.text,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Color(0xFF7A7A7A),
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
                                  labelText: "Mobile",
                                  hintText: "Mobile",
                                  fillColor:
                                      const Color(0xff181328), // Fill color
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        // obscureText: obscureTextNewPass,
                        controller: _addressController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {},
                        decoration: InputDecoration(
                            // suffixIcon: InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //       // obscureTextNewPass = !obscureTextNewPass;
                            //     });
                            //   },
                            //   child: const Icon(
                            //     Icons.remove_red_eye_outlined,
                            //     color: Color(0xff7A7A7A),
                            //     size: 16,
                            //   ),
                            // ),
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF7A7A7A),
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
                            labelText: "Address",
                            hintText: "Address",
                            fillColor: const Color(0xff181328), // Fill color
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocListener<UpdateUserCubit, UpdateUserState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is UpdateUserLoading) {
                          return showAppLoading(context);
                        }
                        if (state is UpdateUserFailure) {
                          final errorMessage = state.error;
                          errorDialog(context, errorMessage);
                        }

                        if (state is UpdateUserSuccess) {
                          final response = state.message;
                          successDialog(context, response);
                        }
                      },
                      child: Container(
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
                            BlocProvider.of<UpdateUserCubit>(context)
                                .updateUser(
                                    name: _fullNameController.text,
                                    phone: _mobileController.text,
                                    countryId: country_id.toString(),
                                    callingCode: callCodeForUpdate,
                                    address: _addressController.text);

                            log("${_fullNameController.text}");
                            log("${_mobileController.text}}");
                            log("${country_id.toString()}");
                            // log("${_callingCodeController.text}");
                            log("${_addressController.text}");
                            log("${callCodeForUpdate}");
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ));
        }
        return const SizedBox();
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
                    onPressed: () async {
                      // SharedPreferences preferences =
                      //     await SharedPreferences.getInstance();
                      // await preferences.clear();
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

  final ImagePicker _picker = ImagePicker();
  Future getImageGallery() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      // uploaPhoto();
      uploadPic();
    });
    Navigator.of(context).pop();
  }

  Future getImageCamera() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
      // uploaPhoto();
      uploadPic();
    });
    Navigator.of(context).pop();
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Upload Image",
              style: TextStyle(),
            ),
            children: [
              SimpleDialogOption(
                child: const Text("Image from Gallery"),
                onPressed: () {
                  print("Gallery");
                  getImageGallery();
                },
              ),
              SimpleDialogOption(
                child: const Text("Image from Camera"),
                onPressed: () {
                  print("open camera");
                  getImageCamera();
                },
              ),
              SimpleDialogOption(
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
