import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mason_sampler/src/core/routing/main.routes.dart';
import 'package:mason_sampler/src/features/auths/presentation/controllers/auth_controller.dart';

class AuthRouterUtils {
  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref<Object?> ref,
  ) {
    final controller = ref.read(authControllerProvider);

    final user = controller.valueOrNull;

    if (user == null) {
      return AuthLoginPageRoute.path;
    }

    return null;
  }
}
