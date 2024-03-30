import 'package:dartz/dartz.dart';
import 'package:lt_challenge/core/failure/failure.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';

abstract interface class SearchRepository {
  Future<Either<Failure, SearchResult>> search({required String query, String? nextPageToken});
}
