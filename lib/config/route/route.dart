import 'package:go_router/go_router.dart';
import 'package:miapp/features/auth/presentation/pages/login.dart';
import 'package:miapp/features/dashboard/presentation/pages/dashboard.dart';
import 'package:miapp/features/main/presentation/pages/main_layout.dart';

class AppRoute {
  static const String dashboard = '/';
  static const String login = '/login';
  static const String main = '/main';  // Add this line
  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),

      //HOME
      GoRoute(
        path: dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainLayout(),
      )
    ],
  );
}