import 'dart:io';

import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_event.dart';
import 'package:movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_event.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/watchlist_tv_page.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPage createState() => _WatchlistPage();
}

class _WatchlistPage extends State<WatchlistPage> with RouteAware {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistMoviesBloc>().add(WatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(WatchlistMovies());
    context.read<WatchlistTvBloc>().add(WatchlistTv());
  }

  final List<Widget> _listWidget = [
    const WatchlistMoviesPage(),
    const WatchlistTvPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
          ? CupertinoIcons.play_rectangle
          : Icons.movie_creation_outlined),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.tv : Icons.tv),
      label: 'Tv',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kMikadoYellow,
        unselectedItemColor: kDavysGrey,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
          activeColor: kMikadoYellow,
          inactiveColor: kDavysGrey),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
