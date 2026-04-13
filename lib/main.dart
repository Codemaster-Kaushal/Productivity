import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/router/app_router.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/dashboard/data/dashboard_repository.dart';
import 'features/dashboard/cubit/dashboard_cubit.dart';
import 'features/goals/data/goals_repository.dart';
import 'features/goals/cubit/goals_cubit.dart';
import 'features/pomodoro/data/pomodoro_repository.dart';
import 'features/pomodoro/cubit/pomodoro_cubit.dart';
import 'features/journal/data/journal_repository.dart';
import 'features/journal/cubit/journal_cubit.dart';
import 'features/scores/data/scores_repository.dart';
import 'features/scores/cubit/scores_cubit.dart';
import 'features/semester/data/semester_repository.dart';
import 'features/semester/cubit/semester_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(".env file not found or could not be loaded.");
  }

  // 2. Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // 3. App Setup
  final app = MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(create: (context) => AuthRepository(Supabase.instance.client)),
      RepositoryProvider<DashboardRepository>(create: (context) => DashboardRepository()),
      RepositoryProvider<GoalsRepository>(create: (context) => GoalsRepository()),
      RepositoryProvider<PomodoroRepository>(create: (context) => PomodoroRepository()),
      RepositoryProvider<JournalRepository>(create: (context) => JournalRepository()),
      RepositoryProvider<ScoresRepository>(create: (context) => ScoresRepository()),
      RepositoryProvider<SemesterRepository>(create: (context) => SemesterRepository()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(context.read<AuthRepository>())),
        BlocProvider(create: (context) => DashboardCubit(context.read<DashboardRepository>())),
        BlocProvider(create: (context) => GoalsCubit(context.read<GoalsRepository>())),
        BlocProvider(create: (context) => PomodoroCubit(context.read<PomodoroRepository>())),
        BlocProvider(create: (context) => JournalCubit(context.read<JournalRepository>())),
        BlocProvider(create: (context) => ScoresCubit(context.read<ScoresRepository>())),
        BlocProvider(create: (context) => SemesterCubit(context.read<SemesterRepository>())),
      ],
      child: const ProductivityApp(),
    ),
  );

  // 4. Sentry
  final sentryDsn = dotenv.env['SENTRY_DSN'] ?? '';
  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(app),
    );
  } else {
    runApp(app);
  }
}

class ProductivityApp extends StatelessWidget {
  const ProductivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Productivity',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFF03DAC6),
          surface: const Color(0xFF1E1E2E),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
        cardColor: const Color(0xFF1E1E2E),
      ),
      routerConfig: appRouter,
    );
  }
}
