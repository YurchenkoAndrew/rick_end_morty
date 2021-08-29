import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_end_morty/core/platform/network_info.dart';
import 'package:rick_end_morty/feature_persons/data/data_sources/person_local_datasource.dart';
import 'package:rick_end_morty/feature_persons/data/data_sources/person_remote_datasource.dart';
import 'package:rick_end_morty/feature_persons/data/repositories/person_repository_impl.dart';
import 'package:rick_end_morty/feature_persons/domain/repositories/person_repository.dart';
import 'package:rick_end_morty/feature_persons/domain/use_cases/get_all_persons.dart';
import 'package:rick_end_morty/feature_persons/domain/use_cases/search_person.dart';
import 'package:rick_end_morty/feature_persons/presentation/manager/person_list_cubit/person_list_cubit.dart';
import 'package:rick_end_morty/feature_persons/presentation/manager/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc & Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));
  //UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));
  //Repositories
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      personRemoteDataSource: sl(),
      personLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );
  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));
  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
