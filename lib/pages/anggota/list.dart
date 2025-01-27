// Impor library yang diperlukan
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Impor model Anggota
import '../../model/anggota.dart';

// Impor UI Sidebar
import '../partials/sidebar.dart';

// Buat Class AnggotaListPage untuk menampilkan halaman list anggota
class AnggotaListPage extends StatefulWidget {
  @override
  _AnggotaListPageState createState() => _AnggotaListPageState();
}

// Buat Class _AnggotaListPageState untuk membuat state dari AnggotaListPage
class _AnggotaListPageState extends State<AnggotaListPage> {

  // Deklarasi variabel untuk menampung data anggota
  List<Anggota> anggotaList = [];

  // Method untuk mengambil data anggota dari API
  Future<List<Anggota>> fetchAnggotaList() async {
    final response = await http
        .get(Uri.parse('https://649443970da866a953677178.mockapi.io/anggota'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Anggota.fromJson(data)).toList();
    } else {
      throw Exception('Data anggota tidak dapat diambil');
    }
  }

  // Method untuk merefresh data anggota
  Future<void> refreshAnggotaList() async {
    final List<Anggota> list = await fetchAnggotaList();
    setState(() {
      anggotaList = list;
    });
  }

  // Method untuk menghapus anggota
  Future<void> deleteAnggota(String id) async {
    final response = await http.delete(
      Uri.parse('https://649443970da866a953677178.mockapi.io/anggota/$id'),
    );
    if (response.statusCode == 200) {
      setState(() {
        anggotaList.removeWhere((anggota) => anggota.id == id);
      });
    } else {
      throw Exception('Gagal menghapus anggota');
    }
  }

  // Method untuk menambah anggota
  Future<void> addAnggota(String nama, int nim, String kelas) async {
    final response = await http.post(
      Uri.parse('https://649443970da866a953677178.mockapi.io/anggota'),
      body: {
        'nama': nama,
        'nim': nim.toString(),
        'kelas': kelas,
      },
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final newAnggota = Anggota.fromJson(responseData);
      setState(() {
        anggotaList.add(newAnggota);
      });
    } else {
      throw Exception('Gagal menambah anggota');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnggotaList().then((list) {
      setState(() {
        anggotaList = list;
      });
    });
  }

  // Buat UI untuk menampilkan list anggota
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Anggota',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
        elevation: 4, // Menambahkan bayangan untuk AppBar
      ),
      drawer: Sidebar(),
      body: ListView.builder(
        itemCount: anggotaList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // Menambahkan bayangan untuk Card
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin untuk jarak antar Card
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding dalam ListTile
              title: Text(
                anggotaList[index].nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                'NIM: ${anggotaList[index].nim}',
                style: TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol Hapus
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus anggota ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteAnggota(anggotaList[index].id);
                                Navigator.pop(context);
                              },
                              child: Text('Hapus', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Tombol Detail
                  IconButton(
                    icon: Icon(Icons.info, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnggotaDetailPage(
                            anggota: anggotaList[index],
                          ),
                        ),
                      );
                    },
                  ),
                  // Tombol Edit
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnggotaUpdatePage(
                            anggota: anggotaList[index],
                          ),
                        ),
                      ).then((value) {
                        if (value == true) {
                          fetchAnggotaList().then((list) {
                            setState(() {
                              anggotaList = list;
                            });
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Tombol tambah anggota
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnggotaAddPage()),
          ).then((value) {
            if (value != null && value is Map) {
              final String nama = value['nama'];
              final int nim = value['nim'];
              final String kelas = value['kelas'];
              addAnggota(nama, nim, kelas);
            }
          });
        },
        backgroundColor: Colors.green, // Warna tombol
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}

// Halaman untuk melihat detail anggota
class AnggotaDetailPage extends StatelessWidget {
  final Anggota anggota;

  AnggotaDetailPage({required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Anggota'),
      ),
      drawer: Sidebar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nama: ${anggota.nama}', style: TextStyle(fontSize: 18)),
            Text('NIM: ${anggota.nim}', style: TextStyle(fontSize: 16)),
            Text('Kelas: ${anggota.kelas}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnggotaUpdatePage(anggota: anggota)),
          ).then((value) {
            if (value == true) {
              Navigator.pop(context, true);
            }
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class AnggotaAddPage extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Anggota'),
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: nimController,
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: kelasController,
              decoration: InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String nama = namaController.text;
                final int nim = int.parse(nimController.text);
                final String kelas = kelasController.text;
                Navigator.pop(
                    context, {'nama': nama, 'nim': nim, 'kelas': kelas});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Warna tombol
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text('Simpan', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class AnggotaUpdatePage extends StatelessWidget {
  final Anggota anggota;
  final TextEditingController namaController;
  final TextEditingController nimController;
  final TextEditingController kelasController;

  AnggotaUpdatePage({required this.anggota})
      : namaController = TextEditingController(text: anggota.nama),
        nimController = TextEditingController(text: anggota.nim.toString()),
        kelasController = TextEditingController(text: anggota.kelas);

  Future<void> updateAnggota(
      String id, String nama, int nim, String kelas) async {
    final response = await http.put(
      Uri.parse('https://649443970da866a953677178.mockapi.io/anggota/$id'),
      body: {
        'nama': nama,
        'nim': nim.toString(),
        'kelas': kelas,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update anggota');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Anggota'),
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: nimController,
              decoration: InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: kelasController,
              decoration: InputDecoration(labelText: 'Kelas'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String nama = namaController.text;
                final int nim = int.parse(nimController.text);
                final String kelas = kelasController.text;
                updateAnggota(anggota.id, nama, nim, kelas).then((_) {
                  Navigator.pop(context, true);
                }).catchError((error) {
                  print(error); // Handle error jika gagal mengupdate anggota
                });
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
