import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

/// get [key] from shared preferences
///
/// returns null if key is not present
///
/// ```dart
/// final String? name = await getSharedPref<String>(key: 'name');
/// final bool? isDarkMode = await getSharedPref<bool>(key: 'isDarkMode');
/// ```
Future<ValueType?>? getSharedPref<ValueType>({
  required String key,
  ValueType? defaultValue,
}) async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(key)) return defaultValue;
  return prefs.get(key) as ValueType;
}

/// set [key] to [value] in shared preferences, overwriting any existing value
///
/// ```dart
/// await setSharedPref<String>(key: 'name', value: 'John');
/// await setSharedPref<bool>(key: 'isDarkMode', value: true);
/// ```
Future<void> setSharedPref<ValueType>({
  required String key,
  required ValueType value,
}) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(key)) await prefs.remove(key);

  switch (ValueType) {
    case String:
      await prefs.setString(key, value as String);
      break;
    case bool:
      await prefs.setBool(key, value as bool);
      break;
  }
}

/// save list of [items] json encoded to shared preferences
///
/// [key] is the key to save the list to
///
/// ```dart
/// await cacheItems(
///  key: SharedPrefKey.alphabetProvider,
/// items: alphabetProvider,
/// );
/// ```
Future<void> cacheItems({
  required SharedPrefKey key,
  required List<Jsonable> items,
}) async =>
    setSharedPref<String>(
      key: key.toSnakeCase,
      value: jsonEncode(items.map((item) => item.toJson()).toList()),
    );

/// get list of [items] from shared preferences
///
/// returns null if key is not present or if [shouldRefresh] is true
///
/// [shouldRefresh] is true if [refreshKey] is true in firebase remote config
///
/// ```dart
/// final alphabetProvider = await getCachedItems(
///  prefsKey: SharedPrefKey.alphabetProvider,
/// refreshKey: FirebaseConfigKey.alphabetProvider,
/// fromJson: Letter.fromJson,
/// );
/// ```
Future<List<GridItemModel>?>? getCachedItems({
  required SharedPrefKey prefsKey,
  required SharedPrefKey refreshKey,
}) async {
  final shouldRefresh = await getSharedPref<bool>(
    key: refreshKey.toSnakeCase,
    defaultValue: false,
  );
  final cachedItems = await getSharedPref<String>(key: prefsKey.toSnakeCase);

  if (shouldRefresh! || cachedItems == null) return null;

  final List itemsList = jsonDecode(cachedItems);

  return <GridItemModel>[
    for (final item in itemsList) GridItemModel.fromJson(item)
  ];
}
