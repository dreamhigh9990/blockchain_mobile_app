import 'dart:convert';
import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/cubit/asset_details_cubit.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/widget/assets.dart';
import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/widget/buy_bitcoin.dart';
import 'package:blockchain_mobile_app/features/buy_crypto_screen/presentation/buy_sell_screen.dart';
import 'package:blockchain_mobile_app/features/fiat_currency/presentation/fiat_currency_screen.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/cubit/toral_balance_cubit.dart';
// import 'package:blockchain_mobile_app/features/home/presentation/screen/cryp_prices.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/crypto_prices.dart';
import 'package:blockchain_mobile_app/features/mission/presentation/mission.dart';
import 'package:blockchain_mobile_app/features/presentation/screen/referal_screen.dart';
import 'package:blockchain_mobile_app/features/reward/presentaion/reward_screen.dart';
import 'package:blockchain_mobile_app/features/send_payment/presentation/widget/send_payment.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/widget/sign_in_widget.dart';
import 'package:blockchain_mobile_app/features/track/track_screen.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/widget/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TotalBalanceCubit>(context).getTotalBalance();
    callBitcoinListApi();
  }

  callBitcoinListApi() {
    BlocProvider.of<BitcoinListCubit>(context).bitcoinList();
  }

  bool seeAllAsset = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalBalanceCubit, TotalBalanceState>(
      builder: (context, state) {
        if (state is TotalBalanceLoading) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Color(0xff1974B3),
              secondRingColor: Color(0xffD9D9D9),
              thirdRingColor: Color.fromARGB(157, 217, 217, 217),
              size: 50,
            ),
          );
        }
        if (state is TotalBalanceSuccess) {
          final totalBalance = state.totalBalance;
          log("dfdf$totalBalance");
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    collapsedHeight: 200,
                    leading: InkWell(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Image.asset("assets/images/drawer_icon.png")),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Container(
                          width: 95,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0x82425AF1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/diamond.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Mission")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingAndProfile(
                                            // assetDetailsResponse: response,
                                            )));
                          },
                          child: Image.asset("assets/images/settings.png")),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                    backgroundColor: Colors.transparent,
                    expandedHeight: 300.0,
                    floating: false,
                    flexibleSpace: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned(
                                left: 30,
                                right: 30,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    width: 350,
                                    height: 237,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xff6600EF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total Balance',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                Text(
                                                  'USD',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 20),
                                            child: Text(
                                              '\$ ${totalBalance['total_balance']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 32,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, bottom: 20),
                                            child: Text(
                                              '0.00 %',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                height: 0.14,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, bottom: 10),
                                            child: Text(
                                              '0.00 %',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                height: 0.14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 45,
                                right: 45,
                                child: Center(
                                  child: Container(
                                    width: 322,
                                    height: 52,
                                    decoration: ShapeDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment(1.00, -0.03),
                                        end: Alignment(-1, 0.03),
                                        colors: [
                                          Color(0xff7d32f2),
                                          Color(0xff7100F0),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(83),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const BuySellScreen()));
                                            },
                                            child: Image.asset(
                                                "assets/images/user(5)1.png"),
                                          ),
                                        ),
                                        VerticalDivider(
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 3,
                                          color: Colors.white
                                              .withOpacity(0.4000000059604645),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const BuySellScreen()));
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             SellCryptoCoin()));
                                            },
                                            child: Image.asset(
                                                "assets/images/user(5)2.png")),
                                        VerticalDivider(
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 3,
                                          color: Colors.white
                                              .withOpacity(0.4000000059604645),
                                        ),
                                        Image.asset(
                                            "assets/images/user(5)3.png"),
                                        VerticalDivider(
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 3,
                                          color: Colors.white
                                              .withOpacity(0.4000000059604645),
                                        ),
                                        Image.asset(
                                            "assets/images/user(5)4.png"),
                                        VerticalDivider(
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 3,
                                          color: Colors.white
                                              .withOpacity(0.4000000059604645),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                              "assets/images/user(5)5.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Fav Assets',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              seeAllAsset = !seeAllAsset;
                            });
                          },
                          child: seeAllAsset == false
                              ? const Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Color(0xFF9963B7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const Text(
                                  'See top assets',
                                  style: TextStyle(
                                    color: Color(0xFF9963B7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: BlocBuilder<BitcoinListCubit, BitcoinListState>(
                    builder: (context, state) {
                      // if (state is BitcoinListSuccess) {
                      //   print("in bitcoin success");
                      //   final response = state.bitcoinListResponse;
                      //   return ListView.builder(
                      //     itemCount: response.symbols!.length,
                      //     itemBuilder: (context, index) {
                      //       print(response.symbols!.length);
                      //       final symbol = response.symbols![index];
                      //       return listItems(symbol, index);
                      //     },
                      //   );
                      // }

                      if (state is BitcoinListSuccess) {
                        if (seeAllAsset == false) {
                          print("in bitcoin success");
                          final List<BitcoinListResponse> response =
                              state.bitcoinListResponse;

                          // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                          response.sort((a, b) =>
                              (double.parse(b.quoteVolume ?? "0")).compareTo(
                                  double.parse(a.quoteVolume ?? "0")));

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
                          response.sort((a, b) =>
                              (double.parse(b.quoteVolume ?? "0")).compareTo(
                                  double.parse(a.quoteVolume ?? "0")));

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
                          thirdRingColor:
                              const Color.fromARGB(157, 217, 217, 217),
                          size: 50,
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
            drawer: const CommonDrawer(),
          );
        }
        return const SizedBox();
      },
    );
  }

  // Widget listItems(Symbol symbol, int index) {
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
                      /////////////////////////////
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
                      // CrypPage(
                      //   symbol: symbol,
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
          BlocProvider.of<AssetDetailsCubit>(context).assetDetails(
              // symbol.symbol!
              symbol);
        },
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF161828),
      width: 184,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.white.withOpacity(.5),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Trade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Wallet()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/crypto.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Crypto Wallet',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TrackScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Track',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FiatCurencyScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1 (1).png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Fiat Wallet',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuyBitCoin()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1 (2).png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Recurring Buy',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Row(
                children: [
                  Image.asset("assets/images/icons8_user_96px_2 1 (3).png"),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Target Price',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Spend',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SendPayment()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/pay.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Pay',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 21),
            //   child: Text(
            //     'Finance',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       height: 0.14,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/supercharger.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Supercharger',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/earn.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Earn',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/staking.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Staking',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 21,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Bonus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MissionScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/mission.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Mission',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RewardScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/reward.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Reward',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReferalScreen()));
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/reffer.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Refer',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 21),
            //   child: Text(
            //     'More',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       height: 0.14,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/cryptooo.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Crypto.com NFT',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/university.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'University',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingAndProfile()));
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/settings.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Setting',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white.withOpacity(.5),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SignInWidget()));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
