import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

showAppLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: Color(0xff1974B3),
        secondRingColor: Color(0xffD9D9D9),
        thirdRingColor: Color.fromARGB(157, 217, 217, 217),
        size: 50,
      ),
    ),
  );
}
