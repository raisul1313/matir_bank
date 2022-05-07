final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, userName, password
  ];

  static final String id = '_id';
  static final String userName = 'userName';
  static final String password = 'password';
}

class AppUser {
  final int? id;
  final String userName;
  final String password;

  const AppUser({
    this.id,
    required this.userName,
    required this.password,
  });

  AppUser copy({
    int? id,
    String? userName,
    String? password,
  }) =>
      AppUser(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        password: password ?? this.password,
      );

  static AppUser fromJson(Map<String, Object?> json) => AppUser(
        id: json[UserFields.id] as int?,
        userName: json[UserFields.userName] as String,
        password: json[UserFields.password] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.userName: userName,
        UserFields.password: password,
      };
}
