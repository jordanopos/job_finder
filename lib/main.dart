import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobtora/src/app/authentication/bloc/auth_bloc.dart';
import 'package:jobtora/src/app/authentication/repository/auth.repository.dart';
import 'package:jobtora/src/app/authentication/signin/pages/login_page.dart';
import 'package:jobtora/src/app/main/saved/bloc/saved_bloc.dart';
import 'package:jobtora/src/app/main/search/bloc/search_bloc.dart';
import 'package:jobtora/src/app/main/search/repository/search_repository.dart';
import 'package:jobtora/src/app/other/details/bloc/details_bloc.dart';
import 'package:jobtora/src/app/other/details/repository/details_repository.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/themes/app_fonts.dart';
import 'package:jobtora/src/meta/user/bloc/user_bloc.dart';
import 'package:jobtora/src/meta/user/repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(TheJobIndex(
    detailsRepository: DetailsImpl(),
    searchRepository: SearchImpl(),
    userRepository: UserImpl(),
    authRepo: AuthImpl(),
    hiveRepository: HiveImpl(),
  ));
}

class TheJobIndex extends StatelessWidget {
  final DetailsRepository detailsRepository;
  final AuthenticationRepository authRepo;
  final HiveRepository hiveRepository;
  final UserRepository userRepository;
  final SearchRepository searchRepository;
  const TheJobIndex(
      {Key? key,
      required this.hiveRepository,
      required this.authRepo,
      required this.detailsRepository,
      required this.searchRepository,
      required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HiveRepository>(create: (context) => HiveImpl()),
        RepositoryProvider<UserRepository>(create: (context) => UserImpl())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(searchRepository)),
          BlocProvider<DetailsBloc>(
              create: (context) => DetailsBloc(detailsRepository, userRepository)),
          BlocProvider<UserBloc>(create: (context) => UserBloc(userRepository)),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(hiveRepository, authRepo),
          ),
          BlocProvider<SavedBloc>(
            create: (context) => SavedBloc(userRepository)..add(GetSaved()),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme:
                    AppBarTheme(elevation: 0, color: AppColors.backgroundColor),
                scaffoldBackgroundColor: AppColors.backgroundColor,
                fontFamily: AppFonts.regular),
            home: Decider(storage: hiveRepository),
            title: 'The Job Index'),
      ),
    );
  }
}

class Decider extends StatefulWidget {
  final HiveRepository storage;
  const Decider({Key? key, required this.storage}) : super(key: key);

  @override
  _DeciderState createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.storage.getData('token', "auth"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return LoginPage();
            } else {
              return NavPage();
            }
          } else {
            return Scaffold(body: Center(child: Text('Jobtor')));
          }
        });
  }
}
