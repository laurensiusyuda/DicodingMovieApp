import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  final Map<String, dynamic> tvShowTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should return json Tv Show table correctly', () {
    final result = testTvTable.toJson();
    expect(result, tvShowTableJson);
  });
}
