import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/authentication/bloc/auth_bloc.dart';
import 'package:jobtora/src/app/authentication/signup/pages/signup_page.dart';
import 'package:jobtora/src/meta/models/auth_user_model.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthBloc>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark));

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
              title: Text('Login Page',
                  style: const TextStyle(color: Colors.black))),
          body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(state.message)));
                }
                if (state is Authenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Authenticated as ${emailController.text}')));
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return NavPage();
                  }));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(controller: emailController),
                      TextField(controller: passwordController),
                      Container(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return MaterialButton(
                                disabledColor: AppColors.lightBlue,
                                color: AppColors.mainBlue,
                                child: Center(
                                    child: Text('Login',
                                        style: TextStyle(color: Colors.white))),
                                onPressed: state is Authenticating
                                    ? null
                                    : () => authBloc.add(
                                          LoginEvent(
                                              userAuthModel: UserAuthModel(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)),
                                        ),
                              );
                            },
                          )),
                      Container(height: 20),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));
                          },
                          child: Text('Register Instead'))
                    ]),
              ))),
    );
  }
}
