import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static const _tabs = [
    _NavItem('/dashboard', Icons.dashboard_rounded, 'Dashboard'),
    _NavItem('/goals', Icons.flag_rounded, 'Focus'),
    _NavItem('/pomodoro', Icons.add_circle, 'Capture', isLarge: true),
    _NavItem('/checkin', Icons.insights_rounded, 'Reflection'),
    _NavItem('/semester', Icons.settings, 'Settings'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path)) return i;
    }
    return 0;
  }

  String _currentTitle(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (final tab in _tabs) {
      if (location.startsWith(tab.path)) {
        return tab.label;
      }
    }

    switch (location) {
      case '/journal':
        return 'Journal';
      case '/scores':
        return 'Score History';
      case '/friends':
        return 'Friends';
      case '/budget':
        return 'Budget';
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIdx = _currentIndex(context);
    final currentTitle = _currentTitle(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background aurora blur
          Positioned(
            top: -200,
            left: MediaQuery.of(context).size.width / 2 - 300,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    AppColors.secondary.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Page Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 120),
              child: child,
            ),
          ),

          // ── Top NavBar ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E0E11).withOpacity(0.6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(132, 85, 239, 0.06),
                        offset: Offset(0, 8),
                        blurRadius: 32,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo Text
                      Text(
                        'Celestial Productivity',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                          color: AppColors.primary,
                        ),
                      ),

                      // Desktop Links (hidden on very small viewports)
                      if (MediaQuery.of(context).size.width > 768)
                        Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondary,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            currentTitle,
                            style: GoogleFonts.inter(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        )
                      else
                        const SizedBox(),

                      // Right Icons / Profile
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications, color: AppColors.onSurfaceVariant),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          PopupMenuButton<String>(
                            offset: const Offset(0, 48),
                            color: AppColors.surfaceContainerHigh,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onSelected: (value) async {
                              if (value == 'logout') {
                                await context.read<AuthRepository>().signOut();
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'settings',
                                child: Text('Settings', style: AppTextStyles.bodyPrimary),
                              ),
                              PopupMenuItem(
                                value: 'logout',
                                child: Text(
                                  'Logout',
                                  style: AppTextStyles.bodyPrimary.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                            ],
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.outlineVariant.withOpacity(0.3),
                                ),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA_kYhRg_39OJdRWlE5gwJsWTeZ2kgG8utFp__DJ7sbEcHOK_6SM0vIoFwUEf0NBdyz3Ag4zh0UjJmS7EQUHLZ2hQQIZNIjFtHaz7c4boNddOtuROCa_MbOHq7TyzC80dbAf02KaHcS_dLYyh28BKyI-tbg6oujHRB3ioeSBP14BxiLlLkJBgpooKH6mM-huyiyyeB3iR9Emhj1qU-fAVclXPI1IitQTli9gEhJ8ERZqhEpuNY59wRqcuGCRov5bli7BAEaEQ9sIzIk',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom Pill NavBar ──
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    constraints: const BoxConstraints(maxWidth: 448),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25252A).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: const Color(0xFF48474B).withOpacity(0.15),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 50,
                          offset: Offset(0, 20),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_tabs.length, (i) {
                        final tab = _tabs[i];
                        final isActive = i == currentIdx;

                        return GestureDetector(
                          onTap: () => context.go(tab.path),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                tab.icon,
                                size: tab.isLarge ? 36 : 24,
                                color: isActive
                                    ? AppColors.secondary
                                    : AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tab.label.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: isActive
                                      ? AppColors.secondary
                                      : AppColors.onSurfaceVariant,
                                ),
                              ),
                              if (isActive && !tab.isLarge)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.secondary,
                                        blurRadius: 8,
                                      )
                                    ],
                                  ),
                                )
                              else
                                const SizedBox(height: 8),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final String label;
  final bool isLarge;

  const _NavItem(this.path, this.icon, this.label, {this.isLarge = false});
}
