import 'dart:convert';

import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SpecificCoinTrackScreen extends StatefulWidget {
  String? symbol;
  SpecificCoinTrackScreen({this.symbol});
  // const SpecificCoinTrackScreen({super.key});

  @override
  State<SpecificCoinTrackScreen> createState() =>
      _SpecificCoinTrackScreenState();
}

class _SpecificCoinTrackScreenState extends State<SpecificCoinTrackScreen> {
  List<double> prices = [];

  double bitcoinAmount = 0.0;
  double bitcoinValue = 0.0;
  double price = 0.0;

  // Function to generate a random double within a specified range
  double getRandomDouble(double min, double max) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  double getHighestPrice() {
    return prices.isNotEmpty ? prices.reduce((a, b) => a > b ? a : b) : 0;
  }

  double getLowestPrice() {
    return prices.isNotEmpty ? prices.reduce((a, b) => a < b ? a : b) : 0;
  }

  // callWalletPrice() {
  //   BlocProvider.of<WalletPriceCubit>(context).getWalletPrice(widget.symbol);
  // }
  void updateRandomValues() {
    // Generate random Bitcoin amount and value
    bitcoinAmount = getRandomDouble(0.001, 10.0); // Adjust range as needed
    bitcoinValue = getRandomDouble(20000.0, 60000.0); // Adjust range as needed
    setState(() {});
  }

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

  Future<Map<String, dynamic>> fetchDetails(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.binance.com/api/v3/ticker/24hr?symbol=$symbol'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load details for $symbol');
      }
    } catch (error) {
      // Handle the exception as needed
      print('Error fetching details: $error');
      throw Exception('Failed to fetch details');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(
        '${widget.symbol}', '1w', '100'); // Initial fetch with 1 day interval
    updateRandomValues();
    fetchDetails(widget.symbol!);
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
                  Navigator.pop(context);
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (_) => Dashboard()));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              title: const Text(
                'Track Coin',
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.symbol!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              prices.isNotEmpty
                                  ? TextSpan(
                                      text: '${prices[0]}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    )
                                  : TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              "+ 0.25",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "- 0.13",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '0.005151540',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: ' BTC ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                    //grapgh
                    const SizedBox(
                      height: 25,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     height: 250,
                    //     child: LineChart(
                    //       LineChartData(
                    //         backgroundColor: Colors.grey.withOpacity(0.04),
                    //         extraLinesData: ExtraLinesData(
                    //           horizontalLines: [
                    //             HorizontalLine(
                    //               y: 80, // Static highest price
                    //               color: Colors.white.withOpacity(0.5),
                    //               strokeWidth: 0.5,
                    //               label: HorizontalLineLabel(
                    //                 show: true,
                    //                 // label: 'Highest',
                    //                 style: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //             HorizontalLine(
                    //               y: 0, // Static lowest price
                    //               color: Colors.white.withOpacity(0.5),
                    //               strokeWidth: 0.5,
                    //               label: HorizontalLineLabel(
                    //                 show: true,
                    //                 // label: 'Lowest',
                    //                 style: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         gridData: const FlGridData(show: false),
                    //         titlesData: const FlTitlesData(show: false),
                    //         borderData: FlBorderData(
                    //           show: false,
                    //           border: Border.all(
                    //               color: const Color(0xff37434d), width: 1),
                    //         ),
                    //         minX: 0,
                    //         minY: 0,
                    //         maxY: 100,
                    //         lineBarsData: [
                    //           LineChartBarData(
                    //             spots: [
                    //               const FlSpot(0, 42),
                    //               const FlSpot(1, 10),
                    //               const FlSpot(2, 20),
                    //               const FlSpot(3, 07),
                    //               const FlSpot(4, 43),
                    //               const FlSpot(5, 20),
                    //               const FlSpot(6, 65),
                    //               const FlSpot(7, 22),
                    //             ],
                    //             barWidth: 1,
                    //             isCurved: false,
                    //             color: Colors.white,
                    //             dotData: const FlDotData(show: false),
                    //             belowBarData: BarAreaData(
                    //               show: true,
                    //               color: Colors.grey.withOpacity(0.5),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                                  return FlSpot(
                                      index.toDouble(), prices[index]);
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
                    Center(
                      child: SingleChildScrollView(
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
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "MARKET DATA",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "MARKET CAP",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "kr13.632B",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "24H VOLUME",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "kr1.256B",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "RANK",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "#69",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Circulating",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text("860.2M ENJ"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Supply",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text("18 ENJ"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ROI",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text("   +65468"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Max Supply",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text("  18 ENJ"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "All-Time High ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text("kr48.45"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "% of ATH",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text("34%"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Recurring Buy",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            "buying ENJ every week performed better than trying to time the market",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.calendar_month,
                              size: 40,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "INFO",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "About Enjin Coin",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(
                      child: Text(
                        "ENJ is a crypto that powers the Enjin Platfrom. Enjin is a smart contract platfrom that gives game developer, content creators and gaming communities the required crypto-backend value.buying ENJ every week performed better than trying to time the market",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tags",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text("media,ntfs,gaming"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Consensus Method",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text("n/s"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Token Type",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text("ERC-20"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Token Usage",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text("Access"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 136, 34, 190),
                              Color(0xff4710E4)
                            ]),
                            borderRadius: BorderRadius.circular(8)),
                        child: MaterialButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 400,
                                  color: const Color.fromARGB(255, 26, 1, 41),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Buy Crypto",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        const Center(
                                            child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 15,
                                              top: 25),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            maxLines: 1,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                hintText: '  Enter Amount'),
                                          ),
                                        )),
                                        const Text(
                                          "From Account",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      height: 33,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 74, 1, 87),
                                                      child: const Center(
                                                          child: Text("ENJ")))),
                                              const Expanded(
                                                  flex: 6,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
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
                                                colors: [
                                                  Color(0xFF9963B7),
                                                  Color(0xFF4710E4)
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  // side: const BorderSide(
                                                  //     color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            // ignore: prefer_const_constructors
                                            child: Center(
                                                child: const Text(
                                              'Confirm Purchase',
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
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(140, 20, 140, 20),
                            child: Text(
                              "BUY",
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
                      height: 25,
                    ),
                  ],
                ),
              ),
            )));
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

              const Text("Purchasing done successfully"),
              const SizedBox(height: 20),

              const Text(
                "",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
}
