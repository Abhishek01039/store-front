import 'package:auto_route/auto_route.dart';
import 'package:storefront/src/mobile/screens/auth_screen.dart';
import 'package:storefront/src/mobile/screens/splash_screen.dart';
import 'package:storefront/src/mobile/screens/store/store_detail_screen.dart';
import 'package:storefront/src/mobile/screens/store/store_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', name: 'mySplashRoute', page: MySpalsh, initial: true),
    AutoRoute(path: '/auth', name: 'authRoute', page: AuthScreen),
    AutoRoute(
      path: '/stores',
      name: 'storeRoute',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: StoreScreen),
        AutoRoute(path: ':storeName', page: StoreDetailScreen),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
)
class $AppRouter {}
