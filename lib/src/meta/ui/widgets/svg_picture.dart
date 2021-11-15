import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';

class SvgImage extends StatelessWidget {
  final String path;
  final Color? color;
  final double? height;
  const SvgImage(this.path, {Key? key, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path,
        color: color ?? AppColors.darkBlue, height: height ?? 20);
  }
}
