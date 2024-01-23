// ignore_for_file: unnecessary_null_comparison

import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:web_socket_channel/status.dart';

class BuyConfirmationScreen extends StatefulWidget {
  const BuyConfirmationScreen({super.key});

  @override
  State<BuyConfirmationScreen> createState() => _BuyConfirmationScreenState();
}

class _BuyConfirmationScreenState extends State<BuyConfirmationScreen> {
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
            'Buy Bitcoins',
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
                Container(
                  width: 350,
                  height: 170,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 69, 80, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Available Amount : 562589 NGN",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 243, 239, 239)),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: itemms
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 120,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color:
                                        const Color.fromARGB(255, 3, 21, 136),
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color:
                                        const Color.fromARGB(255, 3, 21, 136),
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          autocorrect: true,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: '  Enter Amount',
                              fillColor: Color.fromARGB(255, 3, 21, 136),
                              border: OutlineInputBorder()),
                        ),
                      )),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 8),
                          child: Text(
                            "Refference price : 566.6 USD",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 156, 146, 146)),
                          ),
                        ),
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
                                      'Confirm Purchase',
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
                                    '50000',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('I will receive 123654 USDT'),
                                )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Payment method'),
                                ),
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.amber)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('BANK TRANSFER'),
                                          Text('566.67 USD'),
                                        ],
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text('Confirm Purchase'),
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
                    child: const Center(child: Text("BUY")),
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

              const Text("PURCHASE DONE"),
              const SizedBox(height: 20),

              Text(
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
}
