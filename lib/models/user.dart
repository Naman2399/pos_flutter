class User {
  String firstName, lastName, email, password;
  int accessLevel;
  bool active;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.accessLevel,
      required this.active});
}
