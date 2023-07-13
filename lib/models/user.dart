class User {
  final String ID;
  final String name;
  final String email;
  final String password;
  final String photoUrl;

  User({required this.email, required this.password, required this.ID, required this.photoUrl, required this.name });


 Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'name':name,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      ID: map['ID'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      photoUrl: map['photoUrl'],
    );
  }


}
