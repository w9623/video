import 'package:fluro/fluro.dart';
import 'package:video/page/home.dart';

class Routes {
  static String home = "/";

  static void configureRoutes(FluroRouter router) {
    router.define(home, handler: Handler(handlerFunc: (context, params) {
      return const HomePage();
    }));
  }
}