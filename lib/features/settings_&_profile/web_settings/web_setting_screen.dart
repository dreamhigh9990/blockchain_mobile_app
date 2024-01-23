// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WebSettingScreen extends StatefulWidget {
  const WebSettingScreen({super.key});

  @override
  State<WebSettingScreen> createState() => _WebSettingScreen();
}

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

final List<double> bitcoinPrices = [
  45000,
  46000,
  47000,
  48000,
  49000,
  50000,
  // Add more data points for each day in the last month
];
final List<String> dayNames = [
  'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  // Add more day names for each day in the last month
];

class _WebSettingScreen extends State<WebSettingScreen> {
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
          title: const Text(
            'Web 3',
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
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const Center(
                child: Text(
                  ' Wollito',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // const Center(
              //   child: Text(
              //     'Sharing partners',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 12,
              //       // fontFamily: 'Lato',
              //       fontWeight: FontWeight.w400,
              //       height: 0,
              //     ),
              //   ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text(
                      'Bitcoin Prices (Last Month)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade800,
                                  Colors.blue.shade200
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1.7,
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    // leftTitles: SideTitles(
                                    //   showTitles: true,
                                    //   reservedSize: 40,
                                    // ),
                                    // bottomTitles: SideTitles(
                                    //   showTitles: true,
                                    //   reservedSize: 22,
                                    //   getTitles: (value) {
                                    //     // Display day names below the chart
                                    //     if (value.toInt() >= 0 && value.toInt() < dayNames.length) {
                                    //       return dayNames[value.toInt()];
                                    //     }
                                    //     return '';
                                    //   },
                                    // ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                  ),
                                  minX: 0,
                                  maxX: bitcoinPrices.length.toDouble() - 1,
                                  minY: 0,
                                  maxY: bitcoinPrices.reduce((value, element) =>
                                          value > element ? value : element) +
                                      1000,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        bitcoinPrices.length,
                                        (index) => FlSpot(index.toDouble(),
                                            bitcoinPrices[index]),
                                      ),
                                      isCurved: true,
                                      color: Colors.white,
                                      belowBarData: BarAreaData(show: false),
                                      dotData: FlDotData(
                                        show: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction History:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              // TODO: Add widgets to display transaction history
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // controller: _scrollController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return listItems(item, index);
                      },
                    ),
                    // Button to initiate a transaction
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement logic for initiating a transaction
                      },
                      child: Text('Initiate Transaction'),
                    ),
                  ]))
            ])));
  }

  Widget listItems(Map<String, dynamic> item, int index) {
    return ListTile(
      leading: index.isEven
          ? Image.asset("assets/images/bitcoin2.png")
          : Image.asset("assets/images/bitcoin1.png"),
      title: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      // fontFamily: 'Jumper PERSONAL USE ONLY',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                  Text(
                    item['subtitle'],
                    style: const TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 10,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.20,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset("assets/images/Group.png"),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${item['price']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      // fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                  const Text(
                    '\$123023123.345}',
                    style: TextStyle(
                      color: Color(0xFF61DA01),
                      fontSize: 10,
                      // fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
