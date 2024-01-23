// ignore_for_file: unnecessary_null_comparison

import 'package:blockchain_mobile_app/features/buy_crypto_screen/presentation/buy_confirmation_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuyCryptoCoin extends StatefulWidget {
  const BuyCryptoCoin({super.key});

  @override
  State<BuyCryptoCoin> createState() => _BuyCryptoCoinState();
}

class _BuyCryptoCoinState extends State<BuyCryptoCoin> {
  final List<Map<String, dynamic>> items = [
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 100.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 200.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 300.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 400.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 500.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 100.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 200.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 300.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 400.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 500.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 100.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 200.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 300.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 400.0,
    },
    {
      'name': "566.6 NGN",
      'subtitle': '27.27 USD',
      'graphData': '100000-300000',
      'price': 500.0,
    },
  ];

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
            'Buy Bitcoin P2P',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          const VerticalDivider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color.fromARGB(255, 3, 21, 136)),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            // controller: _scrollController,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return listItems(item, index);
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 200,
                      child: Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text("Top selling rates"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 15,
                      child: Container(
                        height: 25,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
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
                                .map((String item) => DropdownMenuItem<String>(
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
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.redAccent,
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
                                color: const Color.fromARGB(255, 107, 87, 87),
                              ),
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
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
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listItems(Map<String, dynamic> item, int index) {
    return ListTile(
      title: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buyer Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  // fontFamily: 'Jumper PERSONAL USE ONLY',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.28,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Trades 99%',
                  style: TextStyle(
                    color: Color.fromARGB(255, 114, 110, 110),
                    fontSize: 12,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      // fontFamily: 'Jumper PERSONAL USE ONLY',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Crypto amount : \$${item['subtitle']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      // fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Limit : \$${item['graphData']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 187, 171, 171),
                      fontSize: 12,
                      // fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Image.asset("assets/images/Group.png"),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuyConfirmationScreen()));
                      },
                      child: const Text("BUY")),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 6,
                        width: 3,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'BANK TRANSFER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          // fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const Divider(
            color: Color.fromARGB(43, 0, 0, 0),
          )
        ],
      ),
      onTap: () {},
    );
  }
}
