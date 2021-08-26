import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_end_morty/feature_persons/domain/use_cases/get_all_persons.dart';
import 'package:rick_end_morty/feature_persons/presentation/manager/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());
  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) {
      return;
    }
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));
    failureOrPerson.fold((error) => PersonError(message: _mapFailureToMessage(error)), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
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
