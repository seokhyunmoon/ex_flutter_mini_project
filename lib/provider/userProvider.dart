import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '/models/user.dart';

class AsyncUsersNotifier extends AsyncNotifier<List<User>> {
  Future<List<User>> _fetchUsers() async {
    final response = await http.get(Uri.http('localhost:3000', '/users'));
    final usersJson = jsonDecode(response.body) as List;
    final users = usersJson
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
    return users;
  }

  @override
  Future<List<User>> build() async {
    // Load initial user list from the remote repository
    return _fetchUsers();
  }

  Future<void> addUser(User user) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new user and reload the user list from the remote repository
    state = await AsyncValue.guard(() async {
      await http.post(Uri.http('localhost:3000', '/users'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()));
      return _fetchUsers();
    });
  }

  // Let's allow removing users
  Future<void> removeUser(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.http('localhost:3000', '/users/$userId'));
      return _fetchUsers();
    });
  }

  // Let's mark a user as completed
  Future<void> toggle(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.http('localhost:3000', '/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: <String, dynamic>{'isActive': true},
      );
      return _fetchUsers();
    });
  }
}

final asyncUsersProvider =
    AsyncNotifierProvider<AsyncUsersNotifier, List<User>>(() {
  return AsyncUsersNotifier();
});
