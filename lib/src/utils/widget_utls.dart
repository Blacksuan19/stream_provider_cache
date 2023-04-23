import 'package:flutter/cupertino.dart';

/// nativate to [route] using CupertinoPageRoute.
///
/// replace view if [shouldReplace] is true.
Future<void> navigateRoute({
  required BuildContext context,
  required Widget route,
}) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => route),
  );
}
