import 'package:stream_provider_cache/src/models/models.dart';

/// grid item data model
///
/// implements [Jsonable] to allow for serialization and deserialization
class GridItemModel extends Jsonable {
  final int index;
  final int code;

  GridItemModel({
    required this.index,
    required this.code,
  });

  factory GridItemModel.fromJson(Map<String, dynamic> json) => GridItemModel(
        index: json["index"],
        code: json["name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "index": index,
        "name": code,
      };
}

/// items provider arguments data model
///
/// this is requird to pass more than one argument to a provider
///
/// implementations of [operator ==] and [hashCode] are required by riverpod to
///
/// differentiate between different instances of the same provider,w
class GridItemsProviderArgs {
  final SharedPrefKey prefsKey;
  final SharedPrefKey refreshKey;
  final StringProvider filterProvider;

  GridItemsProviderArgs({
    required this.prefsKey,
    required this.refreshKey,
    required this.filterProvider,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GridItemsProviderArgs &&
        other.prefsKey == prefsKey &&
        other.refreshKey == refreshKey &&
        other.filterProvider == filterProvider;
  }

  @override
  int get hashCode =>
      prefsKey.hashCode ^ refreshKey.hashCode ^ filterProvider.hashCode;
}
