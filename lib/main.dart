import 'package:flutter/material.dart';
import 'package:flutter_animations_example/core/di/injectable_configuration.dart';
import 'package:flutter_animations_example/movies_portal_app.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  InAppWebViewPlatform.instance;

  runApp(const MoviesPortalApp());
}
