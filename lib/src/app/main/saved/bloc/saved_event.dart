part of 'saved_bloc.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();
}




class GetSaved extends SavedEvent{
  
  @override
  List<Object> get props => [];
}