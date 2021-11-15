part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class StartSeacrch extends SearchEvent {
  final String term;

  StartSeacrch(this.term);

  @override
  List<Object> get props => [this.term];
}

class LoadMore extends SearchEvent {
  final String? page;

  LoadMore({this.page});

  @override
  List<Object> get props => [];
}
