import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/exchange/presentation/widget/exchange.dart';
import 'package:blockchain_mobile_app/features/history/presentation/widget/history.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/home.dart';
import 'package:blockchain_mobile_app/features/market/presentation/widget/market.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/widget/sign_in_widget.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/widget/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String? accessToken;
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

  getSignInResponse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("accessToken");
      debugPrint(
          "sharedPreferences.getString(loginId) :::${sharedPreferences.getString("accessToken")}");
      debugPrint("loginId shared preference: $accessToken");
    });
  }

  @override
  void initState() {
    getSignInResponse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return accessToken == null
        ? OnBoardingSlider(
            indicatorPosition: 10,
            onFinish: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SignInWidget()));
            },
            headerBackgroundColor: const Color(0xFF221933),
            finishButtonText: 'Login',
            finishButtonStyle: const FinishButtonStyle(
              backgroundColor: Colors.transparent,
            ),
            hasSkip: true,
            skipIcon: const Icon(
              Icons.arrow_circle_right_rounded,
              size: 50,
              color: Colors.deepPurple,
            ),
            skipTextButton: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) =>
                          accessToken == null ? SignInWidget() : Dashboard()));
                },
                child: const Text('Skip')),
            trailing: const Text('Login'),
            background: [
              const Text(""),
              const Text(""),
              const Text(""),
            ],
            totalPage: 3,
            speed: 1.8,
            pageBodies: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/intro.png'),
                    // const Text('Description Text 1'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Column(
                  children: <Widget>[
                    SizedBox(
                      height: 480,
                    ),
                    // Text('Description Text 2'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/intro.png'),
                    const Text(''),
                  ],
                ),
              ),
            ],
          )
        : Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: const Color(0xFF22263F),
                  textTheme: Theme.of(context).textTheme.copyWith()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BottomNavigationBar(
                    currentIndex: selectedIndex,
                    onTap: _onNavItemTapped,
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
                                  colors: [
                                    Color(0xFF9963B7),
                                    Color(0xFF4710E4)
                                  ],
                                ),
                                shape: OvalBorder(),
                              ),
                              child:
                                  Image.asset("assets/images/two-arrows1.png")),
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
