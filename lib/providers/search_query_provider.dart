import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_query_provider.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  Timer? _timer;

  @override
  String build() {
    return '';
  }

  void onChange(String query) {
    _debounce(() {
      state = query;
    });
  }

  void _debounce(Function() action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 300), action);
  }
}
