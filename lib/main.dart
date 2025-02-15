import 'package:employee/bloc/emp_bloc.dart';
import 'package:employee/common/localization/localizations.dart';
import 'package:employee/common/theme/custom_theme.dart';
import 'package:employee/common/theme/themes.dart';
import 'package:employee/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

    statusBarColor: Color(0xFFFFFFFF),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark, // status bar icon color
    systemNavigationBarIconBrightness:
    Brightness.dark, // color of navigation controls
  ));


  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context) => EmpBloc()),
      ],
      child:    MaterialApp(
          navigatorKey: navigatorKey,
          title: "Employee",
          theme: CustomTheme.of(context),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          })
    );

  }
}