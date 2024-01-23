import 'package:blockchain_mobile_app/common/cubit/locale/locale_cubit.dart';
import 'package:blockchain_mobile_app/core/dependency.dart';
import 'package:blockchain_mobile_app/core/navigation/route_config.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

final routeConfig = RouteConfig();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Dependency.providers,
      child: _buildMaterialApp(),
    );
  }

  final lightTheme = ThemeData(
    // textTheme: GoogleFonts.montserratTextTheme(),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple,
    ),
    useMaterial3: true,
  );

  final darkTheme = ThemeData.dark().copyWith(
     textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white),
    // textTheme: GoogleFonts.montserratTextTheme(),
    scaffoldBackgroundColor: const Color(0xFF221933),
    iconTheme: const IconThemeData(
        color: Colors.deepPurpleAccent), // Customize the icon color
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
            const Color(0xff7200e0)), // Customize the text button color
      ),
    ),
    // Customize your dark theme properties here.

    buttonTheme: ButtonThemeData(
      // Customize the ElevatedButton style with a gradient background
      alignedDropdown: true,
      buttonColor: Colors.transparent,
      textTheme: ButtonTextTheme.primary,
      height: 50.0, // Adjust the button height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
  BlocBuilder<LocaleCubit, LocaleState> _buildMaterialApp() {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          theme: darkTheme,
          // ThemeData(

          //   textTheme: GoogleFonts.montserratTextTheme(),
          // ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routeConfig.routes,
          // supportedLocales: _supportedLocale,
          // localizationsDelegates: _localizationDelegates,
          // localeResolutionCallback: localeResolution,
          // locale: state.getCurrentLocale(),
          builder: EasyLoading.init(),
        );
      },
    );
  }

  // final _supportedLocale = [
  //   const Locale(StringRes.kLangCodeEN, StringRes.kLangCountryUS),
  //   const Locale(StringRes.kLangCodeBN, StringRes.kLangCountryBD),
  // ];

  // final _localizationDelegates = [
  //   AppLocalizations.delegate,
  //   GlobalMaterialLocalizations.delegate,
  //   GlobalCupertinoLocalizations.delegate,
  //   GlobalWidgetsLocalizations.delegate,
  // ];

  // Locale localeResolution(locale, supportedLocales) {
  //   for (var supportedLocale in supportedLocales) {
  //     if (supportedLocale.languageCode == locale.languageCode &&
  //         supportedLocale.countryCode == locale.countryCode) {
  //       return supportedLocale;
  //     }
  //   }
  //   return supportedLocales.first;
  // }
}
