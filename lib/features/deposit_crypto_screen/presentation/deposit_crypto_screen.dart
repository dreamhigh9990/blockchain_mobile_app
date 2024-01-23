// ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers

import 'package:blockchain_mobile_app/features/deposit_crypto_screen/presentation/deposit_confirm_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:web_socket_channel/status.dart';

class DepositCryptoScreen extends StatefulWidget {
  const DepositCryptoScreen({super.key});

  @override
  State<DepositCryptoScreen> createState() => _DepositCryptoScreenState();
}

class _DepositCryptoScreenState extends State<DepositCryptoScreen> {
  bool button1Enabled = false;
  final List<String> currencyNames = ["USD", "EUR", "GBP", "JPY", "CNY"];
  final List<String> amountSigns = ["\$", "€", "£", "¥", "¥"];
  final List<String> cryptoNames = [
    "Bitcoin",
    "Ethereum",
    "Ripple",
    "Litecoin",
    "Cardano"
  ];
  final List<String> cryptoSigns = ["BTC", "ETH", "XRP", "LTC", "ADA"];
  bool button2Enabled = true;
  final List<String> itemms = [
    'USDT',
    'NGN',
    'BUSB',
    'BNB',
    'ETH',
    'DAI',
  ];
  String? selectedValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Deposit Bitcoins',
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
          actions: const [
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Select Method :"),
                    ElevatedButton(
                      onPressed: button1Enabled
                          ? () {
                              setState(() {
                                button1Enabled = false;
                                button2Enabled = true;
                              });
                            }
                          : null,
                      child: const Text('Crypto'),
                    ),
                    const SizedBox(width: 16), // Spacer between buttons
                    ElevatedButton(
                      onPressed: button2Enabled
                          ? () {
                              setState(() {
                                button2Enabled = false;
                                button1Enabled = true;
                              });
                            }
                          : null,
                      child: const Text('Cash'),
                    ),
                  ],
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text("Trading :"),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 3, 21, 136),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("USDT"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("BTC"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("BUSB"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("BNB"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("ETH"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("NGN"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("DAI"),
                                    ))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: button2Enabled == true
                        ? currencyNames.length
                        : cryptoNames.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 3, 21, 136)
                                      .withOpacity(0.2),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      button1Enabled == true
                                          ? currencyNames[index]
                                          : cryptoNames[index],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      button1Enabled == true
                                          ? amountSigns[index]
                                          : cryptoSigns[index],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepositConfirmScreen()));
                  },
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 3, 21, 136),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Center(child: Text("Next")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
