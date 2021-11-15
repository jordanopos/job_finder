import 'package:flutter/material.dart';
import 'package:jobtora/src/app/other/category_details/pages/category_details_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      '🎨 Design',
      '📚 Accounting',
      '💼 Business',
      '👩‍💻 Development',
      '🏃‍♂️ Casual',
      '🙈 Google'
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        width: double.infinity,
        //  color: Colors.yellow,
        height: 210,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Categories', style: TextStyles.smallHeaderTextStyle),
                Spacer(),
                Text('See More', style: TextStyles.normalTextStyleBlue),
              ],
            ),
            SizedBox(height: 10),
            GridView.builder(
                itemCount: 6,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 55,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CategoryDetailsPage();
                      })),
                      splashColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            // border:
                            //     Border.all(width: 2, color: AppColors.lightBlue),
                            borderRadius: BorderRadius.circular(13),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            names[index],
                            style: TextStyles.normalTextStyle,
                          ),
                        ),
                        height: 10,
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
