import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_tv_helper.dart';
import 'package:core/data/datasources/local_data_source.dart';
import 'package:core/data/datasources/local_data_source_tv.dart';
import 'package:core/data/datasources/remote_data_source.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  NetworkInfo,
  DatabaseHelper,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
