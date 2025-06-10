import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/main.routes.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/{{singular.snakeCase()}}_controller.dart';

class {{singular.pascalCase()}}RouterUtils {
  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref<Object?> ref,
  ) {
    final controller = ref.read(authControllerProvider);

    final user = controller.valueOrNull;

    if (user == null) {
      return {{singular.pascalCase()}}LoginPageRoute.path;
    }

    return null;
  }
}
