import 'package:core/data/models/tv_series/tv_detail_model.dart';
import 'package:core/data/models/tv_series/tv_genre_model.dart';
import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_table.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

const tTvModel = TvModel(
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

const testTvDetail = TvDetailResponse(
  backdropPath: '',
  firstAirDate: '',
  genres: [TvGenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "https://google.com",
  numberOfEpisodes: 34,
  name: 'name',
  numberOfSeasons: 2,
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  status: 'status',
  tagline: 'tagline',
  type: 'Scripted',
  voteAverage: 3,
  voteCount: 3,
);
final testTVShowDetail = testTvDetail.toEntity();
final testTVShowTable = TvTable.fromEntity(testTVShowDetail);
final testTVShowTableList = <TvTable>[testTVShowTable];
final testWatchlistTVShow = [testTVShowTable.toEntity()];
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
