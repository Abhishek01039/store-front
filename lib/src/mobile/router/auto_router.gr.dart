// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/auth_screen.dart' as _i4;
import '../screens/splash_screen.dart' as _i3;
import '../screens/store/store_detail_screen.dart' as _i6;
import '../screens/store/store_screen.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MySplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MySpalsh();
        }),
    AuthRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.AuthScreen();
        }),
    StoreRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    StoreScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.StoreScreen();
        }),
    StoreDetailScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<StoreDetailScreenArgs>(
              orElse: () => StoreDetailScreenArgs(
                  storeName: pathParams.optString('storeName')));
          return _i6.StoreDetailScreen(storeName: args.storeName);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MySplashRoute.name, path: '/'),
        _i1.RouteConfig(AuthRoute.name, path: '/auth'),
        _i1.RouteConfig(StoreRoute.name, path: '/stores', children: [
          _i1.RouteConfig(StoreScreen.name, path: ''),
          _i1.RouteConfig(StoreDetailScreen.name, path: ':storeName'),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '', fullMatch: true)
        ])
      ];
}

class MySplashRoute extends _i1.PageRouteInfo {
  const MySplashRoute() : super(name, path: '/');

  static const String name = 'MySplashRoute';
}

class AuthRoute extends _i1.PageRouteInfo {
  const AuthRoute() : super(name, path: '/auth');

  static const String name = 'AuthRoute';
}

class StoreRoute extends _i1.PageRouteInfo {
  const StoreRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/stores', initialChildren: children);

  static const String name = 'StoreRoute';
}

class StoreScreen extends _i1.PageRouteInfo {
  const StoreScreen() : super(name, path: '');

  static const String name = 'StoreScreen';
}

class StoreDetailScreen extends _i1.PageRouteInfo<StoreDetailScreenArgs> {
  StoreDetailScreen({String? storeName})
      : super(name,
            path: ':storeName',
            args: StoreDetailScreenArgs(storeName: storeName),
            rawPathParams: {'storeName': storeName});

  static const String name = 'StoreDetailScreen';
}

class StoreDetailScreenArgs {
  const StoreDetailScreenArgs({this.storeName});

  final String? storeName;
}
