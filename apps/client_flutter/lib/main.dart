import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_providers.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/search_screen.dart';
import 'screens/isbn_import_screen.dart';

void main() {
  runApp(const JsmaApp());
}

/// Root application widget.
class JsmaApp extends StatelessWidget {
  const JsmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
        ChangeNotifierProvider(create: (_) => IsbnImportProvider()),
      ],
      child: MaterialApp(
        title: 'JSMA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppShell(),
      ),
    );
  }
}

/// Responsive navigation shell with bottom nav (mobile) and navigation rail (tablet/desktop).
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<_NavItem> _items = const [
    _NavItem(label: 'Home', icon: Icons.home, screen: HomeScreen()),
    _NavItem(
      label: 'Library',
      icon: Icons.library_books,
      screen: LibraryScreen(),
    ),
    _NavItem(
      label: 'Search',
      icon: Icons.search,
      screen: SearchScreen(),
    ),
    _NavItem(
      label: 'ISBN',
      icon: Icons.qr_code,
      screen: IsbnImportScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_items[_selectedIndex].label),
        centerTitle: true,
      ),
      body: useRail
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.all,
                  destinations: _items
                      .map(
                        (item) => NavigationRailDestination(
                          icon: Icon(item.icon),
                          label: Text(item.label),
                        ),
                      )
                      .toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _items[_selectedIndex].screen),
              ],
            )
          : _items[_selectedIndex].screen,
      bottomNavigationBar: useRail
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              items: _items
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.screen,
  });

  final String label;
  final IconData icon;
  final Widget screen;
}
