import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class MatchUPApp extends StatelessWidget {
  const MatchUPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MatchUP',
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
