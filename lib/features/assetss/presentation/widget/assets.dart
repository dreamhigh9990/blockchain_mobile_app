// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:math';

import 'dart:developer' as log;

import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/order_book/presentation/cubit/kline_cubit.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/transactions_cubit.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/wallet_price_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';

import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:web_socket_channel/io.dart';

class Assets extends StatefulWidget {
  AssetDetailsResponse? assetDetailsResponse;
  // String symbol;

  Assets({
    // required this.symbol,
    Key? key,
    this.assetDetailsResponse,
  }) : super(key: key);

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> with SingleTickerProviderStateMixin {
  late IOWebSocketChannel channel;
  String livePrice = '';

  String symbolForSocket = '';

  int selectedIndex = 0;
  bool isLoading = true;

  // void connectToWebSocket() {
  //   // Connect to the ticker price stream for the specified symbol
  //   channel = IOWebSocketChannel.connect(
  //       'wss://stream.binance.com:9443/ws/${symbolForSocket.toLowerCase()}@ticker');
  //   // 'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@ticker');

  //   // Listen for WebSocket events
  //   channel.stream.listen(
  //     (message) {
  //       final Map<String, dynamic> data = jsonDecode(message);
  //       final String lastPrice = data['c']; // 'c' represents the last price
  //       setState(() {
  //         livePrice = lastPrice;
  //         print(livePrice);
  //       });
  //     },
  //     onDone: () {
  //       print('WebSocket Closed for ${symbolForSocket}');
  //     },
  //     onError: (error) {
  //       print('WebSocket Error for ${symbolForSocket}: $error');
  //     },
  //   );
  // }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      //  callBitcoinListApi ();
      connectToWebSocket();
    }
    if (index == 1) {
      channel.sink.close();
      callKlineApi();
    }
  }

  String symbolForKline = "";
  String interval = "1w";
  String limit = "7";
  callKlineApi() {
    print("callKlineApi");
    BlocProvider.of<KlineCubit>(context).kline(symbolForKline, interval, limit);
  }

  final List<Tab> myTabs = <Tab>[
    const Tab(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '      Buy      ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    )),
    const Tab(
        child: Text(
      '             Sell             ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    )),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    symbolForSocket = widget.assetDetailsResponse!.symbols![0].symbol!;
    symbolForKline = widget.assetDetailsResponse!.symbols![0].symbol!;
    // callBitcoinListApi();
    BlocProvider.of<WalletPriceCubit>(context).getWalletPrice(symbolForSocket);

    connectToWebSocket();
  }

  void connectToWebSocket() {
    try {
      channel = IOWebSocketChannel.connect(
          'wss://stream.binance.com:9443/ws/${symbolForSocket.toLowerCase()}@ticker');

      channel.stream.listen(
        (message) {
          try {
            final Map<String, dynamic> data = jsonDecode(message);
            final String lastPrice = data['c']; // 'c' represents the last price
            setState(() {
              livePrice = lastPrice;
              isLoading = false;
            });
          } catch (error) {
            print('Error decoding message: $error');
          }
        },
        onDone: () {
          print('WebSocket Closed for ${symbolForSocket}');
        },
        onError: (error) {
          print('WebSocket Error for ${symbolForSocket}: $error');
        },
      );
    } catch (error) {
      print('Error connecting to WebSocket: $error');
    }
  }

  callBitcoinListApi() {
    BlocProvider.of<BitcoinListCubit>(context).bitcoinList();
  }

  // @override
  // void dispose() {
  //   _tabController?.dispose();
  //   super.dispose();
  // }
  @override
  void dispose() {
    channel.sink.close();
    _tabController?.dispose();
    super.dispose();
  }

  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Dashboard()));

        return false;
      },
      child: SafeArea(
        child: BlocListener<WalletPriceCubit, WalletPriceState>(
          listener: (context, state) {
            if (state is WalletPriceLoading) {}
            if (state is WalletPriceFailure) {
              final error = state.error;

              print("Error::::::: $error");
            }
            if (state is WalletPriceSuccess) {
              print("sssssssssssssssssssssssssssssss");
              final walletDetails = state.walletBalance;
              log.log("walletDetails:$walletDetails");

              BlocProvider.of<TransactionsCubit>(context)
                  .getTransactions(walletDetails['wallet_address']);
              print("sssssssssssssssssssssssssssssssd");
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(350),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 14),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingAndProfile()));
                            },
                            child: Image.asset("assets/images/setting.png"))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: TabBarView(controller: _tabController, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: const Color(0xff6600EF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 29,
                              right: 16,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/bitcoin2.png"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Spacer(),
                                    livePrice == ''
                                        ? const SizedBox(
                                            height: 5,
                                            width: 30,
                                            child: LinearProgressIndicator())
                                        : Text(
                                            livePrice,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w900,
                                              height: 0.14,
                                            ),
                                          ),
                                    // CryptoPriceForDetailsWidget(symbolForSocket),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    // livePrice == ''
                                    //     ? SizedBox(
                                    //         height: 5,
                                    //         width: 30,
                                    //         child: LinearProgressIndicator())
                                    //     : Text(
                                    //         livePrice,
                                    //         style: const TextStyle(
                                    //           color: Colors.white,
                                    //           fontSize: 15,
                                    //           fontFamily: 'Lato',
                                    //           fontWeight: FontWeight.w900,
                                    //           height: 0.14,
                                    //         ),
                                    //       ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          symbolForSocket,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: 0.28,
                                          ),
                                        ),
                                        Text(
                                          livePrice,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                            letterSpacing: 0.40,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 70,
                                      height: 21,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(28),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xff425AF1),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: BlocBuilder<KlineCubit, KlineState>(
                          builder: (context, state) {
                            if (state is KlineSuccess) {
                              print("in KlineSuccess");
                              final klineData = state.klineResponse;
                              List<Map<String, dynamic>> chartData = [];

                              for (int i = 0; i < klineData.length; i++) {
                                num highPrice = num.parse(klineData[i][2]);
                                num lowPrice = num.parse(klineData[i][3]);

                                chartData.add({
                                  "type": "high price",
                                  "index": i * 2,
                                  "value": highPrice,
                                });

                                chartData.add({
                                  "type": "low price",
                                  "index": i * 2 + 1,
                                  "value": lowPrice,
                                });
                              }
                              log.log("$chartData");
                              return Container(
                                width: 300,
                                height: 200,
                                child: Chart(
                                  padding: (_) =>
                                      const EdgeInsets.fromLTRB(40, 5, 10, 0),
                                  data: chartData,
                                  variables: {
                                    'index': Variable(
                                      accessor: (Map map) =>
                                          map['index'].toString(),
                                    ),
                                    'type': Variable(
                                      accessor: (Map map) =>
                                          map['type'] as String,
                                    ),
                                    'value': Variable(
                                      accessor: (Map map) =>
                                          num.tryParse(
                                              map['value'].toString()) ??
                                          0,
                                    ),
                                  },
                                  marks: [
                                    IntervalMark(
                                      position: Varset('index') *
                                          Varset('value') /
                                          Varset('type'),
                                      color: ColorEncode(
                                          variable: 'type',
                                          values: Defaults.colors10),
                                      size: SizeEncode(value: 2),
                                      modifiers: [DodgeSizeModifier()],
                                    )
                                  ],
                                  coord: RectCoord(
                                    horizontalRangeUpdater:
                                        Defaults.horizontalRangeEvent,
                                  ),
                                  axes: [
                                    Defaults.horizontalAxis
                                      ..tickLine = TickLine(),
                                    Defaults.verticalAxis,
                                  ],
                                ),
                              );
                            }
                            if (state is KlineLoading) {
                              return Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: const Color(0xff1974B3),
                                  secondRingColor: const Color(0xffD9D9D9),
                                  thirdRingColor:
                                      const Color.fromARGB(157, 217, 217, 217),
                                  size: 50,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: TabBar(
                        onTap: (index) {
                          _onNavItemTapped(index);
                        },
                        controller: _tabController,
                        tabs: myTabs,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: const Color(0xff1974B3),
                      secondRingColor: const Color(0xffD9D9D9),
                      thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
                      size: 50,
                    ),
                  );
                }
                if (state is TransactionsFailure) {
                  final error = state.error;

                  print("Error::::::: $error");
                }

                if (state is TransactionsSuccess) {
                  final transactionList = state.transactions;
                  log.log("transactionList:$transactionList");
                  return transactionList!.length == 0
                      ? const Center(child: Text("No Data Found"))
                      : ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: transactionList
                              .length, // Replace with the actual number of activities
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(
                                  Icons.history), // Add your desired icon
                              title: Text(transactionList[index][
                                  'purpose']), // Replace with the actual action
                              subtitle: Text(
                                transactionList[index]['cryptocurrency_symbol'],
                                style: const TextStyle(fontSize: 12),
                              ), // Replace with the actual description
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    transactionList[index]['symbol'] +
                                        transactionList[index]['amount']
                                            .toString(), // Replace with the actual price
                                    style: const TextStyle(
                                        color: Colors
                                            .green), // Customize the style as needed
                                  ),
                                  Text(
                                    transactionList[index]
                                            ['cryptocurrency_amount']
                                        .toStringAsFixed(
                                            5), // Replace with the actual value
                                    style: const TextStyle(
                                        color: Colors
                                            .grey), // Customize the style as needed
                                  ),
                                ],
                              ),
                            );
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
            // BlocBuilder<TransactionsCubit, TransactionsState>(
            //   builder: (context, state) {
            //     if (state is TransactionsLoading) {
            //       return Center(
            //         child: LoadingAnimationWidget.discreteCircle(
            //           color: Color(0xff1974B3),
            //           secondRingColor: Color(0xffD9D9D9),
            //           thirdRingColor: Color.fromARGB(157, 217, 217, 217),
            //           size: 50,
            //         ),
            //       );
            //     }
            //     if (state is TransactionsFailure) {
            //       final error = state.error;

            //       print("Error::::::: $error");
            //     }

            //     if (state is TransactionsSuccess) {
            //       final transactionList = state.transactions;
            //       log.log("transactionList:$transactionList");
            //       return transactionList!.length == 0
            //           ? Center(child: Text("No Data Found"))
            //           : ListView.builder(
            //               // physics: const NeverScrollableScrollPhysics(),
            //               // shrinkWrap: true,
            //               itemCount: transactionList
            //                   .length, // Replace with the actual number of activities
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   leading:
            //                       Icon(Icons.history), // Add your desired icon
            //                   title: Text(transactionList[index]
            //                       ['purpose']), // Replace with the actual action
            //                   subtitle: Text(
            //                     transactionList[index]['cryptocurrency_symbol'],
            //                     style: TextStyle(fontSize: 12),
            //                   ), // Replace with the actual description
            //                   trailing: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.end,
            //                     children: [
            //                       Text(
            //                         transactionList[index]['symbol'] +
            //                             transactionList[index]['amount']
            //                                 .toString(), // Replace with the actual price
            //                         style: TextStyle(
            //                             color: Colors
            //                                 .green), // Customize the style as needed
            //                       ),
            //                       Text(
            //                         transactionList[index]
            //                                 ['cryptocurrency_amount']
            //                             .toStringAsFixed(
            //                                 5), // Replace with the actual value
            //                         style: TextStyle(
            //                             color: Colors
            //                                 .grey), // Customize the style as needed
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             );
            //     }
            //     return Center(
            //       child: LoadingAnimationWidget.discreteCircle(
            //         color: Color(0xff1974B3),
            //         secondRingColor: Color(0xffD9D9D9),
            //         thirdRingColor: Color.fromARGB(157, 217, 217, 217),
            //         size: 50,
            //       ),
            //     );
            //   },
            // ),
          ),
        ),
      ),
    );
  }

  Widget listItems(String symbol, int index) {
    return ListTile(
      tileColor: index.isEven
          ? const Color.fromARGB(255, 114, 7, 255).withOpacity(0.1)
          : const Color.fromARGB(255, 152, 0, 207).withOpacity(0.2),
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
                      symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(flex: 2, child: Image.asset("assets/images/Group.png")),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
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
                      '\$345',
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
        setState(() {
          if (selectedIndex == 1) {
            symbolForSocket = symbol;
            symbolForKline = symbol;
            livePrice = '';
            channel.sink.close();
          } else {
            symbolForSocket = symbol;
            symbolForKline = symbol;
            livePrice = '';
            channel.sink.close();
            connectToWebSocket();
          }

          // callKlineApi();
        });
      },
    );
  }
}

