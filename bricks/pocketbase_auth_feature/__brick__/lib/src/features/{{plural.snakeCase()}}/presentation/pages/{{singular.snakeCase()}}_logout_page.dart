import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:{{packageName.snakeCase()}}/src/core/routing/router.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/auth_data.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthLogoutPage extends HookConsumerWidget {
  const AuthLogoutPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next.valueOrNull is {{singular.pascalCase()}}Data) {
        RootRoute().go(context);
      }

      if (next.hasError) {
        {{singular.snakeCase()}}LoginPageRoute().go(context);
      }
    });

    logout() async {
      await Future.delayed(const Duration(seconds: 1));
      await ref.read({{singular.pascalCase()}}ControllerProvider.notifier).logout().run();
    }

    useEffect(() {
      logout();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Logging out..')),
    );
  }
}
