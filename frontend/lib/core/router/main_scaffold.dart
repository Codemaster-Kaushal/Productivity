import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  MainScaffold({super.key, required this.child});

  static const _tabs = [
    _NavItem('/dashboard', Icons.timer, 'Focus'),
    _NavItem('/goals', Icons.auto_stories, 'Vault'),
    _NavItem('/pomodoro', Icons.add_circle, 'Capture', isLarge: true),
    _NavItem('/checkin', Icons.insights, 'Insights'),
    _NavItem('/semester', Icons.settings, 'Settings'),
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
      body: Stack(
        children: [
          // Background aurora blur container matching HTML:
          // background: radial-gradient(circle at 50% -20%, rgba(186, 158, 255, 0.15) 0%, rgba(236, 99, 255, 0.05) 50%, transparent 100%);
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
          
          // Page Content padding top to avoid fixed nav
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 120), // Leave room for padding & bottom pill
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
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), // backdrop-blur-xl
                child: Container(
                  height: 64, // h-16
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: Color(0xFF0E0E11).withOpacity(0.6), // bg-[#0e0e11]/60
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(132, 85, 239, 0.06), // from HTML shadow
                        offset: Offset(0, 8),
                        blurRadius: 32,
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo Text
                      Text(
                        'Celestial Productivity',
                        style: GoogleFonts.inter(
                          fontSize: 20, // text-xl
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5, // tracking-tighter
                          color: AppColors.primary, // text-[#ba9eff]
                        ),
                      ),
                      
                      // Desktop Links (hidden on very small viewports)
                      if (MediaQuery.of(context).size.width > 768)
                        Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: AppColors.secondary, width: 2))
                          ),
                          child: Text(
                            'Dashboard',
                            style: GoogleFonts.inter(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        )
                      else SizedBox(),

                      // Right Icons / Profile
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications, color: AppColors.onSurfaceVariant),
                            onPressed: () {},
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
                              image: DecorationImage(
                                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuA_kYhRg_39OJdRWlE5gwJsWTeZ2kgG8utFp__DJ7sbEcHOK_6SM0vIoFwUEf0NBdyz3Ag4zh0UjJmS7EQUHLZ2hQQIZNIjFtHaz7c4boNddOtuROCa_MbOHq7TyzC80dbAf02KaHcS_dLYyh28BKyI-tbg6oujHRB3ioeSBP14BxiLlLkJBgpooKH6mM-huyiyyeB3iR9Emhj1qU-fAVclXPI1IitQTli9gEhJ8ERZqhEpuNY59wRqcuGCRov5bli7BAEaEQ9sIzIk'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom Pill NavBar ──
          Positioned(
            bottom: 32, // bottom-8
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0), // backdrop-blur-[30px]
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    constraints: BoxConstraints(maxWidth: 448), // max-w-md
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF25252A).withOpacity(0.6), // bg-[#25252a]/60
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: Color(0xFF48474B).withOpacity(0.15)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 50,
                          offset: Offset(0, 20),
                        )
                      ]
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
                                size: tab.isLarge ? 36 : 24, // text-4xl for Capture
                                color: isActive ? AppColors.secondary : AppColors.onSurfaceVariant,
                              ),
                              SizedBox(height: 4),
                              Text(
                                tab.label.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5, // 0.05em
                                  color: isActive ? AppColors.secondary : AppColors.onSurfaceVariant,
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
                                      BoxShadow(color: AppColors.secondary, blurRadius: 8)
                                    ]
                                  ),
                                )
                              else
                                SizedBox(height: 8),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          )
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
