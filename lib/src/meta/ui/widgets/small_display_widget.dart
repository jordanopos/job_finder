import 'package:flutter/material.dart';
import 'package:jobtora/src/app/other/details/pages/details_page.dart';
import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';

class SmallDisplayWidget extends StatelessWidget {
  final PostModel? postModel;
  const SmallDisplayWidget({Key? key, this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return postModel == null
        ? Container()
        : InkWell(
            splashColor: Colors.transparent,
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsPage(
                postId: postModel!.id,
              );
            })),
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(13),
                  //   color: AppColors.white,
                  // ),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 7, left: 10, top: 3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              child: Center(
                                  child: Image.network(
                                      postModel!.company.image!,
                                      height: 50)),
                              height: 80,
                              width: 80,
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
                          ),
                          Container(width: 3),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 14,
                                          child: Text(postModel!.jobTitle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyles
                                                  .smallHeaderTextStyle),
                                        ),
                                        Spacer(),
                                        Container(width: 4),
                                        postModel!.saves!.length != 0
                                            ? Icon(Icons.bookmark,
                                                color: AppColors.darkBlue)
                                            : Icon(Icons.bookmark_border)
                                        // : SvgImage(
                                        //     'assets/icons/fi-br-bookmark.svg',
                                        //     height: 17,
                                        //     color: AppColors.darkBlue),
                                      ],
                                    ),
                                    Text(postModel!.company.name!,
                                        style: TextStyles.normalTextStyle),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text('FullTime, Kampala',
                                            style: TextStyles
                                                .normalTextStyleDarker),
                                        Spacer(),
                                        postModel!.applications.length != 0
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Container(
                                                  color: AppColors.mainBlue,
                                                  height: 20,
                                                  child: Center(
                                                    child: Text(
                                                      "Applied",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              AppFonts.medium),
                                                    ),
                                                  ),
                                                  width: 50,
                                                ),
                                              )
                                            : Text("")
                                      ],
                                    )
                                  ])),
                            ),
                          )
                        ]),
                  ),
                ),
                Divider(
                  height: 0,
                )
              ],
            ),
          );
  }
}
