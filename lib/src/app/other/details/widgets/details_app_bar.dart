import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';

class DetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  final void Function()? savePressed;
  const DetailsAppBar({Key? key, this.savePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kTabLabelPadding,
      height: kBottomNavigationBarHeight,
      //  color: Colors.yellow,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(width: 2, color: AppColors.lightBlue)),
                height: 40,
                width: 40,
                child: Center(
                  child: SvgImage(
                    'assets/icons/fi-br-angle-small-left.svg',
                    color: AppColors.textGrey,
                  ),
                )),
          ),
          Spacer(),
          Container(
              child:
                  Text('Job Details', style: TextStyles.smallHeaderTextStyle)),
          Spacer(),
          InkWell(
            onTap: savePressed!,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(width: 2, color: AppColors.lightBlue)),
                height: 40,
                width: 40,
                child: Center(
                  child: SvgImage(
                    'assets/icons/fi-br-bookmark.svg',
                    height: 15,
                    color: AppColors.textGrey,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kBottomNavigationBarHeight);
}
