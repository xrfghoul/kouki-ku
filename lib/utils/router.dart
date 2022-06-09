import 'package:flutter/material.dart';
import 'package:kokiku/utils/route_name.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RouteName.HomeRoute:
      return PageRouteBuilder(pageBuilder: (context, anim, anim2) {
        //TODO : home screen
        throw UnimplementedError();
      });
    default:
      throw UnimplementedError();
  }
}
