import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widget/Tv_card_list.dart';
import '../../bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import '../../bloc/tv/tv_now_playing/tv_now_playing_event.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-tv';

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingTvBloc>().add(NowPlayingTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, StateRequest>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasData) {
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
