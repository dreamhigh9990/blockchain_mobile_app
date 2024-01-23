// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/cubit/purchase_cubit.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/presentation/cubit/currency_list/currency_list_cubit.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BuyBitCoin extends StatefulWidget {
  const BuyBitCoin({super.key});

  @override
  State<BuyBitCoin> createState() => _BuyBitCoinState();
}

String selectedSymbol = '';
late WebSocketChannel channel;
String livePrice = '';
double? amount;
double? totalLivePrice;

class _BuyBitCoinState extends State<BuyBitCoin> {
  final TextEditingController _callingCodeController = TextEditingController();
  String dataSymbol = '\$';
  callBitcoinListApi() {
    BlocProvider.of<BitcoinListCubit>(context).bitcoinList();
    BlocProvider.of<CurrencyListCubit>(context).fetchCurrencyList();
    super.initState();
  }

  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    amount = 0.0;
    // TODO: implement initState
    callBitcoinListApi();
    amountController = TextEditingController(text: "0.0");
    try {
      channel = IOWebSocketChannel.connect(
          'wss://stream.binance.com:9443/ws/btcusdt@trade');

      // Listen for incoming messages (price updates) and update the UI
      channel.stream.listen(
        (message) {
          try {
            print('Received: $message');
            setState(() {
              livePrice = _parsePriceFromWebSocketMessage(message);
              if (amount != null) {
                // Calculate the totalLivePrice when both amount and livePrice are available
                totalLivePrice = amount! * double.parse(livePrice);
              }
            });
            // Update your UI with the live price
          } catch (e) {
            print('Error in message processing: $e');
            // Handle the exception as needed (e.g., show an error message)
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          // Handle WebSocket error as needed (e.g., show an error message)
        },
        onDone: () {
          print('WebSocket connection closed');
          // Handle WebSocket connection closure as needed
        },
      );
    } catch (e) {
      print('Error setting up WebSocket connection: $e');
      // Handle the exception as needed (e.g., show an error message)
    }

    super.initState();
  }

  String _parsePriceFromWebSocketMessage(String message) {
    // Parse the JSON message
    final Map<String, dynamic> json = jsonDecode(message);

    // Access the price field
    final String price = json['p'].toString();

    return price;
  }

  double _parsePriceFromWebSocketMessageDouble(double message) {
    // Parse the JSON message
    final Map<String, dynamic> json = jsonDecode(message.toString());

    // Access the price field
    final double price = json['p'];

    return price;
  }

