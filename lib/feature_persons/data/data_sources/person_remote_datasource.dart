import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_end_morty/core/error/exception.dart';
import 'package:rick_end_morty/feature_persons/data/models/person_model.dart';

// Реализуем контракт
abstract class PersonRemoteDataSource {
  // "https://rickandmortyapi.com/api/character/?page=2"
  Future<List<PersonModel>> getAllPersons(int page);

  // "https://rickandmortyapi.com/api/character/?page=2&name=rick"
  Future<List<PersonModel>> searchPersons(String query);
}

// Реализуем имплементацию от контракта
class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonsFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPersons(String query) => _getPersonsFromUrl(
      'https://rickandmortyapi.com/api/character/?page=2&name=$query');

  Future<List<PersonModel>> _getPersonsFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
