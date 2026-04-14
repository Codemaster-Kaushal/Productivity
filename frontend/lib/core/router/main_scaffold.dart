import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static const _tabs = [
    _NavItem('/dashboard', Icons.bolt_outlined, Icons.bolt, 'FOCUS'),
    _NavItem('/goals', Icons.layers_outlined, Icons.layers, 'VAULT'),
    _NavItem('/pomodoro', Icons.add_circle_outline, Icons.add_circle, 'CAPTURE'),
    _NavItem('/checkin', Icons.auto_graph_outlined, Icons.auto_graph, 'INSIGHTS'),
    _NavItem('/semester', Icons.settings_outlined, Icons.settings, 'SETTINGS'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIdx = _currentIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Aurora Top Bar ──
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 8,
            ),
            color: AppColors.background,
            child: Row(
              children: [
                Text(
                  'Celestial Productivity',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                _topTab('Dashboard', currentIdx == 0, () => context.go('/dashboard')),
                const SizedBox(width: 4),
                _topTab(
                  currentIdx == 3 ? 'Check-in' : 'Insights',
                  currentIdx == 3,
                  () => context.go('/checkin'),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, size: 20),
                  color: AppColors.textMuted,
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_outlined, size: 22),
                  color: AppColors.textMuted,
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),

          // ── Page Content ──
          Expanded(child: child),
        ],
      ),

      // ── Aurora Bottom Nav ──
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.surfaceBorder.withOpacity(0.3)),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 4,
          top: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_tabs.length, (i) {
            final tab = _tabs[i];
            final isActive = i == currentIdx;
            final isCaptureBtn = i == 2;

            return GestureDetector(
              onTap: () => context.go(tab.path),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isCaptureBtn)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 22),
                      )
                    else
                      Icon(
                        isActive ? tab.activeIcon : tab.icon,
                        size: 22,
                        color: isActive ? AppColors.navActive : AppColors.navInactive,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive ? AppColors.navActive : AppColors.navInactive,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (isActive && !isCaptureBtn)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    else
                      const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _topTab(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.surfaceLight : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: active ? FontWeight.w500 : FontWeight.w400,
            color: active ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem(this.path, this.icon, this.activeIcon, this.label);
}
