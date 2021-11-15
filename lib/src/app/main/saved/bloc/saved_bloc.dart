import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:jobtora/src/meta/models/saved_posts_model.dart';
import 'package:jobtora/src/meta/user/repository/user_repository.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final UserRepository _userRepository;
  SavedBloc(this._userRepository) : super(SavedInitial());

  @override
  Stream<SavedState> mapEventToState(SavedEvent event) async* {
    if (event is GetSaved) {
      try {
        yield LoadingSaved();

        SavedPostsModel? gottenPosts = await _userRepository.getSavedPosts();

        if (gottenPosts != null) {
          yield LoadedSaved(gottenPosts);
        } else {
          yield LoadedError();
        }
      } catch (e) {}
    }
  }
}
