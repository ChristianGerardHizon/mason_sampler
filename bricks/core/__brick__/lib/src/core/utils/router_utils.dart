import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouterUtils {
  ///
  /// ignored routes
  ///
  static const ignoredRoutes = <String>[
    // SplashPageRoute.path,
  ];

  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref<Object?> ref,
  ) {
    // If the current path is in ignored routes, do not redirect
    final isIgnored = ignoredRoutes.any(
      (route) => state.fullPath?.contains(route) ?? false,
    );
    if (isIgnored) return null;

    // All checks passed, continue with normal routing
    return null;
  }

  static Widget errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text(state.error.toString())));
  }
}
