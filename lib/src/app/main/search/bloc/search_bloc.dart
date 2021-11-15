import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jobtora/src/meta/models/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtora/src/app/main/search/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _repository;
  SearchBloc(this._repository) : super(SearchInitial());

  List<PostModel> list = [];

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is StartSeacrch) {
      yield Searching();

      try {
        final results = await _repository.getResults(event.term);

        list = results!.results.data;

        yield SearchFound(list, results.results.nextPageUrl!);
      } catch (e) {
        print(e);

        yield SearchError();
      }
    } else if (event is LoadMore) {
      yield LoadingMoreResults(list);

      try {
        final results = await _repository.getMoreResults(event.page!);

        list.addAll(results!.results.data);

     //   print(list.toString());

        if (list.isNotEmpty) {
          yield SearchFound(list, results.results.nextPageUrl!);
        }
      } catch (e) {
        print(e);
        yield SearchError();
      }
    }
  }
}
