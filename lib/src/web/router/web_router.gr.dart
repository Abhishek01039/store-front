// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../mobile/screens/splash_screen.dart' as _i3;
import '../../models/store.dart' as _i7;
import '../screens/auth_screen_web.dart' as _i4;
import '../screens/store/store_detail_screen_web.dart' as _i6;
import '../screens/store/store_screen_web.dart' as _i5;

class WebRouter extends _i1.RootStackRouter {
  WebRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MySplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MySpalsh();
        }),
    AuthRouteWeb.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.AuthScreenWeb();
        }),
    StoreRouteWeb.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    StoreScreenWeb.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.StoreScreenWeb();
        }),
    StoreDetailScreenWeb.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<StoreDetailScreenWebArgs>();
          return _i6.StoreDetailScreenWeb(
              storeName: args.storeName, store: args.store);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MySplashRoute.name, path: '/'),
        _i1.RouteConfig(AuthRouteWeb.name, path: '/auth'),
        _i1.RouteConfig(StoreRouteWeb.name, path: '/stores', children: [
          _i1.RouteConfig(StoreScreenWeb.name, path: ''),
          _i1.RouteConfig(StoreDetailScreenWeb.name, path: ':storeName'),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '', fullMatch: true)
        ])
      ];
}

class MySplashRoute extends _i1.PageRouteInfo {
  const MySplashRoute() : super(name, path: '/');

  static const String name = 'MySplashRoute';
}

class AuthRouteWeb extends _i1.PageRouteInfo {
  const AuthRouteWeb() : super(name, path: '/auth');

  static const String name = 'AuthRouteWeb';
}

class StoreRouteWeb extends _i1.PageRouteInfo {
  const StoreRouteWeb({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/stores', initialChildren: children);

  static const String name = 'StoreRouteWeb';
}

class StoreScreenWeb extends _i1.PageRouteInfo {
  const StoreScreenWeb() : super(name, path: '');

  static const String name = 'StoreScreenWeb';
}

class StoreDetailScreenWeb extends _i1.PageRouteInfo<StoreDetailScreenWebArgs> {
  StoreDetailScreenWeb({String? storeName, required _i7.Store store})
      : super(name,
            path: ':storeName',
            args: StoreDetailScreenWebArgs(storeName: storeName, store: store),
            rawPathParams: {'storeName': storeName});

  static const String name = 'StoreDetailScreenWeb';
}

class StoreDetailScreenWebArgs {
  const StoreDetailScreenWebArgs({this.storeName, required this.store});

  final String? storeName;

  final _i7.Store store;
}
