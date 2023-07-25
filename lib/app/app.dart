import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:repo_browser/app/common/theming/themes.dart';
import 'package:repo_browser/app/router/router.dart';
import 'package:repo_browser/generated/locale_keys.g.dart';

final AppRouter rootRouter = AppRouter();

class RepoBrowserApp extends StatelessWidget {
  const RepoBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: rootRouter.delegate(),
      routeInformationParser: rootRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateTitle: (context) => LocaleKeys.common_appName.tr(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
