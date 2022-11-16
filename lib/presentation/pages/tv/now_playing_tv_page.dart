import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/presentation/widgets/tv_card_list.dart';

import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_state.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-tv';

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirTvBloc>().add(FetchOnTheAirTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
          builder: (context, state) {
            if (state is OnTheAirTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
