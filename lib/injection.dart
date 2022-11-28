import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
// datasource
import 'package:ditonton/data/datasources/local_data_source.dart';
import 'package:ditonton/data/datasources/remote_data_source.dart';
// repo
import 'package:ditonton/data/repositories/repository_impl.dart';
// domain
import 'package:ditonton/domain/repositories/repository.dart';
// usecase movie
import 'package:ditonton/domain/usecases/usecases_movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/usecases_movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_movie/search_movies.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_now_playing_tv.dart';
// usecase tv
import 'package:ditonton/domain/usecases/usecases_tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/usecases_tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_tv/save_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_tv/search_tv.dart';
// bloc movie
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
// bloc tv
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';

import 'package:get_it/get_it.dart';

import 'presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc movie
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  // bloc tv
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // use case movie dan use case tv
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => DataConnectionChecker());

  // repository movie dan respository tv
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources movie dan data sources tv
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  // database helper movie dan helper tv
  locator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );
  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
