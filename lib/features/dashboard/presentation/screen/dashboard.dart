import 'package:blockchain_mobile_app/features/exchange/presentation/widget/exchange.dart';
import 'package:blockchain_mobile_app/features/history/presentation/widget/history.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/home.dart';
import 'package:blockchain_mobile_app/features/market/presentation/widget/market.dart';
import 'package:blockchain_mobile_app/features/presentation/screen/referal_screen.dart';
import 'package:blockchain_mobile_app/features/send_payment/presentation/widget/send_payment.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/widget/wallet.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> pages = [
    HomePage(),
    const History(),
    const Exchange(),
    const Market(),
    const Wallet(),
  ];
  int selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      // drawer: CommonDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color(0xFF22263F),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            // primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,

              onTap: _onNavItemTapped,
              // backgroundColor: Color(0xFF22263F),
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                        width: 34,
                        height: 34,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: Image.asset("assets/images/two-arrows1.png")),
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Market',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Wallet',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class AnalysisPage {
//   const AnalysisPage();
// }

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF161828),
      width: 184,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.white.withOpacity(.5),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 21),
            child: Text(
              'Trade',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                // fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/crypto.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Crypto Wallet',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/icons8_user_96px_2 1.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Track',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/icons8_user_96px_2 1 (1).png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Fiat Wallet',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/icons8_user_96px_2 1 (2).png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Recurring Buy',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/icons8_user_96px_2 1 (3).png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Target Price',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 21),
            child: Text(
              'Spend',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                // fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SendPayment()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/pay.png"),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Pay',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 21),
            child: Text(
              'Finance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                // fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/supercharger.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Supercharger',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/earn.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Earn',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/staking.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Staking',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 21),
            child: Text(
              'Bonus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                // fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/mission.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Mission',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/reward.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Reward',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReferalScreen()));
              },
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/reffer.png"),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Refer',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 21),
            child: Text(
              'More',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                // fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/cryptooo.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Crypto.com NFT',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/university.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'University',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/settings.png"),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Setting',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
