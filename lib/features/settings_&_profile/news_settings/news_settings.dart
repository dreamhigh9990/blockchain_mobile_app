import 'package:flutter/material.dart';

class NewsSettingScreen extends StatefulWidget {
  const NewsSettingScreen({super.key});

  @override
  State<NewsSettingScreen> createState() => _NewsSettingScreen();
}

class _NewsSettingScreen extends State<NewsSettingScreen> {
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
          'News',
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
            const Center(
              child: Text(
                'Latest Market News',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/bitcoin1.png"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Bitcons',
                          style: TextStyle(
                            color: Color(0xFF7A7A7A),
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.24,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 78,
                    height: 78,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/stakkking.png"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Stakes',
                          style: TextStyle(
                            color: Color(0xFF7A7A7A),
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.24,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 78,
                    height: 78,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/bitcoin1.png"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Bitcons',
                          style: TextStyle(
                            color: Color(0xFF7A7A7A),
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.24,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 78,
                    height: 78,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF161828),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/stakkking.png"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Stakes',
                          style: TextStyle(
                            color: Color(0xFF7A7A7A),
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.24,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 368,
              // height: 78,
              decoration: ShapeDecoration(
                color: const Color(0xFF161828),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'The cryptocurrency market, a dynamic and decentralized financial ecosystem, has captured the worlds \nattention with its rapid evolution. Bitcoin, the pioneering digital currency, set the stage for a myriad of cryptocurrencies that followed, creating a diverse landscape of blockchain-based assets.Investors and enthusiasts closely monitor the crypto markets fluctuations, as prices can experience significant volatility. The market operates 24/7, allowing for constant trading and investment activities across the globe. Blockchain technology, the backbone of cryptocurrencies, ensures transparency, security, and immutability in transactions.\nAltcoins, such as Ethereum, Ripple, and Litecoin, contribute to the markets diversity, each offering unique features and use cases. Initial Coin Offerings (ICOs) and decentralized finance (DeFi) projects have further expanded the scope of possibilities within the crypto space \n Regulatory developments play a crucial role in shaping the future of the crypto market. Governments and regulatory bodies worldwide are working to establish frameworks that balance innovation with investor protection. As mainstream adoption grows, traditional financial institutions are exploring ways to integrate cryptocurrencies into their services.\nThe crypto market continues to be a space of innovation, with ongoing developments in technology, governance, and financial instruments. Its journey involves overcoming challenges, fostering education, and paving the way for a more inclusive and decentralized financial future. Whether viewed as a speculative investment or a transformative force in finance, the crypto market remains a captivating and ever-evolving phenomenon',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
