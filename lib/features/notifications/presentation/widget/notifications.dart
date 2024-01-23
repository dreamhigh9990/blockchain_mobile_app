import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(109), // Adjust the height as needed
          child: Stack(
            children: [
              Container(
                height: 188,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 54, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const Text(
                      'Notificaion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        // fontFamily: 'Jumper PERSONAL USE ONLY',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Image.asset("assets/images/down-arrow 6.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'This Week',
                style: TextStyle(
                  color: Color(0xFF7A7A7A),
                  fontSize: 12,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.24,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                  thickness: 2,
                  color: Colors.white.withOpacity(0.2199999988079071),
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isSentTransaction = index % 2 == 0;

                  return ListTile(
                    // tileColor: isSentTransaction ? Colors.blue : Colors.blue,
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: isSentTransaction
                              ? [Color(0xFF9963B7), Color(0xFF4710E4)]
                              : [Color(0xFF425AF1), Color(0xFF425AF1)],
                        ),
                        shape: OvalBorder(),
                      ),
                      child: Icon(
                        isSentTransaction
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: isSentTransaction ? Colors.white : Colors.white,
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSentTransaction ? 'Sent Money' : 'Received Money',
                          style: TextStyle(
                            color: Colors.white,
                            // isSentTransaction ? Colors.blue : Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.28,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    subtitle: SizedBox(
                      width: 283,
                      child: Text(
                        isSentTransaction
                            ? 'You Have Sent \$456.00 .. to Mr Clarke Something via Our App'
                            : 'You Have Received \$456.00 .. from Mr Smith via Our App',
                        style: TextStyle(
                          color:
                              isSentTransaction ? Colors.white : Colors.white,
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(20.0),
            //   child: Text(
            //     '29 - AUG - 2023',
            //     style: TextStyle(
            //       color: Color(0xFF7A7A7A),
            //       fontSize: 12,
            //       fontFamily: 'Lato',
            //       fontWeight: FontWeight.w400,
            //       height: 0,
            //       letterSpacing: 0.24,
            //     ),
            //   ),
            // ),
            // Expanded(
            //   flex: 5,
            //   child: ListView.separated(
            //     separatorBuilder: (context, index) => Divider(
            //       height: 30,
            //       indent: 20,
            //       endIndent: 20,
            //       thickness: 2,
            //       color: Colors.white.withOpacity(0.2199999988079071),
            //     ),
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       // final item = items[index];
            //       return ListTile(
            //         leading: Container(
            //           width: 44,
            //           height: 44,
            //           decoration: const ShapeDecoration(
            //             color: Color(0xFF425AF1),
            //             shape: OvalBorder(),
            //           ),
            //           child: const Icon(
            //             Icons.arrow_downward,
            //             color: Colors.white,
            //           ),
            //         ),
            //         title: const Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Received Money',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 14,
            //                 // fontFamily: 'Lato',
            //                 fontWeight: FontWeight.w400,
            //                 height: 0,
            //                 letterSpacing: 0.28,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             )
            //           ],
            //         ),
            //         subtitle: const SizedBox(
            //           width: 283,
            //           child: Text(
            //             'You Have Sent \$456.00 .. to Mr Clarke Something via Our App',
            //             style: TextStyle(
            //               color: Color(0xFF7A7A7A),
            //               fontSize: 12,
            //               fontFamily: 'Lato',
            //               fontWeight: FontWeight.w400,
            //               height: 0,
            //               letterSpacing: 0.24,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
