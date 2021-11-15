import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/small_display_widget.dart';

class LatestJobs extends StatelessWidget {
  const LatestJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 600,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⏱️ Latest Openings',
            style: TextStyles.smallHeaderTextStyle,
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SmallDisplayWidget(
                    
                  );
                }),
          )
        ],
      ),
    );
  }
}
