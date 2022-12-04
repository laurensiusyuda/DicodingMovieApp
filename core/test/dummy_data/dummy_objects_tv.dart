import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_table.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

final tTvModel = TvModel(
  genreIds: const [10759, 10765],
  id: 52814,
  name: 'Halo',
  originalName: 'Halo',
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  popularity: 10330.342,
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  voteAverage: 8.7,
  voteCount: 420,
);

final tTv = TvEntity(
  genreIds: const [10759, 10765],
  id: 52814,
  name: 'Halo',
  originalName: 'Halo',
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  popularity: 10330.342,
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  voteAverage: 8.7,
  voteCount: 420,
);

final testTv = TvEntity(
  genreIds: const [10759, 10765],
  id: 52814,
  name: 'Halo',
  originalName: 'Halo',
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  popularity: 10330.342,
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  voteAverage: 8.7,
  voteCount: 420,
);

final testTvList = [testTv];

final testTvDetail = TvDetailEntity(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [const TvGenreEntity(id: 1, name: 'Action')],
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
);

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

const testTvCache = TvTable(
  id: 52814,
  name: 'Halo',
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
);

final testTvCacheMap = {
  'id': 52814,
  'overview':
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  'posterPath': '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  'name': 'Halo',
};

final testTvFromCache = TvEntity.watchlist(
  id: 52814,
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  name: 'Halo',
);
