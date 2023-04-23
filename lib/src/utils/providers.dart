import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/services/services.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

final gridItemsProviderFamily = StreamProvider.autoDispose
    .family<List<GridItemModel>, GridItemsProviderArgs>((ref, args) async* {
  // fetch data from cache if present
  List<GridItemModel>? cachedItems = await getCachedItems(
    prefsKey: args.prefsKey,
    refreshKey: args.refreshKey,
  );

  // resume the stream from the cached items
  var allItems = cachedItems ?? <GridItemModel>[];
  for (int i = allItems.length; i < allItems.length + 100; i++) {
    // small delay to simulate network latency
    await Future.delayed(const Duration(milliseconds: 500));

    // add new items to the stream
    allItems = [
      ...allItems,
      GridItemModel(index: i, code: UniqueKey().hashCode),
    ];

    // cache items to shared preferences
    await cacheItems(key: args.prefsKey, items: allItems);

    // filter items based on the filter provider
    allItems = filterItems(
      ref: ref,
      filterProvider: args.filterProvider,
      items: allItems,
    );

    yield allItems;
  }
});

/// generic string state provider, for tracking a state of type string
/// family means it can create many providers with different [name]
final genericStringNotifierProvider = StateNotifierProvider.family
    .autoDispose<GenericStateNotifier<String>, String, String>(
  (ref, name) => GenericStateNotifier(""),
);

/// generic string state provider, for tracking a state of type string
/// family means it can create many providers with different [name]
final genericBoolNotifierProvider = StateNotifierProvider.family
    .autoDispose<GenericStateNotifier<bool>, bool, String>(
  (ref, name) => GenericStateNotifier(false),
);
