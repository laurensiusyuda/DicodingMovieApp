import 'package:core/data/models/tv_series/tv_model.dart';

class TvResponse {
  final List<TvModel> tvShowList;
  const TvResponse({required this.tvShowList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvShowList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvShowList.map((x) => x.toJson())),
      };
  List<Object?> get props => [tvShowList];
}
