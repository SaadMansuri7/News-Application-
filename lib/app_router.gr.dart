// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:newsapp/views/search/search_viewScreen.dart' as _i5;
import 'package:newsapp/views/details/details_viewScreen.dart' as _i1;
import 'package:newsapp/views/home/homo_viewScreen.dart' as _i2;
import 'package:newsapp/views/logIn/login_viewScreen.dart' as _i3;
import 'package:newsapp/views/profile/profile_viewScreen.dart' as _i4;
import 'package:newsapp/views/signup/signup_viewScreen.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    DetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsViewRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DetailsViewScreen(link: args.link),
      );
    },
    HomoViewRoute.name: (routeData) {
      final args = routeData.argsAs<HomoViewRouteArgs>(
          orElse: () => const HomoViewRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeViewScreen(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
      );
    },
    LoginViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginViewRouteArgs>(
          orElse: () => const LoginViewRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginViewScreen(key: args.key),
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ProfileViewScreen(),
      );
    },
    SearchResultRoute.name: (routeData) {
      final args = routeData.argsAs<SearchResultRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SearchResultScreen(
          key: args.key,
          value: args.value,
        ),
      );
    },
    SignupViewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SignupViewScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.DetailsViewScreen]
class DetailsViewRoute extends _i7.PageRouteInfo<DetailsViewRouteArgs> {
  DetailsViewRoute({
    required String? link,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DetailsViewRoute.name,
          args: DetailsViewRouteArgs(link: link),
          initialChildren: children,
        );

  static const String name = 'DetailsViewRoute';

  static const _i7.PageInfo<DetailsViewRouteArgs> page =
      _i7.PageInfo<DetailsViewRouteArgs>(name);
}

class DetailsViewRouteArgs {
  const DetailsViewRouteArgs({required this.link});

  final String? link;

  @override
  String toString() {
    return 'DetailsViewRouteArgs{link: $link}';
  }
}

/// generated route for
/// [_i2.HomoViewScreen]
class HomoViewRoute extends _i7.PageRouteInfo<HomoViewRouteArgs> {
  HomoViewRoute({
    _i8.Key? key,
    int initialIndex = 0,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomoViewRoute.name,
          args: HomoViewRouteArgs(
            key: key,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'HomoViewRoute';

  static const _i7.PageInfo<HomoViewRouteArgs> page =
      _i7.PageInfo<HomoViewRouteArgs>(name);
}

class HomoViewRouteArgs {
  const HomoViewRouteArgs({
    this.key,
    this.initialIndex = 0,
  });

  final _i8.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'HomoViewRouteArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i3.LoginViewScreen]
class LoginViewRoute extends _i7.PageRouteInfo<LoginViewRouteArgs> {
  LoginViewRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LoginViewRoute.name,
          args: LoginViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i7.PageInfo<LoginViewRouteArgs> page =
      _i7.PageInfo<LoginViewRouteArgs>(name);
}

class LoginViewRouteArgs {
  const LoginViewRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'LoginViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.ProfileViewScreen]
class ProfileViewRoute extends _i7.PageRouteInfo<void> {
  const ProfileViewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileViewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SearchResultScreen]
class SearchResultRoute extends _i7.PageRouteInfo<SearchResultRouteArgs> {
  SearchResultRoute({
    _i8.Key? key,
    required String value,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SearchResultRoute.name,
          args: SearchResultRouteArgs(
            key: key,
            value: value,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchResultRoute';

  static const _i7.PageInfo<SearchResultRouteArgs> page =
      _i7.PageInfo<SearchResultRouteArgs>(name);
}

class SearchResultRouteArgs {
  const SearchResultRouteArgs({
    this.key,
    required this.value,
  });

  final _i8.Key? key;

  final String value;

  @override
  String toString() {
    return 'SearchResultRouteArgs{key: $key, value: $value}';
  }
}

/// generated route for
/// [_i6.SignupViewScreen]
class SignupViewRoute extends _i7.PageRouteInfo<void> {
  const SignupViewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignupViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupViewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
