import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';

class SearchFeild extends StatelessWidget {
  final void Function(String)? onChanged;
  final bool isActualSearch;
  final EdgeInsetsGeometry? margin;
  const SearchFeild(
      {Key? key, this.margin, required this.isActualSearch, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 25),
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: isActualSearch
                            ? TextField(
                                onSubmitted: onChanged,
                                cursorColor: AppColors.mainBlue,
                                decoration: const InputDecoration(
                                    hintText: 'Eg Product Designer',
                                    hintStyle: TextStyles.normalTextStyle,
                                    border: InputBorder.none))
                            : const Text(
                                'Eg Product Designer',
                                style: TextStyles.normalTextStyle,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(width: 2, color: AppColors.lightBlue)),
            ),
          ),
          Container(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgImage(
                    'assets/icons/fi-br-settings-sliders.svg',
                    color: AppColors.mainBlue,
                    height: 18,
                  ),
                ],
              ),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(width: 2, color: AppColors.lightBlue)),
            ),
          )
        ],
      ),
    );
  }
}
