part of 'saved_bloc.dart';

abstract class SavedState extends Equatable {
  const SavedState();
}

class SavedInitial extends SavedState {
  @override
  List<Object> get props => [];
}

class LoadingSaved extends SavedState {
  @override
  List<Object> get props => [];
}

class LoadedSaved extends SavedState {
  final SavedPostsModel model;

  LoadedSaved(this.model);

  @override
  List<Object> get props => [this.model];
}

class LoadedError extends SavedState {
  @override
  List<Object> get props => [];
}
