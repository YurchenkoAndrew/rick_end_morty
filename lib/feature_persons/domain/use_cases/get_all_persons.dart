import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/core/use_cases/use_case.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_end_morty/feature_persons/domain/repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
