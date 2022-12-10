import 'package:core/data/models/tv_series/tv_detail_model.dart';
import 'package:core/data/models/tv_series/tv_genre_model.dart';
import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_table.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

const tTvModel = TvModel(
  backdropPath: '/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg',
  genreIds: [14, 12, 28],
  id: 338953,
  originalName: 'Fantastic Beasts: The Secrets of Dumbledore',
  overview:
      'Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald\'s growing legion of followers.',
  popularity: 3456.961,
  posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
  firstAirDate: '2022-04-06',
  name: 'Fantastic Beasts: The Secrets of Dumbledore',
  voteAverage: 6.9,
  voteCount: 1795,
);

final tTv = TvEntity(
  backdropPath: '/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg',
  genreIds: [14, 12, 28],
  id: 338953,
  originalName: 'Fantastic Beasts: The Secrets of Dumbledore',
  overview:
      'Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald\'s growing legion of followers.',
  popularity: 3456.961,
  posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
  firstAirDate: '2022-04-06',
  name: 'Fantastic Beasts: The Secrets of Dumbledore',
  voteAverage: 6.9,
  voteCount: 1795,
);

final testTv = TvEntity(
  backdropPath: '/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg',
  genreIds: [14, 12, 28],
  id: 338953,
  originalName: 'Fantastic Beasts: The Secrets of Dumbledore',
  overview:
      'Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald\'s growing legion of followers.',
  popularity: 3456.961,
  posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
  firstAirDate: '2022-04-06',
  name: 'Fantastic Beasts: The Secrets of Dumbledore',
  voteAverage: 6.9,
  voteCount: 1795,
);

const testTvDetail = TvDetailEntity(
  backdropPath: 'backdropPath',
  genres: [TvGenreEntity(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);
final testTvList = [testTv];

final testWatchlistTv = TvEntity.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
