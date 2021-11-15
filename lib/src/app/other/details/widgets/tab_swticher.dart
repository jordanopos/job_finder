import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';

class TabContainer extends StatelessWidget {
  final List<String> strings;
  final int currentIndex;
  final int index;
  const TabContainer(
      {Key? key,
      required this.strings,
      required this.currentIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: index != currentIndex
                  ? Colors.transparent
                  : Colors.grey[200]!,
              spreadRadius: 3,
              blurRadius: 10)
        ],
        color: index == currentIndex ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width / strings.length - 35,
      child: Center(
          child: Text(strings[index],
              style: index == currentIndex
                  ? TextStyles.normalTextStyleBlue
                  : TextStyles.normalTextStyle)),
    );
  }
}
