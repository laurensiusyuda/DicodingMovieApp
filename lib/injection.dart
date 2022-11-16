import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_tv.dart';
// datasource
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
// repo
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_respository_impl.dart';
// domain
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
// usecase movie
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
// usecase tv
import 'package:ditonton/domain/usecases_tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases_tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases_tv/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases_tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases_tv/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases_tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases_tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases_tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases_tv/save_watchlist.dart';
import 'package:ditonton/domain/usecases_tv/search_tv.dart';
// bloc movie
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
// bloc tv
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist/tv_watchlist_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc movie
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(
        getWatchlistMovies: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  // bloc tv
  locator.registerFactory(() => DetailTvBloc(locator()));
  locator.registerFactory(() => OnTheAirTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => RecommendationTvBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(
        getWatchlistTv: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

  // use case movie dan use case tv
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository movie dan respository tv
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
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
  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(
      databaseHelperTv: locator(),
    ),
  );

  // database helper movie dan helper tv
  locator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );
  locator.registerLazySingleton<DatabaseHelperTv>(
    () => DatabaseHelperTv(),
  );

  // external
  locator.registerLazySingleton(
    () => http.Client(),
  );
}
