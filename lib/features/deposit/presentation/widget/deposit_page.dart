import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
                      'Deposit',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 27,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Please Fill The Form to Exchange Currency',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  'From Wallet',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 12,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    height: 0.14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.lato(
                        color: const Color(0xff7A7A7A),
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                    labelText:
                        "Select Wallet", // Change "Phone Number" to "Password"
                    hintText: "Wallet", // Adjust hint text
                    fillColor: const Color(0xff181328), // Fill color
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Colors.white.withOpacity(0.5),
                    //   size: 16,
                    // ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  'To Wallet',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 12,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    height: 0.14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.lato(
                        color: const Color(0xff7A7A7A),
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                    labelText:
                        "Select Wallet", // Change "Phone Number" to "Password"
                    hintText: "Wallet", // Adjust hint text
                    fillColor: const Color(0xff181328), // Fill color
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Colors.white.withOpacity(0.5),
                    //   size: 16,
                    // ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  'You will give',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 12,
                    // fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    height: 0.14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                child: TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.lato(
                        color: const Color(0xff7A7A7A),
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                    labelText:
                        "\$750.00", // Change "Phone Number" to "Password"
                    hintText: "Amount", // Adjust hint text
                    fillColor: const Color(0xff181328), // Fill color
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Colors.white.withOpacity(0.5),
                    //   size: 16,
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      // color: const Color(0xff1974B3),
                      gradient: const LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                      borderRadius: BorderRadius.circular(5)),
                  child: MaterialButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   final userName = _emailController.text;
                      //   final password = _passwordController.text;
                      //   print("$userName and $password");
                      // Form is valid, you can proceed with login
                      // final email = _emailController.text;
                      // final password = _passwordController.text;

                      // // Perform your login logic here
                      // BlocProvider.of<LoginCubit>(context).login(
                      //     email: _emailController.text,
                      //     password: _passwordController.text,
                      //     device: "app");
                      // }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(140, 20, 140, 20),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
