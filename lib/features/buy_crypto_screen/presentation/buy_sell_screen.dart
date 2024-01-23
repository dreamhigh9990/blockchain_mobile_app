// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/cubit/purchase_cubit.dart';
import 'package:blockchain_mobile_app/features/buy_crypto_screen/presentation/api_call.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/home.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class BuySellScreen extends StatefulWidget {
  const BuySellScreen({super.key});

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  bool isTextFieldEnabled = false;
  bool isSellTextFieldEnabled = false;
  String selectedSymbol = '';
  String selectedFcrypto = '';
  String selectedCrypto = '';
  late WebSocketChannel channel;
  String livePrice = '';
  double? amount;
  TextEditingController amountController = TextEditingController();
  TextEditingController amountSellController = TextEditingController();
  double? totalLivePrice;
/////////////////////////////////////////////////////////
  String dataSymbol = '\$';
  String flag = 'buy';
  bool isLoading = false;
  bool disabled = false;

  ///sdsddsds
  List<String> fiatCurrencies = []; // Dynamic list of fiat currencies
  String? selectedFiatCurrency;

  List<String> tradingPairs = [];
  String? selectedTradingPair;
  Future<void> fetchData() async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 2));

    // Set the new data
    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  Future<void> fetchFiatCurrencies() async {
    final response = await http.get(
      Uri.parse('https://api.binance.com/api/v3/exchangeInfo'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> symbols = data['symbols'];

      final uniqueFiatCurrencies = Set<String>();

      symbols.forEach((symbol) {
        if (symbol['quoteAsset'] != null) {
          uniqueFiatCurrencies.add(symbol['quoteAsset']);
        }
      });

      setState(() {
        fiatCurrencies = uniqueFiatCurrencies.toList();
        selectedFiatCurrency =
            fiatCurrencies.isNotEmpty ? fiatCurrencies.first : null;
        fetchTradingPairs(selectedFiatCurrency!);
      });
    } else {
      throw Exception('Failed to load fiat currencies');
    }
  }

  Future<void> fetchTradingPairs(String fiatCurrency) async {
    final response = await http.get(
      Uri.parse('https://api.binance.com/api/v3/exchangeInfo'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> symbols = data['symbols'];

      setState(() {
        tradingPairs = symbols
            .where((symbol) => symbol['baseAsset'] == fiatCurrency)
            .map<String>((symbol) => symbol['quoteAsset'])
            .toList();
        selectedTradingPair = tradingPairs.isNotEmpty ? tradingPairs[0] : null;
      });
    } else {
      throw Exception('Failed to load trading pairs');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFiatCurrencies();
    isTextFieldEnabled = false;
    amount = 0.0;
    amountController = TextEditingController(text: "0.0");
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/btcusdt@trade');

    // Listen for incoming messages (price updates) and update the UI
    channel.stream.listen((message) {
      print('Received: $message');
      setState(() {
        livePrice = _parsePriceFromWebSocketMessage(message);
        if (amount != null) {
          // Calculate the totalLivePrice when both amount and livePrice are available
          totalLivePrice = amount! * double.parse(livePrice);
        }
      });
      // Update your UI with the live price
    });
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));

            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (_) => Dashboard()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        title: const Text(
          'Buy & Sell',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 0, right: 8),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Color(0xff6600EF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                flag = "buy";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                ),
                                color: flag == "buy"
                                    ? const Color(0xff181328)
                                    : const Color(0xff6600EF),
                              ),
                              height: 50,
                              // width: 0,
                              child: const Center(child: Text("BUY")),
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                flag = "sell";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                                color: flag == "sell"
                                    ? const Color(0xff181328)
                                    : const Color(0xff6600EF),
                              ),
                              height: 50,
                              // width: 120,

                              child: const Center(child: Text("SELL")),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              if (flag == 'buy')
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0)),
                      color: Color(0xff6600EF).withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'I want to pay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: TextFormField(
                                  // enabled: isTextFieldEnabled,
                                  controller: amountController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelStyle: GoogleFonts.lato(
                                      color: const Color(0xff7A7A7A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                    labelText: "Amount",
                                    hintText: "Amount",
                                    fillColor: const Color(0xff181328),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      amount = double.tryParse(value);
                                      // Recalculate totalLivePrice when amount changes
                                      if (amount != null) {
                                        totalLivePrice =
                                            amount! * double.parse(livePrice);
                                      }
                                    });
                                  },
                                ),
                              ),

                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: DropdownSearch<String>(
                                    enabled: fiatCurrencies.isEmpty
                                        ? disabled
                                        : !disabled,
                                    // ignore: prefer_const_constructors
                                    popupProps: PopupProps.menu(
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                      // disabledItemFn: (String s) => s.startsWith('I'),
                                    ),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    items: fiatCurrencies,
                                    // Use the countryNames from the widget

                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        fillColor: const Color(
                                            0xff181328), // Fill color
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: "Currency",
                                        hintText: "Currency",
                                      ),
                                    ),
                                    selectedItem: fiatCurrencies.isNotEmpty
                                        ? fiatCurrencies.first
                                        : "",
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedFcrypto =
                                              newValue.toLowerCase();
                                          selectedFiatCurrency = newValue;
                                          fetchTradingPairs(
                                              selectedFiatCurrency!);
                                        });
                                      }
                                    },
                                    // selectedItem: fiatCurrencies.first,
                                  ),
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'I will receive',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 60,
                                  color: const Color(0xff181328),
                                  child: Center(
                                    child: isLoading
                                        ? const LinearProgressIndicator(
                                            minHeight: 25,
                                            color: Colors.white,
                                          )
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                "$dataSymbol $totalLivePrice",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                // child: TextFormField(
                                //   readOnly: true,
                                //   obscureText: true,
                                //   autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //   decoration: InputDecoration(
                                //     labelStyle: GoogleFonts.lato(
                                //       color: const Color(0xff7A7A7A),
                                //       fontWeight: FontWeight.w300,
                                //       fontSize: 12,
                                //     ),
                                //     labelText: "$dataSymbol $totalLivePrice",
                                //     hintText: "Amount",
                                //     fillColor: const Color(0xff181328),
                                //     filled: true,
                                //     border: OutlineInputBorder(
                                //       borderSide: BorderSide.none,
                                //       borderRadius: BorderRadius.circular(0),
                                //     ),
                                //   ),
                                // ),
                              ),
                              Expanded(
                                flex: 4,
                                child: DropdownSearch<String>(
                                  enabled: tradingPairs.isEmpty
                                      ? disabled
                                      : !disabled,
                                  // ignore: prefer_const_constructors
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    // disabledItemFn: (String s) => s.startsWith('I'),
                                  ),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: tradingPairs,
                                  // Use the countryNames from the widget

                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      fillColor:
                                          const Color(0xff181328), // Fill color
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: "Currency",
                                      hintText: "Currency",
                                    ),
                                  ),

                                  onChanged: (String? newValue) {
                                    fetchData();
                                    setState(() {
                                      selectedTradingPair = newValue;
                                      selectedSymbol = newValue!;
                                      selectedCrypto = newValue.toLowerCase();
                                      isLoading = true;
                                      print(selectedSymbol);
                                      print(
                                          "ddddddddddddddddd$selectedFcrypto");
                                      print("ddddddddddddddddd$selectedCrypto");
                                      isTextFieldEnabled = true;
                                      if (channel != null) {
                                        print("dddddddddddddddchannel");
                                        channel.sink.close();
                                      }

                                      // channel = IOWebSocketChannel.connect(
                                      //     'wss://stream.binance.com:9443/ws/${selectedSymbol.toLowerCase()}@trade');

                                      // channel.stream.listen((message) {
                                      //   print('Received: $message');
                                      //   setState(() {
                                      //     livePrice =
                                      //         _parsePriceFromWebSocketMessage(
                                      //             message);
                                      //     if (amount != null) {
                                      //       totalLivePrice =
                                      //           amount! * double.parse(livePrice);
                                      //     }

                                      //     // totalLivePrice =
                                      //     //     _parsePriceFromWebSocketMessageDouble(
                                      //     //         message * amount);
                                      //   });
                                      // });

                                      try {
                                        channel = IOWebSocketChannel.connect(
                                            'wss://stream.binance.com:9443/ws/${selectedFcrypto}${selectedCrypto}@trade');

                                        channel.stream.listen(
                                          (message) {
                                            try {
                                              print('Received: $message');
                                              setState(() {
                                                livePrice =
                                                    _parsePriceFromWebSocketMessage(
                                                        message);
                                                if (amount != null) {
                                                  totalLivePrice = amount! *
                                                      double.parse(livePrice);
                                                }
                                              });
                                            } catch (error) {
                                              print(
                                                  'Error decoding message: $error');
                                            }
                                          },
                                          onDone: () {
                                            print(
                                                'WebSocket Closed for ${selectedFcrypto}${selectedCrypto}');
                                          },
                                          onError: (error) {
                                            print(
                                                'WebSocket Error for  ${selectedFcrypto}${selectedCrypto}: $error');
                                          },
                                        );
                                      } catch (error) {
                                        print(
                                            'Error connecting to WebSocket: $error');
                                      }
                                      // channel = IOWebSocketChannel.connect(
                                      //     'wss://stream.binance.com:9443/ws/${selectedFcrypto}${selectedCrypto}@trade');

                                      // channel.stream.listen((message) {
                                      //   print('Received: $message');
                                      //   setState(() {
                                      //     livePrice =
                                      //         _parsePriceFromWebSocketMessage(
                                      //             message);
                                      //     if (amount != null) {
                                      //       totalLivePrice =
                                      //           amount! * double.parse(livePrice);
                                      //     }

                                      //     // totalLivePrice =
                                      //     //     _parsePriceFromWebSocketMessageDouble(
                                      //     //         message * amount);
                                      //   });
                                      // });
                                      print("closssse");
                                    });
                                  },

                                  selectedItem: tradingPairs.isNotEmpty
                                      ? tradingPairs.first
                                      : "",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Estimeted price',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 350,
                              height: 54,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xff9963B7),
                                  Color(0xff4710E4)
                                ]),
                                shape: RoundedRectangleBorder(
                                    // side: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              // ignore: prefer_const_constructors
                              child: Center(
                                  child: Text(
                                'Buy $totalLivePrice $selectedSymbol',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0)),
                      color: Color(0xff6600EF).withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'I want to sell ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: TextFormField(
                                  // enabled: isSellTextFieldEnabled,
                                  controller: amountSellController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelStyle: GoogleFonts.lato(
                                      color: const Color(0xff7A7A7A),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                    labelText: "Amount",
                                    hintText: "Amount",
                                    fillColor: const Color(0xff181328),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      amount = double.tryParse(value);
                                      // Recalculate totalLivePrice when amount changes
                                      if (amount != null) {
                                        totalLivePrice =
                                            amount! * double.parse(livePrice);
                                      }
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: DropdownSearch<String>(
                                    enabled: fiatCurrencies.isEmpty
                                        ? disabled
                                        : !disabled,
                                    // ignore: prefer_const_constructors
                                    popupProps: PopupProps.menu(
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                      // disabledItemFn: (String s) => s.startsWith('I'),
                                    ),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    items: fiatCurrencies,
                                    // Use the countryNames from the widget

                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        fillColor: const Color(
                                            0xff181328), // Fill color
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: "Currency",
                                        hintText: "Currency",
                                      ),
                                    ),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedFcrypto =
                                              newValue.toLowerCase();
                                          selectedFiatCurrency = newValue;
                                          fetchTradingPairs(
                                              selectedFiatCurrency!);
                                        });
                                      }
                                    },
                                    // selectedItem: selectedFiatCurrency,
                                    selectedItem: fiatCurrencies.isNotEmpty
                                        ? fiatCurrencies.first
                                        : null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'I will receive',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 60,
                                  color: const Color(0xff181328),
                                  child: Center(
                                    child: isLoading
                                        ? const LinearProgressIndicator(
                                            minHeight: 25,
                                            color: Colors.white,
                                          )
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "$dataSymbol $totalLivePrice",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: DropdownSearch<String>(
                                  enabled: tradingPairs.isEmpty
                                      ? disabled
                                      : !disabled,
                                  // ignore: prefer_const_constructors
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    // disabledItemFn: (String s) => s.startsWith('I'),
                                  ),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: tradingPairs,
                                  // Use the countryNames from the widget

                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      fillColor:
                                          const Color(0xff181328), // Fill color
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: "Currency",
                                      hintText: "Currency",
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    fetchData();
                                    setState(() {
                                      isSellTextFieldEnabled = true;
                                      selectedTradingPair = newValue;
                                      selectedSymbol = newValue!;
                                      selectedCrypto = newValue.toLowerCase();
                                      isLoading = true;
                                      print(selectedSymbol);
                                      print(
                                          "ddddddddddddddddd$selectedFcrypto");
                                      print("ddddddddddddddddd$selectedCrypto");
                                      isTextFieldEnabled = true;
                                      if (channel != null) {
                                        print("dddddddddddddddchannel");
                                        channel.sink.close();
                                      }

                                      try {
                                        channel = IOWebSocketChannel.connect(
                                            'wss://stream.binance.com:9443/ws/${selectedFcrypto}${selectedCrypto}@trade');

                                        channel.stream.listen(
                                          (message) {
                                            try {
                                              print('Received: $message');
                                              setState(() {
                                                livePrice =
                                                    _parsePriceFromWebSocketMessage(
                                                        message);
                                                if (amount != null) {
                                                  totalLivePrice = amount! *
                                                      double.parse(livePrice);
                                                }
                                              });
                                            } catch (error) {
                                              print(
                                                  'Error decoding message: $error');
                                            }
                                          },
                                          onDone: () {
                                            print(
                                                'WebSocket Closed for ${selectedFcrypto}${selectedCrypto}');
                                          },
                                          onError: (error) {
                                            print(
                                                'WebSocket Error for  ${selectedFcrypto}${selectedCrypto}: $error');
                                          },
                                        );
                                      } catch (error) {
                                        print(
                                            'Error connecting to WebSocket: $error');
                                      }

                                      print("closssse");
                                    });
                                  },
                                  selectedItem: tradingPairs.isNotEmpty
                                      ? tradingPairs.first
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Estimeted price',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 350,
                              height: 54,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff9963B7),
                                    Color(0xff4710E4)
                                  ]),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MaterialButton(
                                onPressed: () async {
                                  try {
                                    final response =
                                        await BinanceApi.placeOrder(
                                      symbol: 'BTCUSDT',
                                      side: 'BUY',
                                      type: 'LIMIT',
                                      quantity: '1.0',
                                      price: '50000.0',
                                    );
                                    log("$response");
                                  } catch (e) {
                                    log('Error: $e');
                                  }
                                },
                                child: const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(120, 20, 120, 20),
                                  child: Text(
                                    "Sell",
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
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ));
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
                    child: const Text(
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
