// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:blockchain_mobile_app/features/presentation/cubit/currency_list/currency_list_cubit.dart';
import 'package:blockchain_mobile_app/features/presentation/cubit/referral_earning_summary_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReferalScreen extends StatefulWidget {
  const ReferalScreen({super.key});

  @override
  State<ReferalScreen> createState() => _ReferalScreenState();
}

class _ReferalScreenState extends State<ReferalScreen> {
  final TextEditingController _callingCodeController = TextEditingController();
  String dataSymbol = '';
  @override
  void initState() {
    BlocProvider.of<ReferralEarningSummaryCubit>(context)
        .getReferralEarningSummary();
    BlocProvider.of<CurrencyListCubit>(context).fetchCurrencyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralEarningSummaryCubit,
        ReferralEarningSummaryState>(
      builder: (context, state) {
        if (state is ReferralEarningSummaryLoading) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: const Color(0xff1974B3),
              secondRingColor: const Color(0xffD9D9D9),
              thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
              size: 50,
            ),
          );
        }
        if (state is ReferralEarningSummarySuccess) {
          final summary = state.referralEarningSummary;

          log("$summary");
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              title: const Text(
                'Referral Bonus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // fontFamily: 'Jumper PERSONAL USE ONLY',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              actions: [
                Image.asset("assets/images/messenger2.png"),
                const SizedBox(
                  width: 10,
                )
                // Image.asset("assets/images/settings.png")
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: 350,
                      // height: 154,
                      decoration: ShapeDecoration(
                        color: const Color(0xff6600EF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Total Earned',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            // fontFamily: 'Jumper PERSONAL USE ONLY',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        // Text(
                                        //   '$dataSymbol',
                                        //   style: const TextStyle(
                                        //     color: Colors.white,
                                        //     fontSize: 18,
                                        //     // fontFamily: 'Lato',
                                        //     fontWeight: FontWeight.w400,
                                        //     // height: 0.14,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 180,
                                          child: BlocBuilder<CurrencyListCubit,
                                              CurrencyListState>(
                                            builder: (context, state) {
                                              if (state
                                                  is CurrencyListLoading) {
                                                LoadingAnimationWidget
                                                    .staggeredDotsWave(
                                                  color: Colors.white,
                                                  size: 200,
                                                );
                                              }
                                              if (state
                                                  is CurrencyListSuccess) {
                                                // final c = state.currencyList
                                                //     .map((currency) =>
                                                //         (currency['name']
                                                //             as String?) ??
                                                //         'Unknown Currency');
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30.0),
                                                  child: DropdownSearch<String>(
                                                    popupProps:
                                                        const PopupProps.menu(
                                                      showSearchBox: true,
                                                      showSelectedItems: true,
                                                    ),
                                                    items: state.currencyList
                                                        .map((currency) =>
                                                            (currency['code']
                                                                as String?) ??
                                                            'Unknown Currency')
                                                        .toList(), // Use the countryNames from the widget
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        labelStyle:
                                                            GoogleFonts.lato(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    196,
                                                                    168,
                                                                    168),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 12),
                                                        fillColor: const Color(
                                                            0xff6600EF), // Fill color
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        labelText:
                                                            "Currency List",
                                                        hintText:
                                                            "Please Select Currency",
                                                      ),
                                                    ),
                                                    onChanged:
                                                        (selectedCurrency) {
                                                      setState(() {
                                                        summary['code'] =
                                                            selectedCurrency;

                                                        final currencyValue =
                                                            state.currencyList
                                                                .firstWhere(
                                                          (currency) =>
                                                              (currency['code']
                                                                  as String?) ==
                                                              selectedCurrency,
                                                          orElse: () => {
                                                            // Default to ID 0 if not found
                                                          },
                                                        );

                                                        if (currencyValue !=
                                                            null) {
                                                          final symbolCCC =
                                                              currencyValue[
                                                                      'symbol']
                                                                  as String;
                                                          dataSymbol =
                                                              symbolCCC;
                                                          print(symbolCCC);
                                                        } else {
                                                          // Handle the case where the selected currency is not found
                                                          print(
                                                              'Currency not found for $selectedCurrency');
                                                        }
                                                      });
                                                    },

                                                    // selectedItem: state.currencyList
                                                    //         .firstWhere((name) =>
                                                    //             (name['name']
                                                    //                 as String?) ==
                                                    //             name)
                                                    //         .containsKey(
                                                    //             'name'): null,
                                                    // ? state.currencyList
                                                    //     .firstWhere((name) =>
                                                    //         (name['id']
                                                    //             as String?) ==
                                                    //         name)['name']
                                                    // : null,
                                                  ),
                                                );
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0),
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
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      fillColor: const Color(
                                                          0xff181328), // Fill color
                                                      filled: true,
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      labelText: "Currency",
                                                      hintText: "Currency",
                                                    ),
                                                  ),
                                                  onChanged: print,
                                                  selectedItem:
                                                      _callingCodeController
                                                          .text,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 20),
                              child: Row(
                                children: [
                                  Text(
                                    '$dataSymbol',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      // fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    '${summary['total']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 10, bottom: 5),
                              child: Text(
                                'Last Week Earning :',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  height: 0.14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$dataSymbol',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            // fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          '${summary['last_week_earning']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            // fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  Text(
                                    'Total Referred : ${summary['total_referred']} ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      // height: 0.14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Refer & Get \ USD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 25),
                    child: Text(
                      'Unlimted Bonus For You and Your Friends',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0.14,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 12),
                    child: TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.lato(
                            color: const Color(0xff7A7A7A),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                        labelText:
                            "Your Referral Code ", // Change "Phone Number" to "Password"
                        hintText: "Your Referral Code ", // Adjust hint text
                        fillColor: const Color(0xff181328), // Fill color
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        // prefixIcon: Icon(
                        //   Icons.search,
                        //   color: Colors.white.withOpacity(0.5),
                        //   size: 16,
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          // color: const Color(0xff1974B3),
                          gradient: const LinearGradient(
                              colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                          borderRadius: BorderRadius.circular(5)),
                      child: MaterialButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   final userName = _emailController.text;
                          //   final password = _passwordController.text;
                          //   print("$userName and $password");
                          // Form is valid, you can proceed with login
                          // final email = _emailController.text;
                          // final password = _passwordController.text;

                          // // Perform your login logic here
                          // BlocProvider.of<LoginCubit>(context).login(
                          //     email: _emailController.text,
                          //     password: _passwordController.text,
                          //     device: "app");
                          // }
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(140, 20, 140, 20),
                          child: Text(
                            "Agree",
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
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF9963B7)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.share, color: Color(0xFF9963B7)),
                              Text(
                                "Share Referral Link with Friends",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }

        return Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xff1974B3),
            secondRingColor: const Color(0xffD9D9D9),
            thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
            size: 50,
          ),
        );
      },
    );
  }
}
