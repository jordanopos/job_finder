import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtora/src/app/other/details/repository/details_repository.dart';
import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:jobtora/src/meta/user/repository/user_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final UserRepository userRepository;
  final DetailsRepository _repository;
  DetailsBloc(this._repository, this.userRepository) : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is SavePostEvent) {
      try {
        var message =
            await _repository.saveOrUnsavePost(event.id, userRepository);

        if (message != null) {
          yield PostSaved(message);
        } else {
          yield PostSaveError();
        }
      } catch (e) {
        print(e);
        yield PostSaveError();
      }
    } else if (event is ApplyForPostEvent) {
      try {
        bool? applied = await _repository.applyForPost(event.id);

        if (applied!) {
          yield AppliedForPost("Applied successfully");
        } else {
          yield ApplicationSaveError();
        }
      } catch (e) {
        print(e);
        yield ApplicationSaveError();
      }
    } else if (event is GetPostDetails) {
      yield Loading();

      try {
        PostModel? model = await _repository.getPostDetails(event.id);

        print(model!.jobTitle);

        yield PostLoaded(model);
      } catch (e) {
        print(e);
      }
    }
  }
}
