part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class Searching extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchFound extends SearchState {
  final String? nextPageUrl;
  final List<PostModel> results;

  SearchFound(this.results, this.nextPageUrl);
  @override
  List<Object?> get props => [this.results, this.nextPageUrl];
}

class SearchError extends SearchState {
  @override
  List<Object?> get props => [];
}

class LoadingMoreResults extends SearchState {
  final List<PostModel> results;

  LoadingMoreResults(this.results);

  @override
  List<Object?> get props => [this.results];
}
