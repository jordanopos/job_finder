part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class ImageUploading extends UserState {
  @override
  List<Object?> get props => [];
}

class ImageUploaded extends UserState {
  final String imageLink;

  ImageUploaded(this.imageLink);
  @override
  List<Object?> get props => [this.imageLink];
}



class ImageError extends UserState {
  final String message;

  ImageError(this.message);
  @override
  List<Object?> get props => [this.message];
}