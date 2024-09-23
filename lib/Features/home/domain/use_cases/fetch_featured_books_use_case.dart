import 'package:book_clean_arch/Features/home/domain/entities/book_entity.dart';
import 'package:book_clean_arch/Features/home/domain/repos/home_repo.dart';
import 'package:book_clean_arch/core/errors/failure.dart';
import 'package:book_clean_arch/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity> , NoParam> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);
  
  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParam? param]) async{
    return await homeRepo.fetchFeaturedBooks();
  }
  
}


