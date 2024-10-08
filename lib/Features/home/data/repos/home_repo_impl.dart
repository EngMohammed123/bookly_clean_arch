import 'package:book_clean_arch/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_clean_arch/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_clean_arch/Features/home/domain/entities/book_entity.dart';
import 'package:book_clean_arch/Features/home/domain/repos/home_repo.dart';
import 'package:book_clean_arch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo{
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource, required this.homeLocalDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async{
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchFeaturedBooks();
      if(books.isNotEmpty){
        return right(books);
      }
      books = await homeRemoteDataSource.fetchFeaturedBooks();

  return right(books);
} catch (e) {
  if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
}
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async{
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchNewestBooks();
      if(books.isNotEmpty){
        return right(books);
      }
      books = await homeRemoteDataSource.fetchNewestBooks();

  return right(books);
} catch (e) {
  if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
}
  }
}