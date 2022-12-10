import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie/now_movie_playing/now_movie_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie/now_movie_playing/now_movie_playing_event.dart';
import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/popular_movie/popular_movie_event.dart';
import 'package:movie/presentation/bloc/movie/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/recomendation_movie/recomendation_movie_event.dart';
import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/top_rated_movie/top_rated_movie_event.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_event.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie/now_playing_movie.dart';
import 'package:movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:movie/presentation/widget/Movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingEvent {}

class FakeNowPlayingState extends Fake implements NowPlayingEvent {}

class FakeNowPlayingBloc extends MockBloc<NowPlayingEvent, StateRequest>
    implements NowPlayingMoviesBloc {}

//Detail
class FakeDetailMoviesEvent extends Fake implements MovieDetailEvent {}

class FakeDetailMoviesState extends Fake implements MovieDetailEvent {}

class FakeDetailMoviesBloc extends MockBloc<MovieDetailEvent, StateRequest>
    implements MovieDetailBloc {}

//Watchlist
class FakeWatchlistMoviesEvent extends Fake implements WatchlistEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistEvent {}

class FakeWatchlistMoviesBloc extends MockBloc<WatchlistEvent, StateRequest>
    implements WatchlistMoviesBloc {}

//Recommendation
class FakeRecommendationMoviesEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeRecommendationMoviesState extends Fake
    implements MovieRecommendationEvent {}

class FakeRecommendationMoviesBloc
    extends MockBloc<MovieRecommendationEvent, StateRequest>
    implements MovieRecommendationBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedEvent {}

class FakeTopRatedMoviesBloc extends MockBloc<TopRatedEvent, StateRequest>
    implements TopRatedMoviesBloc {}

class FakePopularMoviesEvent extends Fake implements PopularEvent {}

class FakePopularMoviesState extends Fake implements PopularEvent {}

class FakePopularMoviesBloc extends MockBloc<PopularEvent, StateRequest>
    implements PopularMoviesBloc {}

void main() {
  late FakeTopRatedMoviesBloc topRatedMoviesBloc;
  late FakePopularMoviesBloc fakePopularMoviesBloc;
  late FakeNowPlayingBloc fakeNowPlayingBloc;
  late FakeDetailMoviesBloc fakeDetailMoviesBloc;
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;
  late FakeRecommendationMoviesBloc fakeRecommendationMoviesBloc;

  setUpAll(() {
    fakeNowPlayingBloc = FakeNowPlayingBloc();
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingState());

    topRatedMoviesBloc = FakeTopRatedMoviesBloc();
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());

    fakePopularMoviesBloc = FakePopularMoviesBloc();
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());

    fakeDetailMoviesBloc = FakeDetailMoviesBloc();
    registerFallbackValue(FakeDetailMoviesEvent());
    registerFallbackValue(FakeDetailMoviesState());

    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());

    fakeRecommendationMoviesBloc = FakeRecommendationMoviesBloc();
    registerFallbackValue(FakeRecommendationMoviesEvent());
    registerFallbackValue(FakeRecommendationMoviesState());
  });
  Widget _makeTestableWidgetNowPlaying(Widget body) {
    return BlocProvider<NowPlayingMoviesBloc>(
      create: (_) => fakeNowPlayingBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (_) => topRatedMoviesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget _makeTestableWidgetPopular(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => fakePopularMoviesBloc,
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  Widget _makeTestableWidgetDetail(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
            create: (_) => fakeDetailMoviesBloc,
          ),
          BlocProvider<WatchlistMoviesBloc>(
            create: (_) => fakeWatchlistMoviesBloc,
          ),
          BlocProvider<MovieRecommendationBloc>(
            create: (_) => fakeRecommendationMoviesBloc,
          ),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBloc.state).thenReturn(Loading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBloc.state).thenReturn(HasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => topRatedMoviesBloc.state).thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidgetPopular(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(HasData(testMovieList));

    await tester
        .pumpWidget(_makeTestableWidgetPopular(const PopularMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester
        .pumpWidget(_makeTestableWidgetPopular(const PopularMoviesPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Movies not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMoviesBloc.state)
        .thenReturn(const HasData(testMovieDetail));

    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const HasStatus(false));

    when(() => fakeRecommendationMoviesBloc.state)
        .thenReturn(HasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidgetDetail(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Movies is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailMoviesBloc.state)
        .thenReturn(const HasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state).thenReturn(const HasStatus(true));
    when(() => fakeRecommendationMoviesBloc.state)
        .thenReturn(HasData(testMovieList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidgetDetail(const MovieDetailPage(id: 1)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMoviesBloc.state)
        .thenReturn(const HasData(testMovieDetail));

    when(() => fakeRecommendationMoviesBloc.state)
        .thenReturn(HasData(testMovieList));

    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const HasStatus(false));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const HasMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidgetDetail(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingMoviePage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingBloc.state).thenReturn(HasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => fakeNowPlayingBloc.state).thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester
        .pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingMoviePage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });
}
