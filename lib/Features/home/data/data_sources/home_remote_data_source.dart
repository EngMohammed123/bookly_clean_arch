import 'package:book_clean_arch/Features/home/data/models/book_model/book_model.dart';
import 'package:book_clean_arch/Features/home/domain/entities/book_entity.dart';
import 'package:book_clean_arch/core/utils/api_service.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}


class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{

  final ApiService apiService;
  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async{
    var data = await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&q=Programming');
    
    List<BookEntity> books = getBooksList(data);
    return books;
  }


  @override
  Future<List<BookEntity>> fetchNewestBooks() async{
    var data = await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest&q=Programming');
    
    List<BookEntity> books = getBooksList(data);
    return books;
  }


  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']){
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}