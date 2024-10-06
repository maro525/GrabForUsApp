import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/home/screens/home_screen.dart';

class GrabForUsApp extends StatelessWidget {
  const GrabForUsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
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
        home: const HomeScreen(),
        // ここにルート設定を追加できます
        // routes: {
        //   '/login': (context) => LoginScreen(),
        //   '/profile': (context) => ProfileScreen(),
        //   // その他のルート
        // },
      ),
    );
  }
}
