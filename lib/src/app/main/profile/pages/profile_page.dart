import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/authentication/repository/auth.repository.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/user/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authRepository = context.read<HiveRepository>();
    var userBloc = context.read<UserBloc>();
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ImageError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is ImageUploading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ImageUploaded) {
                  return Image.network(state.imageLink);
                }
                return TextButton(
                    onPressed: () => userBloc.add(UploadImage()),
                    child: Text("Upload image"));
              },
            ),
            InkWell(
                onTap: () => authRepository.deleteData('auth', "token"),
                child: Text('Logout')),
          ],
        )),
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyles.smallHeaderTextStyle,
            )),
      ),
    );
  }
}
