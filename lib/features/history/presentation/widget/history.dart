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
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // final List<Map<String, dynamic>> items = [
  //   {
  //     'name': 'Item 1',
  //     'subtitle': 'Subtitle 1',
  //     'graphData': 'Graph Data 1',
  //     'price': 100.0,
  //   },
  //   {
  //     'name': 'Item 2',
  //     'subtitle': 'Subtitle 2',
  //     'graphData': 'Graph Data 2',
  //     'price': 200.0,
  //   },
  //   {
  //     'name': 'Item 3',
  //     'subtitle': 'Subtitle 3',
  //     'graphData': 'Graph Data 3',
  //     'price': 300.0,
  //   },
  //   {
  //     'name': 'Item 4',
  //     'subtitle': 'Subtitle 4',
  //     'graphData': 'Graph Data 4',
  //     'price': 400.0,
  //   },
  //   {
  //     'name': 'Item 5',
  //     'subtitle': 'Subtitle 5',
  //     'graphData': 'Graph Data 5',
  //     'price': 500.0,
  //   },
  //   {
  //     'name': 'Item 1',
  //     'subtitle': 'Subtitle 1',
  //     'graphData': 'Graph Data 1',
  //     'price': 100.0,
  //   },
  //   {
  //     'name': 'Item 2',
  //     'subtitle': 'Subtitle 2',
  //     'graphData': 'Graph Data 2',
  //     'price': 200.0,
  //   },
  //   {
  //     'name': 'Item 3',
  //     'subtitle': 'Subtitle 3',
  //     'graphData': 'Graph Data 3',
  //     'price': 300.0,
  //   },
  //   {
  //     'name': 'Item 4',
  //     'subtitle': 'Subtitle 4',
  //     'graphData': 'Graph Data 4',
  //     'price': 400.0,
  //   },
  //   {
  //     'name': 'Item 5',
  //     'subtitle': 'Subtitle 5',
  //     'graphData': 'Graph Data 5',
  //     'price': 500.0,
  //   },
  //   {
  //     'name': 'Item 1',
  //     'subtitle': 'Subtitle 1',
  //     'graphData': 'Graph Data 1',
  //     'price': 100.0,
  //   },
  //   {
  //     'name': 'Item 2',
  //     'subtitle': 'Subtitle 2',
  //     'graphData': 'Graph Data 2',
  //     'price': 200.0,
  //   },
  //   {
  //     'name': 'Item 3',
  //     'subtitle': 'Subtitle 3',
  //     'graphData': 'Graph Data 3',
  //     'price': 300.0,
  //   },
  //   {
  //     'name': 'Item 4',
  //     'subtitle': 'Subtitle 4',
  //     'graphData': 'Graph Data 4',
  //     'price': 400.0,
  //   },
  //   {
  //     'name': 'Item 5',
  //     'subtitle': 'Subtitle 5',
  //     'graphData': 'Graph Data 5',
  //     'price': 500.0,
  //   },
  // ];

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
          'List All Receipts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            // fontFamily: 'Jumper PERSONAL USE ONLY',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingAndProfile(
                            // assetDetailsResponse: response,
                            )));
              },
              child: Image.asset("assets/images/settings.png")),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              obscureText: false,
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
                  hintText: "Search", // Adjust hint text
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
          Expanded(child: BlocBuilder<BitcoinListCubit, BitcoinListState>(
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
          BlocProvider.of<AssetDetailsCubit>(context).assetDetails(
              // symbol.symbol!
              symbol);
        },
      ),
    );
  }
}
