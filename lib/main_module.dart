import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_api/core/providers/url_provider.dart';
import 'package:nasa_api/features/last_week_pictures/data/data_source/apod_data_source.dart';
import 'package:nasa_api/features/last_week_pictures/data/repository/apod_repository_impl.dart';
import 'package:nasa_api/features/last_week_pictures/domain/repository/apod_repository.dart';
import 'package:nasa_api/features/last_week_pictures/domain/use_case/get_last_week_pictures_use_case.dart';
import 'package:nasa_api/features/last_week_pictures/presentation/bloc/apod_bloc.dart';
import 'package:nasa_api/features/last_week_pictures/presentation/page/last_week_pics_page_handler.dart';
import 'package:http/http.dart' as http;

import 'core/constants/hosts.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    //!BLOCS
    i.addSingleton<ApodBloc>(() =>
        ApodBloc(getLastWeekPicturesUseCase: i<GetLastWeekPicturesUseCase>()));
    // //!USE CASES
    i.addLazySingleton(
        () => GetLastWeekPicturesUseCase(apodRepository: i<ApodRepository>()));
    // //!REPOSITORIES
    i.addLazySingleton<ApodRepository>(
        () => ApodRepositoryImpl(apodDataSource: i()));
    // //!DATA SOURCES
    i.addLazySingleton<ApodDataSource>(() => ApodDataSourceImpl(
          httpClient: i(),
          urlProvider: i<UrlProvider>(),
        ));
    //!CORE
    i.addInstance<UrlProvider>(UrlProvider(baseUrl: serverUrl));
    i.addInstance<http.Client>(http.Client());
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute,
        child: (context) => BlocProvider<ApodBloc>.value(
              value: Modular.get<ApodBloc>(),
              child: const LastWeekPicsPageHandler(),
            ));
  }
}