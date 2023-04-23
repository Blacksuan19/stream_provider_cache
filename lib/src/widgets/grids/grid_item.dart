import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

class GridItem extends ConsumerWidget {
  final String itemText;
  final VoidCallback onTap;
  const GridItem({
    required this.itemText,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.accentColor.withOpacity(0.4),
          ),
          child: Center(
            child: Text(
              itemText,
              softWrap: true,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
}
