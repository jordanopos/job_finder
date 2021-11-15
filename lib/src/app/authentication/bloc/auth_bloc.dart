import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtora/src/app/authentication/repository/auth.repository.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/models/auth_user_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final HiveRepository _storage;
  final AuthenticationRepository _authenticationRepository;
  AuthBloc(this._storage, this._authenticationRepository)
      : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      try {
        yield Authenticating();

        ResponseWrapper? wrapper =
            await _authenticationRepository.login(event.userAuthModel);

        if (wrapper?.token == null || wrapper == null) {
          var message =
              wrapper?.message ?? 'An Error occured, Please try again';
          yield AuthError(message);
        } else {
          await _storage.saveData("auth", "token", wrapper.token);

          var token = await _storage.getData('token', "auth");
       //   print(token.toString());
          if (token != null) {
            yield Authenticated();
          } else {
            yield AuthError("An error occured, Please try again");
          }
        }
      } catch (e) {
        yield AuthError("An error occured, Please try again");
      }
    } else if (event is RegisterEvent) {
      try {
        yield Authenticating();

        ResponseWrapper? wrapper =
            await _authenticationRepository.signUp(event.userAuthModel);

        if (wrapper?.token == null || wrapper == null) {
          var message = wrapper!.error!.values.first
              .toString()
              .replaceAll('[', '')
              .replaceAll("]", '');

          yield AuthError(message.toString());
        } else {
          await _storage.saveData("auth", "token", wrapper.token);

          var token = await _storage.getData('token', "auth");
      //    print(token.toString());
          if (token != null) {
            yield Authenticated();
          } else {
            yield AuthError("An error occured, Please try again");
          }
        }
      } catch (e) {
        yield AuthError("An error occured, Please try again");
      }
    }
  }
}
