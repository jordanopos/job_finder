import 'package:flutter/material.dart';
import 'package:jobtora/src/app/main/home/widgets/categories.dart';
import 'package:jobtora/src/app/main/home/widgets/hot_vacancies.dart';
import 'package:jobtora/src/app/main/home/widgets/latest_jobs.dart';
import 'package:jobtora/src/app/main/home/widgets/reminder_widget.dart';
import 'package:jobtora/src/app/main/home/widgets/search_field.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';
import 'package:faker/faker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgImage('assets/icons/fi-br-bell.svg', height: 20),
              ],
            ),
            Spacer(),
            Text(
              'JobTora',
              style: TextStyles.smallHeaderTextStyle,
            ),
            Spacer(),
            Container(
              decoration:
                  BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      Faker().image.image(keywords: ['person', 'close'])),
                ),
              )),
              height: 48,
              width: 48,
            )
          ],
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 23, left: 23),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hey, Jordan 👋', style: TextStyles.bigHeaderTextStyle),
                ReminderWidget(),
                SearchFeild(isActualSearch: false),
                Container(height: 10),
                HotVacancies(name: "👍 Similar to Jumia"),
                HotVacancies(name: "🔥 Hot Vacancies"),
                LatestJobs()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
