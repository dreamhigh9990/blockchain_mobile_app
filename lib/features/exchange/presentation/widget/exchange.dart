import 'dart:convert';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/cubit/asset_details_cubit.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/widget/assets.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/crypto_prices.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  bool seeAllAsset = false;
  @override
  void initState() {
    super.initState();

    callBitcoinListApi();
  }

  callBitcoinListApi() {
    BlocProvider.of<BitcoinListCubit>(context).bitcoinList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Dashboard()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        title: const Text(
          'Exchange',
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
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingAndProfile(
                            // assetDetailsResponse: response,
                            )));
              },
              child: Image.asset("assets/images/settings.png")),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     // width: 350,
          //     // height: 154,
          //     decoration: ShapeDecoration(
          //       color: const Color(0xff6600EF),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(14),
          //       ),
          //     ),
          //     child: const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Column(
          //         // mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: EdgeInsets.all(10.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Total Earned',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 14,
          //                     // fontFamily: 'Jumper PERSONAL USE ONLY',
          //                     fontWeight: FontWeight.w400,
          //                     height: 0,
          //                   ),
          //                 ),
          //                 Text(
          //                   'USD',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 12,
          //                     // fontFamily: 'Lato',
          //                     fontWeight: FontWeight.w400,
          //                     // height: 0.14,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 10, bottom: 20),
          //             child: Text(
          //               '\$4,6842.45',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 32,
          //                 fontFamily: 'Lato',
          //                 fontWeight: FontWeight.w700,
          //                 height: 0,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 5),
          //             child: Text(
          //               'Last Week Earning :',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //                 fontFamily: 'Lato',
          //                 fontWeight: FontWeight.w400,
          //                 height: 0.14,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(bottom: 10),
          //             child: Row(
          //               children: [
          //                 Padding(
          //                   padding: EdgeInsets.only(
          //                     left: 10.0,
          //                   ),
          //                   child: Text(
          //                     '\$112.33',
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 16,
          //                       // fontFamily: 'Lato',
          //                       fontWeight: FontWeight.w700,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Spacer(),
          //                 Icon(
          //                   Icons.person,
          //                   color: Colors.white,
          //                   size: 12,
          //                 ),
          //                 Text(
          //                   'Total Referred : 1 ',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 12,
          //                     fontFamily: 'Lato',
          //                     fontWeight: FontWeight.w400,
          //                     // height: 0.14,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           // SizedBox(
          //           //   height: 10,
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(child: BlocBuilder<BitcoinListCubit, BitcoinListState>(
            builder: (context, state) {
              if (state is BitcoinListSuccess) {
                if (seeAllAsset == false) {
                  print("in bitcoin success");
                  final List<BitcoinListResponse> response =
                      state.bitcoinListResponse;

                  // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                  response.sort((a, b) => (double.parse(b.quoteVolume ?? "0"))
                      .compareTo(double.parse(a.quoteVolume ?? "0")));

                  // Take the top 15 items
                  final top15 = response.take(15).toList();
                  // log("top 15:${json.encode(top15)}");
                  return ListView.builder(
                    itemCount: top15.length,
                    itemBuilder: (context, index) {
                      final symbol = top15[index].symbol;
                      return listItems(symbol!, index);
                    },
                  );
                } else {
                  print("in bitcoin success");
                  final List<BitcoinListResponse> response =
                      state.bitcoinListResponse;

                  // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                  response.sort((a, b) => (double.parse(b.quoteVolume ?? "0"))
                      .compareTo(double.parse(a.quoteVolume ?? "0")));

                  // Take the top 15 items
                  // final top15 = response.take(15).toList();
                  // log("top 15:${json.encode(top15)}");
                  return ListView.builder(
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      final symbol = response[index].symbol;
                      return listItems(symbol!, index);
                    },
                  );
                }
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
          )),
        ],
      ),
    ));
  }

  Widget listItems(String symbol, int index) {
    return BlocListener<AssetDetailsCubit, AssetDetailsState>(
      listener: (context, state) {
        if (state is AssetDetailsSuccess) {
          debugPrint("In AssetDetailsSuccess");
          final response = state.assetDetailsResponse;

          debugPrint("${json.decode(json.encode(response))}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Assets(
                        assetDetailsResponse: response,
                      )));
        }
        if (state is AssetDetailsLoading) {
          showAppLoading(context);
        }
        if (state is AssetDetailsFailure) {
          final ex = state.exception;
          print(ex);
          if (ex is ServerException) {
            debugPrint("In ServerException");
            debugPrint("${ex.statusCode}");
          }
        }
      },
      child: ListTile(
        leading: index.isEven
            ? Image.asset("assets/images/bitcoin2.png")
            : Image.asset("assets/images/bitcoin1.png"),
        title: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        // symbol.symbol!,
                        symbol,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.28,
                        ),
                      ),
                      CryptoPriceWidget(
                          // symbol.symbol!
                          symbol),
                      // Text(
                      //   symbol.symbol!,
                      //   style: const TextStyle(
                      //     color: Color(0xFF7A7A7A),
                      //     fontSize: 10,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.w400,
                      //     height: 0,
                      //     letterSpacing: 0.20,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 2, child: Image.asset("assets/images/Group.png")),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // symbol.symbol!,
                        symbol,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.28,
                        ),
                      ),
                      const Text(
                        '\.345}',
                        style: TextStyle(
                          color: Color(0xFF61DA01),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        onTap: () {
          // BlocProvider.of<AssetDetailsCubit>(context).assetDetails(
          //     // symbol.symbol!
          //     symbol);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 400,
                color: const Color.fromARGB(255, 26, 1, 41),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Exchange funds to transfer",
                        style: TextStyle(fontSize: 24),
                      ),
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 15, top: 25),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          autocorrect: true,
                          decoration:
                              InputDecoration(hintText: '  Enter Amount'),
                        ),
                      )),
                      const Text(
                        "From cryto wallet",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Row(children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: 33,
                                    color: const Color.fromARGB(255, 74, 1, 87),
                                    child: Center(child: Text(symbol)))),
                            const Expanded(
                                flex: 6,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("87695457")))
                          ]),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => successDialog(context),
                        child: Container(
                          width: 350,
                          height: 54,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                            ),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          // ignore: prefer_const_constructors
                          child: Center(
                              child: const Text(
                            'Deposit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<dynamic> successDialog(
    BuildContext context,
  ) {
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

              const Text("Deposit done successfully"),
              const SizedBox(height: 20),

              Text(
                "",
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Dashboard()));
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
