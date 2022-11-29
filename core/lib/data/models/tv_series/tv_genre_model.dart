import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';

class TvGenreModel extends Equatable {
  const TvGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TvGenreModel.fromJson(Map<String, dynamic> json) => TvGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TvGenreEntity toEntity() {
    return TvGenreEntity(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
