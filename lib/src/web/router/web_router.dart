import 'package:auto_route/auto_route.dart';
import 'package:storefront/src/mobile/screens/splash_screen.dart';
import 'package:storefront/src/web/screens/auth_screen_web.dart';
import 'package:storefront/src/web/screens/store/store_detail_screen_web.dart';
import 'package:storefront/src/web/screens/store/store_screen_web.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', name: 'mySplashRoute', page: MySpalsh, initial: true),
    AutoRoute(path: '/auth', name: 'authRouteWeb', page: AuthScreenWeb),
    AutoRoute(
      path: '/stores',
      name: 'storeRouteWeb',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: StoreScreenWeb),
        AutoRoute(path: ':storeName', page: StoreDetailScreenWeb),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
)
class $WebRouter {}
