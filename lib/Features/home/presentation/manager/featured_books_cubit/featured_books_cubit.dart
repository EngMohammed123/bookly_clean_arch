import 'package:book_clean_arch/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:book_clean_arch/Features/home/presentation/manager/featured_books_cubit/featured_books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase) : super(FeaturedBooksInitial());

final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  Future<void> fetchFeaturedBooks() async{
    emit(FeaturedBooksLoading());
    var result = await fetchFeaturedBooksUseCase.call();

    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.message));
      },
       (books) {
        emit(FeaturedBooksSuccess(books));
       });

  }
}
