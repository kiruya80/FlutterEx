// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

/// Signature for a function that extracts a screen name from [RouteSettings].
///
/// Usually, the route name is not a plain string, and it may contains some
/// unique ids that makes it difficult to aggregate over them in Firebase
/// Analytics.
typedef ScreenNameExtractor = String? Function(RouteSettings settings);

String? defaultNameExtractor(RouteSettings settings) => settings.name;

/// [RouteFilter] allows to filter out routes that should not be tracked.
///
/// By default, only [PageRoute]s are tracked.
typedef RouteFilter = bool Function(Route<dynamic>? route);

bool defaultRouteFilter(Route<dynamic>? route) => route is PageRoute;

/// A [NavigatorObserver] that sends events to Firebase Analytics when the
/// currently active [ModalRoute] changes.
///
/// When a route is pushed or popped, and if [routeFilter] is true,
/// [nameExtractor] is used to extract a name  from [RouteSettings] of the now
/// active route and that name is sent to Firebase.
///
/// The following operations will result in sending a screen view event:
/// ```dart
/// Navigator.pushNamed(context, '/contact/123');
///
/// Navigator.push<void>(context, MaterialPageRoute(
///   settings: RouteSettings(name: '/contact/123'),
///   builder: (_) => ContactDetail(123)));
///
/// Navigator.pushReplacement<void>(context, MaterialPageRoute(
///   settings: RouteSettings(name: '/contact/123'),
///   builder: (_) => ContactDetail(123)));
///
/// Navigator.pop(context);
/// ```
///
/// To use it, add it to the `navigatorObservers` of your [Navigator], e.g. if
/// you're using a [MaterialApp]:
/// ```dart
/// MaterialApp(
///   home: MyAppHome(),
///   navigatorObservers: [
///     FirebaseAnalyticsObserver(analytics: service.analytics),
///   ],
/// );
/// ```
///
/// You can also track screen views within your [ModalRoute] by implementing
/// [RouteAware<ModalRoute<dynamic>>] and subscribing it to [FirebaseAnalyticsObserver]. See the
/// [RouteObserver<ModalRoute<dynamic>>] docs for an example.
class QcFirebaseAnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {
  /// Creates a [NavigatorObserver] that sends events to [FirebaseAnalytics].
  ///
  /// When a route is pushed or popped, [nameExtractor] is used to extract a
  /// name from [RouteSettings] of the now active route and that name is sent to
  /// Firebase. Defaults to `defaultNameExtractor`.
  ///
  /// If a [PlatformException] is thrown while the observer attempts to send the
  /// active route to [analytics], `onError` will be called with the
  /// exception. If `onError` is omitted, the exception will be printed using
  /// `debugPrint()`.
  QcFirebaseAnalyticsObserver({
    required this.analytics,
    this.nameExtractor = defaultNameExtractor,
    this.routeFilter = defaultRouteFilter,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  final FirebaseAnalytics analytics;
  final ScreenNameExtractor nameExtractor;
  final RouteFilter routeFilter;
  final void Function(PlatformException error)? _onError;

  Future<void> _sendScreenView(Route<dynamic> route) async {
    QcLog.e('_sendScreenView === ${route.settings}');
    QcLog.e('_sendScreenView === ${route.settings.name}');
    QcLog.e('_sendScreenView === ${route.settings.arguments}');

    var className = 'Flutter';

    try {
      var args = route.settings.arguments;
      QcLog.e('args : $args');
      HomeItem homeItem = args as HomeItem;
      QcLog.e('name : ${homeItem.name}');
      className = homeItem.name;
    } on Exception catch (e) {
      QcLog.e('Exception === $e');
    }
    final String? screenName = nameExtractor(route.settings);
    QcLog.e('screenName === ${screenName}');
    if (screenName != null) {
      await analytics
          .setCurrentScreen(
              screenName: screenName, screenClassOverride: className)
          .catchError(
        (Object error) {
          final _onError = this._onError;
          QcLog.e('setCurrentScreen ${error} ==== ${_onError}');
          if (_onError == null) {
            debugPrint('$FirebaseAnalyticsObserver: $error');
          } else {
            _onError(error as PlatformException);
          }
        },
        test: (Object error) => error is PlatformException,
      );
    } else {
      QcLog.e('screenName null');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    QcLog.e('didPush === ${route.settings}');
    if (routeFilter(route)) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    QcLog.e('didReplace === ${newRoute}');
    if (newRoute != null && routeFilter(newRoute)) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    QcLog.e('didPop === ${route}');
    if (previousRoute != null &&
        routeFilter(previousRoute) &&
        routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }
}
