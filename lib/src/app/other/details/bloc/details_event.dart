part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class SavePostEvent extends DetailsEvent {
  final int id;

  SavePostEvent(this.id);
}

class ApplyForPostEvent extends DetailsEvent {
  final int id;

  ApplyForPostEvent(this.id);
}

class GetPostDetails extends DetailsEvent {
  final int id;

  GetPostDetails(this.id);
}
