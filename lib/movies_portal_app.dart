import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/routing/app_router.dart';

class MoviesPortalApp extends StatelessWidget {
  const MoviesPortalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
