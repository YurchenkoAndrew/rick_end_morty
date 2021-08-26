import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/feature_persons/domain/use_cases/search_person.dart';
import 'package:rick_end_morty/feature_persons/presentation/manager/search_bloc/search_event.dart';
import 'package:rick_end_morty/feature_persons/presentation/manager/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();
    final failureOrPerson =
        await searchPerson.call(SearchPersonParams(query: personQuery));
    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure!';
      case CacheFailure:
        return 'Cache failure!';
      default:
        return 'Unexpected error!';
    }
  }
}
