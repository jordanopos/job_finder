import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/other/details/bloc/details_bloc.dart';
import 'package:jobtora/src/app/other/details/widgets/details_app_bar.dart';
import 'package:jobtora/src/app/other/details/widgets/tab_swticher.dart';
import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/slide_to_act.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final int? postId;
  const DetailsPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SlideActionState> _key = GlobalKey();

    var detailsBloc = context.read<DetailsBloc>()..add(GetPostDetails(postId!));

    return SafeArea(
      child: Scaffold(
        appBar: DetailsAppBar(
          savePressed: () => detailsBloc.add(SavePostEvent(postId!)),
        ),
        body: BlocListener<DetailsBloc, DetailsState>(
          listener: (context, state) {
            if (state is PostSaveError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Error saving post")));
            }
            if (state is ApplicationSaveError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("An error occurred, please try again")));
            }
            if (state is PostSaved) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, globalState) {
              if (globalState is Loading) {
                return Center(
                  child: Text('loading'),
                );
              } else if (globalState is PostLoaded) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            child: Center(
                                child: Image.network(
                                    globalState.model!.company.image!,
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
                          SizedBox(height: 16),
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Text(globalState.model!.jobTitle,
                                    style: TextStyles.bigHeaderTextStyle),
                                SizedBox(height: 6),
                                Text(globalState.model!.company.name!,
                                    style: TextStyles.normalTextStyle),
                                Text(globalState.model!.viewsCount.toString(),
                                    style: TextStyles.normalTextStyle),
                                SizedBox(height: 6),
                                Text(
                                    '${globalState.model!.jobType}, ${globalState.model!.company.location}',
                                    style: TextStyles.normalTextStyleDarker)
                              ])),
                          Container(height: 30),
                          JobAndCompanyDetails()
                        ], //
                      ),
                    ),
                    Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: BlocBuilder<DetailsBloc, DetailsState>(
                                builder: (context, state) {
                                  if (state is AppliedForPost ||
                                      globalState.model!.applications.length !=
                                          0) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Container(
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "Applied Successfully",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: AppFonts.medium),
                                            ),
                                          ),
                                          color: AppColors.mainBlue),
                                    );
                                  }
                                  return Container(
                                    // height: kBottomNavigationBarHeight - 4,
                                    child: SlideAction(
                                      borderRadius: 16,
                                      innerColor: AppColors.white,
                                      outerColor: AppColors.mainBlue,
                                      text: 'Take Opportunity',
                                      textStyle: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 15,
                                        fontFamily: AppFonts.medium,
                                      ),
                                      key: _key,
                                      elevation: 0,
                                      sliderButtonIcon: Container(
                                        child: SvgImage(
                                          'assets/icons/fi-br-briefcase.svg',
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      onSubmit: () {
                                        detailsBloc.add(ApplyForPostEvent(
                                            globalState.model!.id!));
                                        _key.currentState!.reset();
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        height: MediaQuery.of(context).size.height)
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class JobAndCompanyDetails extends StatefulWidget {
  JobAndCompanyDetails({Key? key}) : super(key: key);

  @override
  _JobAndCompanyDetailsState createState() => _JobAndCompanyDetailsState();
}

class _JobAndCompanyDetailsState extends State<JobAndCompanyDetails> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(33), topLeft: Radius.circular(33)),
            color: AppColors.white),
        child: Container(
            margin: const EdgeInsets.only(top: 30, right: 23, left: 23),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(width: 2, color: AppColors.lightBlue)),
                  height: 50,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 2),
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() => currentIndex = index),
                          child: TabContainer(
                              strings: ['Description', 'Company'],
                              currentIndex: currentIndex,
                              index: index),
                        );
                      })),
              Container(height: 30),
              Container(
                  child:
                      currentIndex == 0 ? JobDescription() : CompanyDetails())
            ])));
  }
}

class JobDescription extends StatelessWidget {
  const JobDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> skills = [
      'Uganda Certificate of Education with a pass in English Language',
      'Valid Driving Permit of Class C or D',
      'fffffdklaj; dlkj adlkj flkaj '
          'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'then controler whenr goole controlle rhwen google ap',
      'thenc otnroller wehn ',
      'the controllr when googlecontroller when googlecontoller hwenr goog'
    ];
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('📗 Job Description', style: TextStyles.smallHeaderTextStyle),
      Container(height: 8),
      Text(
          'Accomplishes electrical engineering human resource objectives by recruiting, selecting, orienting, training, assigning, scheduling, coaching, counseling, and disciplining employees; communicating job expectations; planning, monitoring, appraising, and reviewing job contributions; planning and reviewing compensation actions; enforcing policies and procedures.Achieves electrical engineering operational objectives by contributing electrical engineering information and recommendations to strategic plans and reviews; preparing and completing action plans; implementing production, productivity, quality, and customer-service standards; resolving problems; completing audits; identifying trends; determining administrative system improvements; implementing change.',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.openSans,
              height: 1.4,
              color: AppColors.textGrey)),
      Container(height: 25),
      Text('⚡ Skills', style: TextStyles.smallHeaderTextStyle),
      Container(height: 8),
      Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: skills
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('• $e',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.openSans,
                                height: 1.4,
                                color: AppColors.textGrey)),
                      ))
                  .toList()))
    ]));
  }
}

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
