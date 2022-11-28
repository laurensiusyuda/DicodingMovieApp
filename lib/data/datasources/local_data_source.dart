import 'package:core/core.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_models/movie_table.dart';
import 'package:ditonton/data/models/tv_series/tv_table.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<void> cachePopularMovies(List<MovieTable> movies);
  Future<void> cacheTopRatedMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<List<MovieTable>> getCachedPopularMovies();
  Future<List<MovieTable>> getCachedTopRatedMovies();

  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<String> insertMovieWatchlist(MovieTable movie);
  Future<String> removeMovieWatchlist(MovieTable movie);

  Future<void> cacheNowPlayingTv(List<TvTable> tv);
  Future<void> cachePopularTv(List<TvTable> tv);
  Future<void> cacheTopRatedTv(List<TvTable> tv);
  Future<List<TvTable>> getCachedNowPlayingTv();
  Future<List<TvTable>> getCachedPopularTv();
  Future<List<TvTable>> getCachedTopRatedTv();

  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
  Future<String> insertTvWatchlist(TvTable tv);
  Future<String> removeTvWatchlist(TvTable tv);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMoviesCache('now playing');
    await databaseHelper.insertCacheTransactionMovies(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMoviesCache('popular');
    await databaseHelper.insertCacheTransactionMovies(movies, 'popular');
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    final result = await databaseHelper.getCacheMovies('popular');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMoviesCache('top rated');
    await databaseHelper.insertCacheTransactionMovies(movies, 'top rated');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    final result = await databaseHelper.getCacheMovies('top rated');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheNowPlayingTv(List<TvTable> tv) async {
    await databaseHelper.clearCacheTv('now playing');
    await databaseHelper.insertCacheTransactionTv(tv, 'now playing');
  }

  @override
  Future<void> cachePopularTv(List<TvTable> tv) async {
    await databaseHelper.clearCacheTv('popular');
    await databaseHelper.insertCacheTransactionTv(tv, 'popular');
  }

  @override
  Future<void> cacheTopRatedTv(List<TvTable> tv) async {
    await databaseHelper.clearCacheTv('top rated');
    await databaseHelper.insertCacheTransactionTv(tv, 'top rated');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingTv() async {
    final result = await databaseHelper.getCacheTv('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TvTable>> getCachedPopularTv() async {
    final result = await databaseHelper.getCacheTv('popular');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TvTable>> getCachedTopRatedTv() async {
    final result = await databaseHelper.getCacheTv('top rated');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
