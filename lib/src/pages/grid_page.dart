import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';
import 'package:stream_provider_cache/src/widgets/widgets.dart';

class GridPage extends ConsumerWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => ItemsGrid(
        itemsStream: ref.watch(
          gridItemsProviderFamily(
            GridItemsProviderArgs(
              prefsKey: SharedPrefKey.providerCache,
              refreshKey: SharedPrefKey.shouldRefreshProviderCache,
              filterProvider: StringProvider.filterProvider,
            ),
          ),
        ),
        filterProvider: StringProvider.filterProvider.name,
      );
}
