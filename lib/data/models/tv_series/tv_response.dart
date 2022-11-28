import 'package:ditonton/data/models/tv_series/tv_model.dart';

class TvResponse {
  TvResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<TvModel> results;
  int totalPages;
  int totalResults;

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        page: json["page"],
        results:
            List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