  // String selectedCurrency = "BTC";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Buy Bitcoin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              // fontFamily: 'Jumper PERSONAL USE ONLY',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingAndProfile()));
                },
                child: Image.asset("assets/images/setting.png")),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: BlocListener<PurchaseCubit, PurchaseState>(
          listener: (context, state) {
            // TODO: implement listener

            if (state is PurchaseLoading) {
              return showAppLoading(context);
            }

            if (state is PurchaseSuccess) {
              final response = state.message;
              successDialog(context, response);
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 189,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF425AF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'BITCOIN PRICE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  // height: 0.14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    dataSymbol,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      // fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                        width: 50,
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          controller: amountController,
                                          onChanged: (value) {
                                            setState(() {
                                              amount = double.tryParse(value);
                                              // Recalculate totalLivePrice when amount changes
                                              if (amount != null) {
                                                totalLivePrice = amount! *
                                                    double.parse(livePrice);
                                              }
                                            });
                                          },
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      width: 130,
                                      height: 60,
                                      child: BlocBuilder<BitcoinListCubit,
                                          BitcoinListState>(
                                        builder: (context, state) {
                                          if (state is BitcoinListSuccess) {
                                            print("in bitcoin success");
                                            final List<BitcoinListResponse>
                                                response =
                                                state.bitcoinListResponse;

                                            // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                                            response.sort((a, b) =>
                                                (double.parse(
                                                        b.quoteVolume ?? "0"))
                                                    .compareTo(double.parse(
                                                        a.quoteVolume ?? "0")));

                                            // Take the top 15 items
                                            final top15 =
                                                response.take(15).toList();
                                            selectedSymbol = top15.isNotEmpty
                                                ? top15.first.symbol!
                                                : "";
                                            // print(selectedSymbol);
                                            return DropdownSearch<String>(
                                              enabled: true,
                                              // ignore: prefer_const_constructors
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                showSelectedItems: true,
                                                // disabledItemFn: (String s) => s.startsWith('I'),
                                              ),
                                              items: top15
                                                  .map((item) =>
                                                      "${item.symbol}")
                                                  .toList(),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelStyle: GoogleFonts.lato(
                                                      color: const Color(
                                                          0xff7A7A7A),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                  // fillColor: const Color(
                                                  //     0xff181328), // Fill color
                                                  // filled: true,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  // labelText: "Top 15 Symbols",
                                                  hintText: "Select Symbol",
                                                  hintStyle: GoogleFonts.lato(
                                                      color: const Color(
                                                          0xff7A7A7A),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              // Set the selectedItem property
                                              selectedItem: selectedSymbol,
                                              // Update the selected item when it changes
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSymbol = value!;
                                                  print(selectedSymbol);

                                                  // Close the previous WebSocket connection, if any
                                                  if (channel != null) {
                                                    channel.sink.close();
                                                  }

                                                  // Open a new WebSocket connection for the selected symbol
                                                  try {
                                                    channel = IOWebSocketChannel
                                                        .connect(
                                                      'wss://stream.binance.com:9443/ws/${selectedSymbol.toLowerCase()}@trade',
                                                    );

                                                    // Listen for incoming messages (price updates) and update the UI
                                                    channel.stream.listen(
                                                      (message) {
                                                        try {
                                                          print(
                                                              'Received: $message');
                                                          setState(() {
                                                            livePrice =
                                                                _parsePriceFromWebSocketMessage(
                                                                    message);
                                                            if (amount !=
                                                                null) {
                                                              // Calculate the totalLivePrice when both amount and livePrice are available
                                                              totalLivePrice =
                                                                  amount! *
                                                                      double.parse(
                                                                          livePrice);
                                                            }
                                                          });
                                                          // Update your UI with the live price
                                                        } catch (e) {
                                                          print(
                                                              'Error in message processing: $e');
                                                          // Handle the exception as needed (e.g., show an error message)
                                                        }
                                                      },
                                                      onError: (error) {
                                                        print(
                                                            'WebSocket error: $error');
                                                        // Handle WebSocket error as needed (e.g., show an error message)
                                                      },
                                                      onDone: () {
                                                        print(
                                                            'WebSocket connection closed');
                                                        // Handle WebSocket connection closure as needed
                                                      },
                                                    );
                                                  } catch (e) {
                                                    print(
                                                        'Error setting up WebSocket connection: $e');
                                                    // Handle the exception as needed (e.g., show an error message)
                                                  }
                                                });
                                              },
                                            );
                                          }
                                          return SizedBox(
                                              height: 2,
                                              child: LinearProgressIndicator());
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // CryptoPriceForBuyBitCoin(symbol:selectedSymbol,amount: double.parse(amountController.text)),
                              // Text(
                              //   '= $livePrice USD',
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 12,
                              //     // fontFamily: 'Lato',
                              //     fontWeight: FontWeight.w400,
                              //     // height: 0.14,
                              //   ),
                              // ),
                              if (amount != null)
                                Text(
                                  'Total Price:  $dataSymbol $totalLivePrice',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Opacity(
                                opacity: 0.48,
                                child: Container(
                                  width: 108,
                                  height: 31,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(0.00, -1.00),
                                      end: const Alignment(0, 1),
                                      colors: [
                                        Colors.white
                                            .withOpacity(0.20000000298023224),
                                        Colors.white
                                            .withOpacity(0.10000000149011612)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: const Center(
                                      child: Opacity(
                                    opacity: 0.48,
                                    child: Text(
                                      'One Time Buy',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        // height: 0.14,
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 110,
                                child: BlocBuilder<CurrencyListCubit,
                                    CurrencyListState>(
                                  builder: (context, state) {
                                    if (state is CurrencyListLoading) {
                                      SizedBox(
                                          height: 2,
                                          child: LinearProgressIndicator());
                                      // LoadingAnimationWidget.lin(
                                      //   color: Colors.white,
                                      //   size: 200,
                                      // );
                                    }
                                    if (state is CurrencyListSuccess) {
                                      // final c = state.currencyList
                                      //     .map((currency) =>
                                      //         (currency['name']
                                      //             as String?) ??
                                      //         'Unknown Currency');
                                      return DropdownSearch<String>(
                                        enabled: false,
                                        popupProps: const PopupProps.menu(
                                          showSearchBox: true,
                                          showSelectedItems: true,
                                        ),
                                        items: state.currencyList
                                            .map((currency) =>
                                                (currency['code'] as String?) ??
                                                'Unknown Currency')
                                            .toList(), // Use the countryNames from the widget
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelStyle: GoogleFonts.lato(
                                                color: const Color.fromARGB(
                                                    255, 196, 168, 168),
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                            fillColor: const Color(
                                                0xFF425AF1), // Fill color
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            // labelText: "Currency List",
                                            hintText: "Please Select Currency",
                                          ),
                                        ),
                                        onChanged: (selectedCurrency) {
                                          setState(() {
                                            final currencyValue =
                                                state.currencyList.firstWhere(
                                              (currency) =>
                                                  (currency['code']
                                                      as String?) ==
                                                  selectedCurrency,
                                              orElse: () => {
                                                // Default to ID 0 if not found
                                              },
                                            );

                                            if (currencyValue != null) {
                                              final symbolCCC =
                                                  currencyValue['symbol']
                                                      as String;
                                              dataSymbol = symbolCCC;
                                              print(symbolCCC);
                                            } else {
                                              // Handle the case where the selected currency is not found
                                              print(
                                                  'Currency not found for $selectedCurrency');
                                            }
                                          });
                                        },
                                        selectedItem: "USD",
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                                0xFF425AF1), // Fill color
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            // labelText: "Currency",
                                            // hintText: "Currency",
                                          ),
                                        ),
                                        onChanged: print,
                                        selectedItem:
                                            _callingCodeController.text,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: 114,
                                height: 48,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Buy',
                                    style: TextStyle(
                                      color: Color(0xFF9963B7),
                                      fontSize: 14,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 155,
                        height: 41,
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
                            'Cash',
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
                      Opacity(
                        opacity: 0.46,
                        child: Container(
                          width: 155,
                          height: 41,
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
                            child: Opacity(
                              opacity: 0.46,
                              child: Text(
                                'Crypto',
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Credit / DEBIT CARD',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.41999998688697815),
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 0.14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    decoration: const BoxDecoration(color: Color(0xFF161828)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/apple-pay (3) 1.png"),
                              Text(
                                '\.00 / \.00 Weekly Limit',
                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.41999998688697815),
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  // height: 0.14,
                                ),
                              )
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xFFD9D9D9),
                            radius: 15,
                            child: Container(
                              width: 15,
                              height: 15,
                              // ignore: prefer_const_constructors
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [
                                    Color(0xFF9963B7),
                                    Color(0xFF4710E4)
                                  ],
                                ),
                                shape: const OvalBorder(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    decoration: const BoxDecoration(color: Color(0xFF161828)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                      "assets/images/apple-pay (3) 2.png"),
                                  const Text(
                                    'Pay',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      // fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 0.8,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '\.00 / \.00 Weekly Limit',
                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.41999998688697815),
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  // height: 0.14,
                                ),
                              )
                            ],
                          ),
                          const CircleAvatar(
                            backgroundColor: Color(0xFFD9D9D9),
                            radius: 15,
                            // child: Container(
                            //   width: 15,
                            //   height: 15,
                            //   // ignore: prefer_const_constructors
                            //   decoration: ShapeDecoration(
                            //     gradient: const LinearGradient(
                            //       begin: Alignment(0.00, -1.00),
                            //       end: Alignment(0, 1),
                            //       colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                            //     ),
                            //     shape: const OvalBorder(),
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<PurchaseCubit>(context).purchase(
                          senderWalletAddress: "senderWalletAddress",
                          cryptocurrencySymbol: selectedSymbol,
                          cryptocurrencyAmount: totalLivePrice!,
                          receiverWalletAddress: "receiverWalletAddress",
                          amount: double.parse(amountController.text),
                          currencyType: "USD");
                    },
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
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      // ignore: prefer_const_constructors
                      child: Center(
                          child: Text(
                        'Buy $totalLivePrice $selectedSymbol',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          // fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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

  @override
  void dispose() {
    // Close WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }
}
