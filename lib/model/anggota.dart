// Buat class Anggota untuk menampung data anggota
class Anggota {

  // Deklarasi variabel
  final String id;
  final String nama;
  final String nim;
  final String kelas;

  // Konstruktor (Constructor) berfungsi untuk menginisialisasi nilai awal
  Anggota(
    {
      // Parameter yang dibutuhkan untuk membuat objek Anggota
      required this.id,
      required this.nama,
      required this.nim,
      required this.kelas
    }
  );

  // Method untuk mengubah data json menjadi objek Anggota
  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nama: json['nama'],
      nim: json['nim'],
      kelas: json['kelas'],
    );
  }

  // Method untuk mengubah objek Anggota menjadi data json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'kelas': kelas,
    };
  }
}
