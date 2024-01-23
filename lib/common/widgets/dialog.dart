import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;

  CustomDialog({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff161828),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff9963B7), Color(0xff4710E4)],
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                child: Text(
                  buttonText,
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
  }
}

// Example usage:
void _showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        imagePath: 'assets/images/quality.png',
        title: 'CONGRATULATIONS',
        subtitle: 'You have successfully verified Your Account',
        buttonText: 'Confirm',
      );
    },
  );
}
