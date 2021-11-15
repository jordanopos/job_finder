import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            color: AppColors.lightBlue,
            height: 110,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reminder 🔔',
                            style: TextStyles.smallHeaderTextStyle),
                        Container(height: 4),
                        Text(
                            'You have a flutter google controller interview name google apple controller',
                            style: TextStyles.normalTextStyle)
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              child: Center(
                                child: SvgImage(
                                    'assets/icons/fi-br-angle-small-right.svg',
                                    height: 25,
                                    color: Colors.white),
                              ),
                              height: 40,
                              width: 40,
                              color: AppColors.mainBlue),
                        )),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
