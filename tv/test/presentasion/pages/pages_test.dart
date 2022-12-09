import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_event.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';
import 'package:tv/presentation/bloc/tv/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_popular/tv_popular_event.dart';
import 'package:tv/presentation/bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_recomendation/tv_recomendation_event.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated/tv_top_rated_event.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_event.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:tv/presentation/widget/Tv_card_list.dart';

import '../../dummy_data/dummy_objects_tv.dart';

class FakePopularTvEvent extends Fake implements PopularEvent {}

class FakePopularTvState extends Fake implements PopularEvent {}

class FakePopularTvBloc extends MockBloc<PopularEvent, StateRequest>
    implements PopularTvBloc {}

// top rated
class FakeTopRatedTvEvent extends Fake implements TopRatedEvent {}

class FakeTopRatedTvState extends Fake implements TopRatedEvent {}

class FakeTopRatedTvBloc extends MockBloc<TopRatedEvent, StateRequest>
    implements TopRatedTvBloc {}

//Detail
class FakeDetailTvEvent extends Fake implements TvDetailEvent {}

class FakeDetailTvState extends Fake implements TvDetailEvent {}

class FakeDetailTvBloc extends MockBloc<TvDetailEvent, StateRequest>
    implements TvDetailBloc {}

//Watchlist
class FakeWatchlistTvEvent extends Fake implements WatchlistEvent {}

class FakeWatchlistTvState extends Fake implements WatchlistEvent {}

class FakeWatchlistTvBloc extends MockBloc<WatchlistEvent, StateRequest>
    implements WatchlistTvBloc {}

//Recommendation
class FakeRecommendationTvEvent extends Fake implements TvRecommendationEvent {}

class FakeRecommendationTvState extends Fake implements TvRecommendationEvent {}

class FakeRecommendationTvBloc
    extends MockBloc<TvRecommendationEvent, StateRequest>
    implements TvRecommendationBloc {}

// now playing
class FakeNowPlayingEvent extends Fake implements NowPlayingEvent {}

class FakeNowPlayingState extends Fake implements NowPlayingEvent {}

class FakeNowPlayingBloc extends MockBloc<NowPlayingEvent, StateRequest>
    implements NowPlayingTvBloc {}

void main() {
  late FakePopularTvBloc fakePopularTvBloc;
  late FakeNowPlayingBloc fakeNowPlayingTvBloc;
  late FakeTopRatedTvBloc topRatedTvBloc;
  late FakeDetailTvBloc fakeDetailTvBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;
  late FakeRecommendationTvBloc fakeRecommendationTvBloc;

  setUpAll(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
    topRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
    fakeDetailTvBloc = FakeDetailTvBloc();
    registerFallbackValue(FakeDetailTvEvent());
    registerFallbackValue(FakeDetailTvState());
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
    fakeRecommendationTvBloc = FakeRecommendationTvBloc();
    registerFallbackValue(FakeRecommendationTvEvent());
    registerFallbackValue(FakeRecommendationTvState());
    fakeNowPlayingTvBloc = FakeNowPlayingBloc();
    registerFallbackValue(FakeRecommendationTvEvent());
    registerFallbackValue(FakeRecommendationTvState());
  });

  Widget _makeTestableWidgetNowPlaying(Widget body) {
    return BlocProvider<NowPlayingTvBloc>(
      create: (_) => fakeNowPlayingTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  Widget _makeTestableWidgetTopRated(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => topRatedTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget _makeTestableWidgetDetail(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TvDetailBloc>(
            create: (_) => fakeDetailTvBloc,
          ),
          BlocProvider<WatchlistTvBloc>(
            create: (_) => fakeWatchlistTvBloc,
          ),
          BlocProvider<TvRecommendationBloc>(
            create: (_) => fakeRecommendationTvBloc,
          ),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state).thenReturn(HasData(testTvList));

    await tester.pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => fakeNowPlayingTvBloc.state)
        .thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidgetNowPlaying(NowPlayingTvPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(HasData(testTvList));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => fakePopularTvBloc.state).thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedTvBloc.state).thenReturn(Loading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidgetTopRated(TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedTvBloc.state).thenReturn(HasData(testTvList));

    await tester.pumpWidget(_makeTestableWidgetTopRated(TopRatedTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';
    when(() => topRatedTvBloc.state).thenReturn(const Error(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidgetTopRated(TopRatedTvPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTvBloc.state).thenReturn(HasData(testTVShowDetail));

    when(() => fakeWatchlistTvBloc.state).thenReturn(const HasStatus(false));

    when(() => fakeRecommendationTvBloc.state).thenReturn(HasData(testTvList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidgetDetail(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailTvBloc.state).thenReturn(HasData(testTVShowDetail));
    when(() => fakeWatchlistTvBloc.state).thenReturn(const HasStatus(true));
    when(() => fakeRecommendationTvBloc.state).thenReturn(HasData(testTvList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidgetDetail(TvDetailPage(id: 1)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });

  // ysyuh

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeDetailTvBloc.state).thenReturn(Loading());
    when(() => fakeWatchlistTvBloc.state).thenReturn(Loading());
    when(() => fakeRecommendationTvBloc.state).thenReturn(Loading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidgetDetail(const TvDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });
}