const _kBaseGroupPaddingHorizontal = 32.0;
const _kMinBarSize = 8.0;

@immutable
class DodgeSizeModifier extends Modifier {
  @override
  AttributesGroups modify(
      AttributesGroups groups,
      Map<String, ScaleConv<dynamic, num>> scales,
      AlgForm form,
      CoordConv coord,
      Offset origin) {
    final xField = form.first[0];
    final band = (scales[xField]! as DiscreteScaleConv).band;

    final ratio = 1 / groups.length;
    final numGroups = groups.length;
    final groupHorizontalPadding = _kBaseGroupPaddingHorizontal / numGroups;
    final invertedGroupPaddingHorizontal =
        coord.invertDistance(groupHorizontalPadding, Dim.x);

    final effectiveBand = band - 2 * invertedGroupPaddingHorizontal;

    final maxWidth = coord.convert(const Offset(1, 0)).dx;
    final maxWidthInBand = effectiveBand * maxWidth;
    final maxWidthPerAttributes = maxWidthInBand / numGroups;
    final barHorizontalPadding = groupHorizontalPadding / 2;
    final size =
        max(maxWidthPerAttributes - barHorizontalPadding, _kMinBarSize);

    final bias = ratio * effectiveBand;

    var accumulated = -bias * (numGroups + 1) / 2;

    final AttributesGroups rst = [];
    for (final group in groups) {
      final groupRst = <Attributes>[];
      for (final attributes in group) {
        final oldPosition = attributes.position;

        groupRst.add(Attributes(
          index: attributes.index,
          tag: attributes.tag,
          position: oldPosition
              .map(
                (point) => Offset(point.dx + accumulated + bias, point.dy),
              )
              .toList(),
          shape: attributes.shape,
          color: attributes.color,
          gradient: attributes.gradient,
          elevation: attributes.elevation,
          label: attributes.label,
          size: size,
        ));
      }
      rst.add(groupRst);
      accumulated += bias;
    }

    return rst;
  }

  @override
  bool equalTo(Object other) {
    return super == other;
  }
}
