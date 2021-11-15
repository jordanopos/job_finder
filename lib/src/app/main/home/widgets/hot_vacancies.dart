import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/big_display_widget.dart';

class HotVacancies extends StatelessWidget {
  final String name;
  const HotVacancies({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      //  color: Colors.yellow,
      margin: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name',
            style: TextStyles.smallHeaderTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //  color: Colors.yellow,
            height: 200,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemCount: companyNames.length,
                itemBuilder: (context, index) {
                  return BigDisplayWidget(
                    name: companyNames[index],
                    imagePath: companyLogos[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
