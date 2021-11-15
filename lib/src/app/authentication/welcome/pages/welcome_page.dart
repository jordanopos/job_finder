import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: <Widget>[
          Image.asset("assets/images/welcome_image.jpg",
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              fit: BoxFit.cover),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                    stops: [
                  0.0,
                  1.0
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                    stops: [
                  0.0,
                  1.0
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
