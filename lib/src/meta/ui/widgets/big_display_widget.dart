import 'package:flutter/material.dart';
import 'package:jobtora/src/app/other/details/pages/details_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';

class BigDisplayWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final EdgeInsetsGeometry? padding;
  const BigDisplayWidget(
      {Key? key, this.padding, required this.imagePath, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailsPage(
          postId: 1,
        );
      })),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(13)),
        margin: padding ?? EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Image.asset('assets/images/$imagePath', fit: BoxFit.cover),
              )),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 19,
                        spreadRadius: 4)
                  ]),
            ),
            Column(children: [
              Text('Ux Designer', style: TextStyles.smallHeaderTextStyle),
              Text('$name', style: TextStyles.normalTextStyle)
            ]),
            Text('FullTime, Kampala', style: TextStyles.normalTextStyleDarker)
          ],
        ),
      ),
    );
  }
}
