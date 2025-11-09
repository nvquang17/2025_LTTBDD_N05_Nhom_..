import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/app_localizations.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_record_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const HealthTrackerApp());
}

class HealthTrackerApp extends StatefulWidget {
  const HealthTrackerApp({super.key});

  @override
  State<HealthTrackerApp> createState() => _HealthTrackerAppState();
}

class _HealthTrackerAppState extends State<HealthTrackerApp> {
  Locale _locale = const Locale('vi');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: MainDrawer(onChangeLanguage: _changeLanguage),
    );
  }
}

class MainDrawer extends StatefulWidget {
  final void Function(Locale) onChangeLanguage;

  const MainDrawer({super.key, required this.onChangeLanguage});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final pages = [
      const DashboardScreen(),
      const AddRecordScreen(),
      const StatisticsScreen(),
      SettingsScreen(onChangeLanguage: widget.onChangeLanguage),
      const AboutScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Health Tracker')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.teal),
              child: Text('Health Tracker', style: const TextStyle(color: Colors.white, fontSize: 22)),
            ),
            ListTile(title: Text(t.translate('home')), onTap: () { setState(() { _selectedIndex = 0; }); Navigator.pop(context); }),
            ListTile(title: Text(t.translate('add_record')), onTap: () { setState(() { _selectedIndex = 1; }); Navigator.pop(context); }),
            ListTile(title: Text(t.translate('statistics')), onTap: () { setState(() { _selectedIndex = 2; }); Navigator.pop(context); }),
            ListTile(title: Text(t.translate('settings')), onTap: () { setState(() { _selectedIndex = 3; }); Navigator.pop(context); }),
            ListTile(title: Text(t.translate('about')), onTap: () { setState(() { _selectedIndex = 4; }); Navigator.pop(context); }),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
