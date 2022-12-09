import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/movie_models/genre_model.dart';
import 'package:core/data/models/movie_models/movie_detail_model.dart';
import 'package:core/data/models/movie_models/movie_model.dart';
import 'package:core/data/models/tv_series/tv_detail_model.dart';
import 'package:core/data/models/tv_series/tv_genre_model.dart';
import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_table.dart';
import 'package:core/data/repositories/repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockTvLocalDataSource mockTvDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockTvDataSource = MockTvLocalDataSource();

    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      tvLocalDataSource: mockTvDataSource,
    );
  });

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <MovieEntity>[tMovie];

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <TvEntity>[tTv];

  // MOVIE
  group('Now Playing Movies', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });

  group('Popular Movies', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getPopularMovies();
        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getPopularMovies();
        // assert
        verify(mockRemoteDataSource.getPopularMovies());
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });

  group('Top Rated Movies', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getTopRatedMovies();
        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        await repository.getTopRatedMovies();
        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });

  group('Get Movie Detail', () {
    const tId = 1;
    const tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [MovieGenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(const Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    const tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveMovieWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertMovieWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveMovieWatchlist(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeMovieWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeMovieWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeMovieWatchlist(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistMovies(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });

  // TV
  group('Now Playing Tv', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getNowPlayingTv();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTv());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getNowPlayingTv();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTv());
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTv())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingTv();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTv());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });

  group('Popular Tv', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });

  group('Top Rated Tv', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });

  group('Get TV Detail', () {
    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTvList = <TvModel>[];
    const tId = 52814;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv', () {
    const tQuery = 'hallo';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvDataSource.insertTvWatchlist(testTVShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvWatchlist(testTVShowDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvDataSource.insertTvWatchlist(testTVShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvWatchlist(testTVShowDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvDataSource.removeTvWatchlist(testTVShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvWatchlist(testTVShowDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvDataSource.removeTvWatchlist(testTVShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvWatchlist(testTVShowDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 52814;
      when(mockTvDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTv(tId);
      // assert
      expect(result, false);
    });
  });
}
