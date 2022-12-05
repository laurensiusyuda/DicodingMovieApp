import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_movies.dart';
import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MockDatabaseHelperTv mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    mockDatabaseHelperTv = MockDatabaseHelperTv();
  });

  final testMovieTableId = testMovieTable.id;
  final testTVShowTableId = testTvTable.id;

  group('Movie test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.insertMovieWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.removeMovieWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return Movie Detail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('TV Show test on db', () {
    test('should return tv show id when inserting new tv show', () async {
      // arrange
      when(mockDatabaseHelperTv.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => testTVShowTableId);
      // act
      final result = await mockDatabaseHelperTv.insertTvWatchlist(testTvTable);
      // assert
      expect(result, testTVShowTableId);
    });

    test('should return tv show id when deleting a tv show', () async {
      // arrange
      when(mockDatabaseHelperTv.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => testTVShowTableId);
      // act
      final result = await mockDatabaseHelperTv.removeTvWatchlist(testTvTable);
      // assert
      expect(result, testTVShowTableId);
    });

    test(
        'should return TV Show Detail Table when getting tv show by id is found',
        () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(testTVShowTableId))
          .thenAnswer((_) async => testTvTable.toJson());
      // act
      final result = await mockDatabaseHelperTv.getTvById(testTVShowTableId);
      // assert
      expect(result, testTvTable.toJson());
    });

    test('should return null when getting tv show by id is not found',
        () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(testTVShowTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelperTv.getTvById(testTVShowTableId);
      // assert
      expect(result, null);
    });

    test('should return list of tv show map when getting watchlist tv shows',
        () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await mockDatabaseHelperTv.getWatchlistTv();
      // assert
      expect(result, [testTvMap]);
    });
  });
}
