import 'package:core/core.dart';
import 'package:about/about_page.dart';

// Bloc movie
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';

// Bloc tv
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist/tv_watchlist_bloc.dart';

import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/searchtv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpsPinning.init();

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bloc Movie
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        // Bloc Tv
        BlocProvider(create: (_) => di.locator<DetailTvBloc>()),
        BlocProvider(create: (_) => di.locator<OnTheAirTvBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationTvBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => HomeMoviePage(),
              );
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => HomeTvPage(),
              );
            case NowPlayingTvPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => NowPlayingTvPage(),
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => PopularMoviesPage(),
              );
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => PopularTvPage(),
              );
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => TopRatedMoviesPage(),
              );
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => TopRatedTvPage(),
              );
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => SearchPage(),
              );
            case SearchPageTv.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => SearchPageTv(),
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => WatchlistMoviesPage(),
              );
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => WatchlistTvPage(),
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => AboutPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
