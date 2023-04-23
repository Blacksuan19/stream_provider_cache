import 'package:flutter/material.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';
import 'package:stream_provider_cache/src/widgets/widgets.dart';

class GridItemPage extends StatelessWidget {
  final GridItemModel item;

  const GridItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "${item.code}"),
      body: Center(
        child: Text(
          item.code.toString(),
          style: TextStyles.title.copyWith(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
