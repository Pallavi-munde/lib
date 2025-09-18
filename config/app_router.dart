import 'package:flutter/material.dart';

class AppRouter {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String fieldData = '/field-data';
  static const String droneData = '/drone-data';
  static const String carbonRegistry = '/carbon-registry';
  static const String smartContract = '/smart-contract';
  static const String adminDashboard = '/admin';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _fade(const _PlaceholderScreen(title: 'Login'));
      case dashboard:
        return _fade(const _PlaceholderScreen(title: 'Dashboard'));
      case fieldData:
        return _fade(const _PlaceholderScreen(title: 'Field Data Upload'));
      case droneData:
        return _fade(const _PlaceholderScreen(title: 'Drone Data Upload'));
      case carbonRegistry:
        return _fade(const _PlaceholderScreen(title: 'Carbon Registry'));
      case smartContract:
        return _fade(const _PlaceholderScreen(title: 'Smart Contract'));
      case adminDashboard:
        return _fade(const _PlaceholderScreen(title: 'Admin Dashboard'));
      default:
        return _fade(const _PlaceholderScreen(title: 'Not Found'));
    }
  }

  static PageRouteBuilder _fade(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}


