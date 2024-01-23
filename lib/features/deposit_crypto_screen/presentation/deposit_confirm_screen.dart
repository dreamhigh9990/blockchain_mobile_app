// ignore_for_file: unnecessary_null_comparison

import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:web_socket_channel/status.dart';

class DepositConfirmScreen extends StatefulWidget {
  const DepositConfirmScreen({super.key});

  @override
  State<DepositConfirmScreen> createState() => _DepositConfirmScreenState();
}

class _DepositConfirmScreenState extends State<DepositConfirmScreen> {
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
            'Deposit',
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 30,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 3, 21, 136),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Text("BTC"),
                        )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Select Network :")),
                ),
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
                                      child: Text("BTC"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("BEP2"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("BEP20(BSC)"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("ERC"),
                                    ))),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        child: const Center(
                                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("ERC20"),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])),
                Container(
                  width: 350,
                  height: 300,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 69, 80, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "BTC Deposit Screen: 684h6s4tr6h46tr54h6rt4sh65str4h")),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 113,
                        height: 113,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/An-example-of-QR-code.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text("SAVE QR CODE"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text("Notice :")),
                ),
                Container(
                  width: 350,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 69, 80, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Notification Purpose:\nClearly state that the notice is related to cryptocurrency deposits.\nDeposit Instructions:\nProvide clear and concise instructions on how users can deposit cryptocurrency into their accounts.\nInclude the supported cryptocurrencies and any specific deposit addresses or protocols.\nSecurity Reminders:\nEmphasize the importance of double-checking the deposit address before initiating any transactions to avoid errors.\nAdvise users to use only official platforms or wallets to make deposits.\nTransaction Confirmations:\nInform users that cryptocurrency transactions may require confirmations on the blockchain, and the deposit process might take some time.\nConfirmation Email:\nMention whether users will receive a confirmation email once the cryptocurrency deposit is successfully processed."),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 350,
                          color: const Color.fromARGB(255, 26, 1, 41),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: Text(
                                      'BTC',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    'Total 0.000658',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Available 1.0522222'),
                                )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('In order 0.0'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Equity Value(BTC) 0.0000004'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Equity Value  \$0.001023'),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text('Confirm Deposit'),
                                      onPressed: () => successDialog(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
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
                    child: const Center(child: Text("Deposit")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

              const Text("Deposit done"),
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
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.dashboardRoute);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
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
