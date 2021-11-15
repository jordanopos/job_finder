import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtora/src/app/authentication/bloc/auth_bloc.dart';
import 'package:jobtora/src/app/authentication/signin/pages/login_page.dart';
import 'package:jobtora/src/meta/models/auth_user_model.dart';
import 'package:jobtora/src/meta/ui/pages/nav_page.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthBloc>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        appBar: AppBar(
            title: Text('SignUp', style: const TextStyle(color: Colors.black))),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.message)));
            }
            if (state is Authenticated) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Signed up as ${emailController.text}')));
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return NavPage();
              }));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              TextField(controller: firstNameController),
              TextField(controller: lastNameController),
              TextField(controller: emailController),
              TextField(controller: passwordController),
              TextField(controller: passwordConfirmationController),
              Container(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                    return MaterialButton(
                        disabledColor: AppColors.lightBlue,
                        color: AppColors.mainBlue,
                        child: Center(
                            child: Text('Sign Up',
                                style: TextStyle(color: Colors.white))),
                        onPressed: state is Authenticating
                            ? null
                            : () => authBloc.add(RegisterEvent(
                                userAuthModel: UserAuthModel(
                                    email: emailController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    passwordConfirmation:
                                        passwordConfirmationController.text,
                                    password: passwordController.text))));
                  })),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  child: Text('Login Instead'))
            ]),
          ),
        ));
  }
}
