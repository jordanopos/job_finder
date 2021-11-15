import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/main/saved/bloc/saved_bloc.dart';
import 'package:jobtora/src/meta/models/saved_posts_model.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/ui/widgets/small_display_widget.dart';
import 'package:provider/provider.dart';
import 'package:jobtora/src/meta/user/repository/user_repository.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var savedBloc = context.read<SavedBloc>();
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => savedBloc.add(GetSaved()),
              )
            ],
            centerTitle: true,
            title: Text(
              'Saved',
              style: TextStyles.smallHeaderTextStyle,
            )),
        body: BlocBuilder<SavedBloc, SavedState>(
          builder: (context, state) {
            if (state is LoadingSaved) {
              return Center(child: Text("loading"));
            } else if (state is LoadedSaved) {
              return ListView.builder(
                  itemCount: state.model.posts.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  itemBuilder: (context, index) {
                    return SmallDisplayWidget(
                      postModel: state.model.posts[index].post,
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
