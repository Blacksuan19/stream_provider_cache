import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

class SearchAppBar extends ConsumerWidget with PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.searchValueProvider,
    required this.suggestions,
  });

  final String searchValueProvider;
  final List<String> suggestions;
  final double barHeight = 60;

  @override
  Widget build(BuildContext context, WidgetRef ref) => EasySearchBar(
        title: const Center(child: Text("Select item")),
        searchTextKeyboardType: TextInputType.number,
        elevation: 0,
        appBarHeight: barHeight,
        searchHintText: "Search in items",
        foregroundColor: Colors.white,
        searchCursorColor: Colors.white,
        searchBackgroundColor: AppTheme.accentColor,
        searchHintStyle: const TextStyle(color: Colors.white),
        searchTextStyle: const TextStyle(color: Colors.white),
        searchBackIconTheme: const IconThemeData(color: Colors.white),
        suggestionTextStyle: const TextStyle(height: 2),
        suggestions: suggestions,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.accentColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppTheme.accentColor,
          systemNavigationBarDividerColor: AppTheme.accentColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        onSearch: (value) => setProviderState<String>(
          ref: ref,
          provider: searchValueProvider,
          newState: value,
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
