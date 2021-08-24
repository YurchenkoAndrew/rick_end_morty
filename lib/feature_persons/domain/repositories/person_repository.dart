import 'package:dartz/dartz.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
