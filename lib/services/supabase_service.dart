import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseService? _instance;
  late final SupabaseClient _client;

  SupabaseService._();

  static Future<SupabaseService> initialize({
    required String url,
    required String anonKey,
  }) async {
    if (_instance == null) {
      _instance = SupabaseService._();
      await Supabase.initialize(url: url, anonKey: anonKey);
      _instance!._client = Supabase.instance.client;
    }
    return _instance!;
  }

  static SupabaseService get instance {
    if (_instance == null) {
      throw Exception(
          'SupabaseService has not been initialized. Call initialize() first.');
    }
    return _instance!;
  }

  SupabaseClient get client => _client;

  // Supabaseの各サービスへのアクセサ
  GoTrueClient get auth => _client.auth;
  StorageFileApi get storage => _client.storage.from('your-bucket-name');

  // テーブルに対するクエリビルダーを取得
  SupabaseQueryBuilder from(String table) => _client.from(table);

  // リアルタイムサブスクリプションの作成
  Stream<List<Map<String, dynamic>>> createSubscription(String table) {
    return _client
        .from(table)
        .stream(primaryKey: ['id'])
        .eq('id', 'id') // この条件は全てのレコードを取得します。必要に応じて変更してください。
        .order('created_at', ascending: false);
  }
}
