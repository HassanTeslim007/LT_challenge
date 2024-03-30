
import 'package:dartz/dartz.dart';
import 'package:lt_challenge/core/failure/exceptions.dart';
import 'package:lt_challenge/core/failure/failure.dart';
import 'package:lt_challenge/features/search/data/datasource/remote_datasource.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, SearchResult>> search(
      {required String query, String? nextPageToken}) async {
    try {
      final res =
          await dataSource.search(query: query, nextPageToken: nextPageToken);
    
      return Right(res);
    } on CustomException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
