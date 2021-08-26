import 'package:dartz/dartz.dart';
import 'package:rick_end_morty/core/error/exception.dart';
import 'package:rick_end_morty/core/error/failure.dart';
import 'package:rick_end_morty/core/platform/network_info.dart';
import 'package:rick_end_morty/feature_persons/data/data_sources/person_local_datasource.dart';
import 'package:rick_end_morty/feature_persons/data/data_sources/person_remote_datasource.dart';
import 'package:rick_end_morty/feature_persons/data/models/person_model.dart';
import 'package:rick_end_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_end_morty/feature_persons/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource personRemoteDataSource;
  final PersonLocalDataSource personLocalDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.personRemoteDataSource,
      required this.personLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return personRemoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return personRemoteDataSource.searchPersons(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        personLocalDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson =
            await personLocalDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
