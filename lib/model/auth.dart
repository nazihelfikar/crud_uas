// Buat Class Auth untuk menampung data auth
class Auth {

  // Deklarasi variabel
  final String id;
  final String username;
  final String password;

  // Konstruktor (Constructor) berfungsi untuk menginisialisasi nilai awal
  Auth({required this.id, required this.username, required this.password});

  // Ubah data json menjadi objek Auth
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }

  // Ubah objek Auth menjadi data json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
