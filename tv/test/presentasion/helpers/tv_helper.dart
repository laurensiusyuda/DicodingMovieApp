import 'package:mockito/annotations.dart';

import 'package:tv/domain/usecases/usecases_tv/get_tv_detail.dart';
import 'package:tv/domain/usecases/usecases_tv/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/usecases_tv/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/usecases_tv/remove_watchlist.dart';
import 'package:tv/domain/usecases/usecases_tv/save_watchlist.dart';

@GenerateMocks([
  GetTvDetail,
  GetWatchlistTv,
  GetTvRecommendations,
  GetWatchListStatusTv,
  RemoveWatchlistTv,
  SaveWatchlistTv,
])
void main() {}
