part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class PostSaved extends DetailsState {
  final String message;

  PostSaved(this.message);
}

class AppliedForPost extends DetailsState {
  final String message;

  AppliedForPost(this.message);
}

class PostSaveError extends DetailsState {}

class ApplicationSaveError extends DetailsState {}

class Loading extends DetailsState {}

class PostLoaded extends DetailsState {
  final PostModel? model;

  PostLoaded(this.model);
}
