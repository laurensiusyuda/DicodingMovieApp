import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_entities/genre.dart';

class MovieGenreModel extends Equatable {
  const MovieGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) =>
      MovieGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  MovieGenreEntity toEntity() {
    return MovieGenreEntity(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
