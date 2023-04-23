import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

/// update a given [provider] state with [newState]
/// [watch] is used to determine if the provider should be read or watched
void setProviderState<StateType>({
  required WidgetRef ref,
  required String provider,
  required StateType newState,
  bool watch = false,
}) {
  final providerFamily = getProviderFamily(type: StateType);
  final refMethod = watch ? ref.watch : ref.read;
  refMethod(providerFamily(provider).notifier).setState(newState);
}

/// get a given [provider] state of type [StateType]
/// [watch] is used to determine if the provider should be read or watched
StateType getProviderState<StateType>({
  required ref,
  required String provider,
  bool watch = false,
}) {
  final providerFamily = getProviderFamily(type: StateType);
  final refMethod = watch ? ref.watch : ref.read;
  return refMethod(providerFamily(provider));
}

/// get a provider family based on [type]
getProviderFamily({required Type type}) {
  switch (type) {
    case String:
      return genericStringNotifierProvider;
    case bool:
      return genericBoolNotifierProvider;
    default:
      throw Exception('invalid type');
  }
}

/// filter a list of [items] based on [filterProvider] value.
List<GridItemModel> filterItems({
  required ref,
  required StringProvider filterProvider,
  required List<GridItemModel> items,
}) {
  final String searchString = getProviderState<String>(
    ref: ref,
    provider: filterProvider.name,
    watch: true,
  );

  if (searchString.isEmpty) return items;
  return items
      .where((element) => element.code.toString().contains(searchString))
      .toList();
}
