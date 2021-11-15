import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/main/home/widgets/search_field.dart';
import 'package:jobtora/src/app/main/search/bloc/search_bloc.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/small_display_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller = ScrollController();
  SearchBloc? searchBloc;
  SearchState? searchState;
  String? nextpage = "empty";

  @override
  void initState() {
    searchBloc = context.read<SearchBloc>();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          searchState is SearchFound &&
          nextpage != "empty") {
        loadMore();
      }
    });
    super.initState();
  }

  void loadMore() {
   // print("loading more");
    if (searchState is SearchFound && nextpage != "empty") {
      searchBloc?.add(LoadMore(page: nextpage));
    }
  }

  @override
  Widget build(BuildContext context) {
    var searchBloc = context.read<SearchBloc>();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Find Opportunities',
            style: TextStyles.smallHeaderTextStyle,
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 23.0, right: 23),
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SearchFeild(
                onChanged: (term) => searchBloc.add(StartSeacrch(term)),
                isActualSearch: true,
                margin: const EdgeInsets.only(),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  searchState = state;
                  if (state is Searching) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchFound) {
                    if (state.nextPageUrl != null) {
                      nextpage = state.nextPageUrl ?? "";
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 15,
                          ),
                          // Row(
                          //   children: [
                          //     Spacer(),
                          //     Text(
                          //       state.results.resultCount == 1
                          //           ? "${state.results.resultCount} result"
                          //           : "${state.results.resultCount} results",
                          //       style: TextStyles.normalTextStyleBlue,
                          //     )
                          //   ],
                          // ),
                          ListView.builder(
                              itemCount: state.results.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SmallDisplayWidget(
                                  postModel: state.results[index],
                                );
                              }),

                          if (nextpage != "empty")
                            ElevatedButton(
                                onPressed: () => loadMore(),
                                child: Text("Load More")),

                          if (nextpage == "empty")
                            Container(
                                child: Center(child: Text('No more Results')))
                        ],
                      ),
                    );
                  } else if (state is LoadingMoreResults) {
               //     print("i am loading more results");
                    return Column(
                      children: [
                        ListView.builder(
                            itemCount: state.results.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return state.results.length == 0
                                  ? Container(
                                      child: Center(
                                          child: Text("No results",
                                              style: TextStyles
                                                  .normalTextStyleBlue)))
                                  : SmallDisplayWidget(
                                      postModel: state.results[index],
                                    );
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text('Error'),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
