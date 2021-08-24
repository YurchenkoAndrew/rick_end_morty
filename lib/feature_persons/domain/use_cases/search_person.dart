import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/core/use_cases/use_case.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_end_morty/feature_persons/domain/repositories/person_repository.dart';

class SearchPersons extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
