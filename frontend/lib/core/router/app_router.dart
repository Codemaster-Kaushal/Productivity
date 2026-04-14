import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/signup_screen.dart';
import '../../features/dashboard/ui/dashboard_screen.dart';
import '../../features/goals/ui/goals_screen.dart';
import '../../features/pomodoro/ui/pomodoro_screen.dart';
import '../../features/checkin/ui/checkin_screen.dart';
import '../../features/journal/ui/journal_screen.dart';
import '../../features/scores/ui/scores_screen.dart';
import '../../features/semester/ui/semester_screen.dart';
import '../../features/weekly_budget/ui/weekly_budget_screen.dart';
import '../../features/friends/ui/streak_board_screen.dart';
import 'main_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  redirect: (context, state) {
    final isLoggedIn = context.read<AuthCubit>().state.maybeWhen(authenticated: (_) => true, orElse: () => false);
    final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/signup';
    if (!isLoggedIn && !isAuthRoute) return '/login';
    if (isLoggedIn && isAuthRoute) return '/dashboard';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, _) => LoginScreen()),
    GoRoute(path: '/signup', builder: (_, _) => SignupScreen()),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (_, _) => DashboardScreen()),
        GoRoute(path: '/goals', builder: (_, _) => GoalsScreen()),
        GoRoute(path: '/pomodoro', builder: (_, _) => PomodoroScreen()),
        GoRoute(path: '/checkin', builder: (_, _) => CheckinScreen()),
        GoRoute(path: '/journal', builder: (_, _) => JournalScreen()),
        GoRoute(path: '/scores', builder: (_, _) => ScoresScreen()),
        GoRoute(path: '/semester', builder: (_, _) => SemesterScreen()),
        GoRoute(path: '/budget', builder: (_, _) => WeeklyBudgetScreen()),
        GoRoute(path: '/friends', builder: (_, _) => StreakBoardScreen()),
      ],
    ),
  ],
);
