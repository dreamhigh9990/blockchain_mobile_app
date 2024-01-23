// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NftsSettingScreen extends StatefulWidget {
  const NftsSettingScreen({super.key});

  @override
  State<NftsSettingScreen> createState() => _NftsSettingScreen();
}

class _NftsSettingScreen extends State<NftsSettingScreen> {
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
          'NFTs',
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
        child: Column(
          children: [
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
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  ' Top 5 Best Seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 56, 55, 55)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.transparent,
                      ),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/portrait-happy-man.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: const Color.fromARGB(255, 57, 58,
                                        59), // Set your desired background color
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it circular
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(flex: 6, child: Text('User Name 1')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 56, 55, 55)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.transparent,
                      ),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/portrait-happy-man.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: const Color.fromARGB(255, 57, 58,
                                        59), // Set your desired background color
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it circular
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(flex: 6, child: Text('User Name 1')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 56, 55, 55)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.transparent,
                      ),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/portrait-happy-man.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: const Color.fromARGB(255, 57, 58,
                                        59), // Set your desired background color
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it circular
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(flex: 6, child: Text('User Name 1')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 56, 55, 55)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.transparent,
                      ),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/portrait-happy-man.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: const Color.fromARGB(255, 57, 58,
                                        59), // Set your desired background color
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it circular
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(flex: 6, child: Text('User Name 1')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 0, top: 5),
                child: Text(
                  ' Top Collection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 81, 56, 105)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 85, 8, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color.fromARGB(255, 70, 15, 122)),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
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
                  top: 10.0,
                  right: 200,
                  child: Container(
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Today's top selling rates"),
                    ),
                  ),
                ),
                Positioned(
                  top: 5.0,
                  left: 230,
                  child: Container(
                    width: 120,
                    height: 75,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/bit.PNG"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItems(Map<String, dynamic> item, int index) {
    return ListTile(
      // leading: index.isEven
      //     ? Image.asset("assets/images/bitcoin2.png")
      //     : Image.asset("assets/images/bitcoin1.png"),
      leading:
          // ? Image.asset("assets/images/bitcoin2.png")
          Image.asset("assets/images/bitcoin1.png"),
      title: Column(
        children: [
          const SizedBox(height: 10),
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
                ],
              ),
              const Spacer(),
              // Image.asset("assets/images/Group.png"),
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: const Color.fromARGB(43, 0, 0, 0),
          )
        ],
      ),
      onTap: () {},
    );
  }
}
