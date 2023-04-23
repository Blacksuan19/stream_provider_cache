import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';
import 'package:stream_provider_cache/src/widgets/widgets.dart';

class ItemsGrid extends ConsumerWidget {
  final AsyncValue<List<GridItemModel>> itemsStream;
  final String filterProvider;
  final double maxCrossAxisExtent;

  const ItemsGrid({
    required this.itemsStream,
    required this.filterProvider,
    this.maxCrossAxisExtent = 200,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // we nead to watch the filter provider to update the list when the filter changes
    // ignore: unused_local_variable
    final wordFilter = getProviderState<String>(
      ref: ref,
      provider: filterProvider,
      watch: true,
    );

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: SearchAppBar(
        searchValueProvider: filterProvider,
        suggestions: itemsStream.when(
          data: (items) => items.map((item) => item.code.toString()).toList(),
          loading: () => const [],
          error: (error, stack) => const [],
        ),
      ),
      body: itemsStream.when(
        data: (items) => GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => GridItem(
            itemText: items[index].code.toString(),
            onTap: () async => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => GridItemPage(item: items[index]),
              ),
            ),
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                "Loading items...",
                style: TextStyles.title.copyWith(color: Colors.black54),
              )
            ],
          ),
        ),
        error: (error, stack) {
          dev.log(
            "Error loading items",
            name: "ItemsGrid",
            error: error,
            stackTrace: stack,
          );
          return const Center(child: Text("Error Loading items"));
        },
      ),
    );
  }
}
