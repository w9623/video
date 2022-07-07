import 'package:fluro/fluro.dart';
import 'package:video/page/home.dart';
import 'package:video/page/search/search.dart';

class Routes {
  static String home = "/";
  static String search = "/search/search";

  static void configureRoutes(FluroRouter router) {
    router.define(home, handler: Handler(handlerFunc: (context, params) {
      return const HomePage();
    }));
    router.define(search, handler: Handler(handlerFunc: (context, params) {
      return const SearchPage();
    }));
  }
}