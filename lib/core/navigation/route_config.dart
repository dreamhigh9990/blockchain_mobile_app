import 'package:blockchain_mobile_app/core/navigation/route_name.dart';
import 'package:blockchain_mobile_app/features/check_otp/presentation/widget/check_otp.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/widget/sign_in_widget.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/screen/sign_up_screen.dart';
import 'package:blockchain_mobile_app/features/splash_screen/presentation/widget/splash_screen.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:flutter/material.dart';

class RouteConfig {
  Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.initialRoute:
        return _getInitialRoute();
      // case RouteName.demo:
      //   return _getDemoRoute();
      case RouteName.signUpRoute:
        return _getSignUpRoute();
      case RouteName.signInRoute:
        return _getSignInRoute();
      case RouteName.checkOtpRoute:
        return _getCheckOtpRoute();
      // case RouteName.newsFeedRoute:
      //   return _getNewsFeedRoute();
      case RouteName.dashboardRoute:
        return _getDashboardRoute();
      // case RouteName.profileRoute:
      //   return _getProfileRoute();
      // case RouteName.messageRoute:
      //   return _getMessageRoute();
      // case RouteName.chatRoute:
      //   return _getChatRoute();
      // case RouteName.followersRoute:
      //   return _getFollowersRoute();
      // case RouteName.exploreFriendsRoute:
      //   return _getExploreFriendsRoute();
      // case RouteName.settingsRoute:
      //   return _getSettingsRoute();
      // case RouteName.forgotPasswordRoute:
      //   return _getForgotPasswordRoute();
      // case RouteName.forgotPasswordCheckOtpRoute:
      //   return _getForgotPasswordCheckOtpRoute();
    }
    return _defaultRoute();
  }

  static MaterialPageRoute _routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static MaterialPageRoute _defaultRoute() {
    return _routeBuilder(
      const Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }

  static MaterialPageRoute _getInitialRoute() {
    return _routeBuilder(IntroductionPage());
  }

  // static MaterialPageRoute _getDemoRoute() {
  //   return _routeBuilder(const HomePage());
  // }

  static MaterialPageRoute _getSignUpRoute() {
    return _routeBuilder(const SignUpScreen());
  }

  static MaterialPageRoute _getSignInRoute() {
    return _routeBuilder(SignInWidget());
  }

  static MaterialPageRoute _getCheckOtpRoute() {
    return _routeBuilder(const CheckOtpScreen());
  }

  // static MaterialPageRoute _getNewsFeedRoute() {
  //   return _routeBuilder(const NewsFeedScreen());
  // }

  static MaterialPageRoute _getDashboardRoute() {
    return _routeBuilder(Dashboard());
  }

  // static MaterialPageRoute _getProfileRoute() {
  //   return _routeBuilder(const ProfileScreen());
  // }

  // static MaterialPageRoute _getMessageRoute() {
  //   return _routeBuilder(MessageWidget());
  // }

  // static MaterialPageRoute _getChatRoute() {
  //   return _routeBuilder(const ChatWidget());
  // }

  // static MaterialPageRoute _getFollowersRoute() {
  //   return _routeBuilder(FollowerWidget());
  // }

  // static MaterialPageRoute _getExploreFriendsRoute() {
  //   return _routeBuilder(ExploreFriendsWidget());
  // }

  // static MaterialPageRoute _getSettingsRoute() {
  //   return _routeBuilder(SettingsWidget());
  // }

  // static MaterialPageRoute _getForgotPasswordRoute() {
  //   return _routeBuilder(ForgotPasswordSendOtp());
  // }
  // static MaterialPageRoute _getForgotPasswordCheckOtpRoute() {
  //   return _routeBuilder(ForgotPasswordCheckOtp());
  // }
}
