// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer' as log;
import 'dart:math';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/transactions_cubit.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/wallet_price_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CryptoPage extends StatefulWidget {
  String symbol;
  CryptoPage({required this.symbol});
  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage>
    with SingleTickerProviderStateMixin {
  String cryptoName = 'Bitcoin';
  List<double> prices = [];

  double getHighestPrice() {
    return prices.isNotEmpty ? prices.reduce((a, b) => a > b ? a : b) : 0;
  }

  double getLowestPrice() {
    return prices.isNotEmpty ? prices.reduce((a, b) => a < b ? a : b) : 0;
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    fetchData(
        '${widget.symbol}', '1w', '100'); // Initial fetch with 1 day interval
    updateRandomValues();
    callWalletPrice();
    _tabController = TabController(length: 1, vsync: this);
  }

  double bitcoinAmount = 0.0;
  double bitcoinValue = 0.0;
  double price = 0.0;

  // Function to generate a random double within a specified range
  double getRandomDouble(double min, double max) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  callWalletPrice() {
    BlocProvider.of<WalletPriceCubit>(context).getWalletPrice(widget.symbol);
  }

  // callTransactions() {
  //   BlocProvider.of<TransactionsCubit>(context).getTransactions(walletAddress);
  // }
  void updateRandomValues() {
    // Generate random Bitcoin amount and value
    bitcoinAmount = getRandomDouble(0.001, 10.0); // Adjust range as needed
    bitcoinValue = getRandomDouble(20000.0, 60000.0); // Adjust range as needed
    setState(() {});
  }

  final List<Tab> tabs = [
    const Tab(text: 'Activity'),
    // const Tab(text: 'About'),
    // const Tab(text: 'Video'),
    // const Tab(text: 'News'),
  ];
  fetchData(String symbol, String interval, String limit) async {
    updateRandomValues();

    try {
      final baseUrl = 'https://api.binance.com/api/v3/klines';
      final queryParams = {
        'symbol': symbol,
        'interval': interval,
        'limit': limit,
      };
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          prices = data.map((e) => double.parse(e[4])).toList();
          print("Prices:$prices");
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String balance = "";
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          widget.symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            // fontFamily: 'Jumper PERSONAL USE ONLY',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        actions: [
          // Image.asset("assets/images/messenger2.png"),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingAndProfile(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/settings.png"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: 900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Container(
                    color: Colors.grey.withOpacity(0.04),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("\$ "),
                        BlocBuilder<WalletPriceCubit, WalletPriceState>(
                          builder: (context, state) {
                            // if (state is WalletPriceLoading) {
                            //   return const LinearProgressIndicator();
                            // }
                            if (state is WalletPriceFailure) {
                              final error = state.error;

                              print("Error::::::: $error");
                            }
                            if (state is WalletPriceSuccess) {
                              final walletDetails = state.walletBalance;
                              log.log("walletDetails:$walletDetails");

                              balance = walletDetails['balance'].toString();

                              // BlocProvider.of<TransactionsCubit>(context)
                              //     .getTransactions(
                              //         walletDetails['wallet_address']);
                              return Text(
                                walletDetails['balance'].toString(),
                                style:
                                    const TextStyle(fontSize: 30, height: -0.3),
                              );
                            }
                            return Text(
                              "",
                              style:
                                  const TextStyle(fontSize: 30, height: -0.3),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Container(
                    color: Colors.grey.withOpacity(0.04),
                    height: 150,
                    child: LineChart(
                      LineChartData(
                        // color: Colors.grey.withOpacity(0.2),
                        backgroundColor: Colors.grey.withOpacity(0.04),
                        extraLinesData: ExtraLinesData(
                          horizontalLines: [
                            HorizontalLine(
                              y: getHighestPrice(),
                              color: Colors.white.withOpacity(0.5),
                              strokeWidth: 0.5,
                              // dashArray: [5, 2],
                              label: HorizontalLineLabel(
                                show: true,
                                // label: 'Highest',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            HorizontalLine(
                              y: getLowestPrice(),
                              color: Colors.white.withOpacity(0.5),
                              strokeWidth: 0.5,
                              // dashArray: [5, 2],
                              label: HorizontalLineLabel(
                                show: true,
                                // label: 'Lowest',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: const Color(0xff37434d), width: 1),
                        ),
                        minX: 0,
                        minY: prices.isNotEmpty
                            ? prices.reduce((a, b) => a < b ? a : b)
                            : 0,
                        maxY: prices.isNotEmpty
                            ? prices.reduce((a, b) => a > b ? a : b)
                            : 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(prices.length, (index) {
                              return FlSpot(index.toDouble(), prices[index]);
                            }),
                            barWidth: 1,
                            isCurved: true,
                            color: Colors.white,
                            dotData: const FlDotData(show: false),
                            // belowBarData: BarAreaData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            fetchData('${widget.symbol}', '1d', '100'),
                        child: const Text('1D'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            fetchData('${widget.symbol}', '1w', '100'),
                        child: const Text('7D'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            fetchData('${widget.symbol}', '1M', '100'),
                        child: const Text('1M'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            fetchData('${widget.symbol}', '1d', '90'),
                        child: const Text('3M'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            fetchData('${widget.symbol}', '1w', '52'),
                        child: const Text('1Y'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            bitcoinAmount.toStringAsFixed(10),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '${widget.symbol}',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40, // Adjust the height as needed
                      child: VerticalDivider(
                        // indent: 0.2,
                        // endIndent: 0.2,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          BlocBuilder<WalletPriceCubit, WalletPriceState>(
                            builder: (context, state) {
                              if (state is WalletPriceLoading) {
                                return const LinearProgressIndicator();
                              }
                              if (state is WalletPriceFailure) {
                                final error = state.error;

                                print("Error::::::: $error");
                              }
                              if (state is WalletPriceSuccess) {
                                final walletDetails = state.walletBalance;
                                log.log("walletDetails:$walletDetails");

                                balance = walletDetails['balance'].toString();
                               
                                BlocProvider.of<TransactionsCubit>(context)
                                    .getTransactions(
                                        walletDetails['wallet_address']);
                                return Text(
                                  walletDetails['balance'].toString(),
                                  style: const TextStyle(color: Colors.white),
                                );
                              }
                              return const LinearProgressIndicator(
                                color: Colors.white,
                              );
                            },
                          ),
                          Text(
                            'Balance',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.currency_exchange_sharp),
                          Text("Exchange")
                        ],
                      )),
                ),

                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  controller: _tabController,
                  tabs: tabs,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey.withOpacity(0.5),
                  indicatorColor: Colors.white,
                ),

                // Tab bar view
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Tab 1 content
                      BlocBuilder<TransactionsCubit, TransactionsState>(
                        builder: (context, state) {
                          if (state is TransactionsLoading) {
                            return Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                color: Color(0xff1974B3),
                                secondRingColor: Color(0xffD9D9D9),
                                thirdRingColor:
                                    Color.fromARGB(157, 217, 217, 217),
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
                                ? Center(child: Text("No Data Found"))
                                : ListView.builder(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    // shrinkWrap: true,
                                    itemCount: transactionList
                                        .length, // Replace with the actual number of activities
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Icon(Icons
                                            .history), // Add your desired icon
                                        title: Text(transactionList[index][
                                            'purpose']), // Replace with the actual action
                                        subtitle: Text(
                                          transactionList[index]
                                              ['cryptocurrency_symbol'],
                                          style: TextStyle(fontSize: 12),
                                        ), // Replace with the actual description
                                        trailing: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              transactionList[index]['symbol'] +
                                                  transactionList[index]
                                                          ['amount']
                                                      .toString(), // Replace with the actual price
                                              style: TextStyle(
                                                  color: Colors
                                                      .green), // Customize the style as needed
                                            ),
                                            Text(
                                              transactionList[index]
                                                      ['cryptocurrency_amount']
                                                  .toStringAsFixed(
                                                      5), // Replace with the actual value
                                              style: TextStyle(
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
                              color: Color(0xff1974B3),
                              secondRingColor: Color(0xffD9D9D9),
                              thirdRingColor:
                                  Color.fromARGB(157, 217, 217, 217),
                              size: 50,
                            ),
                          );
                        },
                      ),
                      // Tab 2 content
                      // Container(
                      //   child: const Center(child: Text('Tab 2 Content')),
                      // ),
                      // Container(
                      //   child: const Center(
                      //       child: Text(
                      //           'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')),
                      // ),

                      // // Tab 3 content
                      // Container(
                      //   child: const Center(
                      //       child: Text(
                      //           'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')),
                      // ),

                      // // Tab 4 content
                      // Container(
                      //   child: const Center(
                      //       child: Text(
                      //           'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
