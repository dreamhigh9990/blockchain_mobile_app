import 'dart:convert';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/cubit/asset_details_cubit.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/widget/assets.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Item 1',
      'subtitle': 'Subtitle 1',
      'graphData': 'Graph Data 1',
      'price': 100.0,
    },
    {
      'name': 'Item 2',
      'subtitle': 'Subtitle 2',
      'graphData': 'Graph Data 2',
      'price': 200.0,
    },
    {
      'name': 'Item 3',
      'subtitle': 'Subtitle 3',
      'graphData': 'Graph Data 3',
      'price': 300.0,
    },
    {
      'name': 'Item 4',
      'subtitle': 'Subtitle 4',
      'graphData': 'Graph Data 4',
      'price': 400.0,
    },
    {
      'name': 'Item 5',
      'subtitle': 'Subtitle 5',
      'graphData': 'Graph Data 5',
      'price': 500.0,
    },
    {
      'name': 'Item 1',
      'subtitle': 'Subtitle 1',
      'graphData': 'Graph Data 1',
      'price': 100.0,
    },
    {
      'name': 'Item 2',
      'subtitle': 'Subtitle 2',
      'graphData': 'Graph Data 2',
      'price': 200.0,
    },
    {
      'name': 'Item 3',
      'subtitle': 'Subtitle 3',
      'graphData': 'Graph Data 3',
      'price': 300.0,
    },
    {
      'name': 'Item 4',
      'subtitle': 'Subtitle 4',
      'graphData': 'Graph Data 4',
      'price': 400.0,
    },
    {
      'name': 'Item 5',
      'subtitle': 'Subtitle 5',
      'graphData': 'Graph Data 5',
      'price': 500.0,
    },
    {
      'name': 'Item 1',
      'subtitle': 'Subtitle 1',
      'graphData': 'Graph Data 1',
      'price': 100.0,
    },
    {
      'name': 'Item 2',
      'subtitle': 'Subtitle 2',
      'graphData': 'Graph Data 2',
      'price': 200.0,
    },
    {
      'name': 'Item 3',
      'subtitle': 'Subtitle 3',
      'graphData': 'Graph Data 3',
      'price': 300.0,
    },
    {
      'name': 'Item 4',
      'subtitle': 'Subtitle 4',
      'graphData': 'Graph Data 4',
      'price': 400.0,
    },
    {
      'name': 'Item 5',
      'subtitle': 'Subtitle 5',
      'graphData': 'Graph Data 5',
      'price': 500.0,
    },
  ];

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
              Navigator.pop(context);
            },
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Dashboard()));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          title: const Text(
            'Track Coins',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Jumper PERSONAL USE ONLY',
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
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .21,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // controller: _scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 136,
                      // height: 138,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF161828),
                        // color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index.isOdd
                                ? Container(
                                    width: 35,
                                    height: 35,
                                    child: Image.asset(
                                        "assets/images/cronos 4.png"))
                                : Container(
                                    width: 35,
                                    height: 35,
                                    child: Image.asset(
                                        "assets/images/cronos 1.png")),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Cronos Ecosystem',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                // fontFamily: 'Jumper PERSONAL USE ONLY',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/cronos 2.png"),
                                const Text(
                                  '+9.02%',
                                  style: TextStyle(
                                    color: Color(0xFF61DA01),
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/cronos 3.png"),
                                const Text(
                                  '+9.02%',
                                  style: TextStyle(
                                    color: Color(0xFFC80000),
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter your password';
                //   }
                //   // You can add more complex password validation here
                //   // e.g., check for a minimum length
                //   return null;
                // },
                // controller: _passwordController,
                decoration: InputDecoration(
                    labelStyle: GoogleFonts.lato(
                        color: const Color(0xff7A7A7A),
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                    labelText: "Search", // Change "Phone Number" to "Password"
                    hintText: "Search Coins here ..", // Adjust hint text
                    fillColor: const Color(0xff181328), // Fill color
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.5),
                      size: 16,
                    )),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 19,
                  ),
                  Container(
                    width: 118,
                    height: 34,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'All Assets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          // height: 0.14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 118,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    child: Center(
                      child: const Text(
                        'Top Traded',
                        style: TextStyle(
                          color: Color(0xA77A7A7A),
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          // height: 0.14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 118,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    child: Center(
                      child: const Text(
                        'Top Gainers',
                        style: TextStyle(
                          color: Color(0xA77A7A7A),
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          // height: 0.14,
                        ),
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
              ),
            ),
          ],
        ),
      ),
    );
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
                      // CryptoPriceWidget(
                      //     // symbol.symbol!
                      //     symbol),
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
          //     symbol);
        },
      ),
    );
  }
}
