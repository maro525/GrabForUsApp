import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/home_screen.dart';

class GrabForUsApp extends ConsumerWidget {
  const GrabForUsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'GrabForUs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // アプリ全体のテーマをここでカスタマイズできます
      ),
      darkTheme: ThemeData.dark().copyWith(
        // ダークテーマの設定
        primaryColor: Colors.blueGrey,
        // その他のダークテーマのカスタマイズ
      ),
      themeMode: ThemeMode.system, // システムのテーマ設定に従う
      home: _buildHomeScreen(authState),
      // ここにルート設定を追加できます
      // routes: {
      //   '/profile': (context) => ProfileScreen(),
      //   // その他のルート
      // },
    );
  }

  Widget _buildHomeScreen(AuthState authState) {
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (authState.isAuthenticated) {
      return const HomeScreen();
    } else if (authState.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text('エラー: ${authState.errorMessage}')),
      );
    } else {
      return LoginScreen();
    }
  }
}
