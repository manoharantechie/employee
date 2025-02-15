import 'dart:async';

import 'package:employee/common/custom_widget.dart';
import 'package:employee/common/localization/localizations.dart';
import 'package:employee/common/theme/custom_theme.dart';
import 'package:employee/screens/emp_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
  }

  onLoad() {
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeListScreen(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: CustomTheme.of(context)
              .primaryColorLight, // For iOS: (dark icons)
          statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
        ),
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: CustomTheme.of(context).focusColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.instance.text("loc_app_name"),
              style: CustomWidget(context: context).CustomSizedTextStyle(
                  26.0,
                  CustomTheme.of(context).primaryColor,
                  FontWeight.w500,
                  'FontRegular'),
            )
          ],
        ),
      ),
    );
  }
}
