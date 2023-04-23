import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/models/models.dart';
import 'package:stream_provider_cache/src/pages/pages.dart';
import 'package:stream_provider_cache/src/services/services.dart';
import 'package:stream_provider_cache/src/utils/constants.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';
import 'package:stream_provider_cache/src/widgets/widgets.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshEnabled = getProviderState<bool>(
      ref: ref,
      provider: BoolProvider.shouldRefreshProviderCache.name,
      watch: true,
    );

    return Scaffold(
      appBar: const CustomAppBar(text: "Stream Provider Cache"),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Cached Stream Provider Test",
            style: TextStyles.title,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: refreshEnabled,
                onChanged: (newValue) {
                  // update provider to update UI
                  setProviderState<bool>(
                    ref: ref,
                    newState: newValue!,
                    provider: BoolProvider.shouldRefreshProviderCache.name,
                  );

                  // persist value to shared preferences
                  setSharedPref<bool>(
                    key: SharedPrefKey.shouldRefreshProviderCache.toSnakeCase,
                    value: newValue,
                  );
                },
              ),
              const Text(
                "Force Refresh Provider Cache",
                style: TextStyles.body,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(aboutString),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: AppTheme.accentColor),
                ),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const GridPage(),
              ),
            ),
            child: const Text("Load Items"),
          ),
        ],
      )),
    );
  }
}
