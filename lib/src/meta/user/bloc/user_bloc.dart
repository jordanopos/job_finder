import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/user/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UploadImage) {
      try {
        yield ImageUploading();
        String? imageLink = await _userRepository.uploadUserImage();

        if (imageLink == null) {
          yield ImageError("Something Went Wrong");
        } else {
          yield ImageUploaded(imageLink);
        }
      } catch (e) {
        print(e);
        yield ImageError("Something Went Wrong");
      }
    }
  }
}
