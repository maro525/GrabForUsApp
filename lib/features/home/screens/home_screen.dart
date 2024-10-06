import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 買い物リストのモデル
class ShoppingList {
  final String id;
  final String name;
  final int itemCount;

  ShoppingList({required this.id, required this.name, required this.itemCount});
}

// 買い物リストのプロバイダー
final shoppingListsProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingList>>((ref) {
  return ShoppingListNotifier();
});

class ShoppingListNotifier extends StateNotifier<List<ShoppingList>> {
  ShoppingListNotifier() : super([]);

  void addList(ShoppingList list) {
    state = [...state, list];
  }

  // その他のメソッド（リストの削除、更新など）
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingLists = ref.watch(shoppingListsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GrabForUs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: 通知画面への遷移
            },
          ),
        ],
      ),
      body: shoppingLists.isEmpty
          ? const Center(child: Text('買い物リストを作成しましょう！'))
          : ListView.builder(
              itemCount: shoppingLists.length,
              itemBuilder: (context, index) {
                final list = shoppingLists[index];
                return ListTile(
                  title: Text(list.name),
                  subtitle: Text('${list.itemCount} items'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: リスト詳細画面への遷移
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: 新規リスト作成ダイアログを表示
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('新しい買い物リスト'),
              content: TextField(
                decoration: const InputDecoration(hintText: "リスト名"),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    ref.read(shoppingListsProvider.notifier).addList(
                          ShoppingList(
                            id: DateTime.now().toString(),
                            name: value,
                            itemCount: 0,
                          ),
                        );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // ホーム画面が選択されている状態
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lists'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // TODO: 他の画面への遷移
        },
      ),
    );
  }
}
