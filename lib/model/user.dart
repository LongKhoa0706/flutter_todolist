
class User {
  int id;
  String email;
  String name;
  String password;

  User({
    this.id,
    this.email,
    this.name,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "name": name,
    "password": password,
  };
}
