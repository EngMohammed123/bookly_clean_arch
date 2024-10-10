import 'package:book_clean_arch/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:book_clean_arch/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:book_clean_arch/Features/home/data/repos/home_repo_impl.dart';
import 'package:book_clean_arch/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:book_clean_arch/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:book_clean_arch/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:book_clean_arch/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:book_clean_arch/constants.dart';
import 'package:book_clean_arch/core/index.dart';
import 'package:book_clean_arch/core/utils/app_router.dart';
import 'package:book_clean_arch/core/utils/setup_service_locator.dart';
import 'package:book_clean_arch/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  setupServiceLocator();

  Bloc.observer = SimpleBlocObserver();

  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(
          create: (context){
          return FeaturedBooksCubit(
            FetchFeaturedBooksUseCase(
            getIt.get<HomeRepoImpl>(),
            )
            );
         }),
         BlocProvider(
          create: (context){
          return NewestBooksCubit(
            FetchNewestBooksUseCase(
            getIt.get<HomeRepoImpl>(),
            )
            );
         }),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
