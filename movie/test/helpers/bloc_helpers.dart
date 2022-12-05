import 'package:mockito/annotations.dart';
import 'package:movie/domain/usecases/usecases_movie/get_movie_detail.dart';
import 'package:movie/domain/usecases/usecases_movie/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/usecases_movie/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/usecases_movie/get_watchlist_status.dart';
import 'package:movie/domain/usecases/usecases_movie/remove_watchlist.dart';
import 'package:movie/domain/usecases/usecases_movie/save_watchlist.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatusMovie,
  GetWatchlistMovies,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {}
