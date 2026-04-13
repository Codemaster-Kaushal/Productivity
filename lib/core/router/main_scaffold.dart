import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/dashboard': return 0;
      case '/goals': return 1;
      case '/pomodoro': return 2;
      case '/journal': return 3;
      case '/semester': return 4;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E2E),
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle_rounded), label: 'Goals'),
            BottomNavigationBarItem(icon: Icon(Icons.timer_rounded), label: 'Pomodoro'),
            BottomNavigationBarItem(icon: Icon(Icons.book_rounded), label: 'Journal'),
            BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Semester'),
          ],
          onTap: (index) {
            switch (index) {
              case 0: context.go('/dashboard'); break;
              case 1: context.go('/goals'); break;
              case 2: context.go('/pomodoro'); break;
              case 3: context.go('/journal'); break;
              case 4: context.go('/semester'); break;
            }
          },
        ),
      ),
    );
  }
}
