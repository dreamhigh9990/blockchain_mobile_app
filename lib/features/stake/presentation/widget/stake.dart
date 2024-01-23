import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StakePage extends StatefulWidget {
  const StakePage({super.key});

  @override
  State<StakePage> createState() => _StakePageState();
}

class _StakePageState extends State<StakePage> {
  String? selectedCoin;

  final List<String> coinOptions = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
    'Ripple',
    'Cardano'
  ];
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Stake',
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
          actions: [InkWell(
            onTap: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingAndProfile()));
                         
            },
            child: Image.asset("assets/images/setting.png"))],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bitcoin1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'BITCOIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    // fontFamily: 'Jumper PERSONAL USE ONLY',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.40,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Select Wallet',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 12,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    // height: 0.14,
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  width: 166,
                  height: 44,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        // fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // width: 350,
                    height: 85,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'From Wallet',
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w300,
                                  height: 0.14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$26,159,0',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      // fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: 0.40,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      '  From Wallet',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 10,
                                        // fontFamily: 'Lato',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 93,
                            height: 38,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Center(
                              child: Text(
                                'Collect',
                                style: TextStyle(
                                  color: Color(0xFF9963B7),
                                  fontSize: 10,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    // width: 350,
                    height: 85,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cash Withdrawal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w300,
                                  height: 0.14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$26,159,0',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      // fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: 0.40,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      '  From Wallet',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        // fontFamily: 'Lato',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          // Container(
                          //   width: 93,
                          //   height: 38,
                          //   decoration: ShapeDecoration(
                          //     color: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(6)),
                          //   ),
                          //   child: const Center(
                          //     child: Text(
                          //       'Collect',
                          //       style: TextStyle(
                          //         color: Color(0xFF9963B7),
                          //         fontSize: 10,
                          //         // fontFamily: 'Lato',
                          //         fontWeight: FontWeight.w400,
                          //         height: 0,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Coin Select',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        height: 0.14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.lato(
                          color: Color(0xff7A7A7A),
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                      fillColor: const Color(0xff181328), // Fill color
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      // labelText: "Country List",
                      // hintText: "Please Select Country",
                    ),
                    hint: Text('Select a coin'), // Hint text
                    value: selectedCoin,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCoin = newValue;
                      });
                    },
                    items: coinOptions.map((String coin) {
                      return DropdownMenuItem<String>(
                        value: coin,
                        child: Text(coin),
                      );
                    }).toList(),
                  ),
                ),

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
              ],
            ),
          ),
        ),
      ),
    );
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
