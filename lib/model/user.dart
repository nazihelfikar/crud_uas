// Buat class User untuk menampung data user
class User {

  // Inisialisasi variabel
  final String id;
  final String username;
  final String password;

  // Konstruktor (Constructor) berfungsi untuk menginisialisasi nilai awal
  User({required this.id, required this.username, required this.password});

  // Ubah data json menjadi objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }

  // Ubah objek User menjadi data json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
