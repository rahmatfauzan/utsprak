import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utsprak/main.dart';
import 'package:utsprak/userManager.dart';
import 'package:utsprak/sql_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  int akun = 1;

  List<Map<String, dynamic>> userr = [];

  @override
  void initState() {
    super.initState();
    refreshuser();
  }

  void refreshuser() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      userr = data;
    });
  }

// ...

  Future<void> login() async {
    final username = user.text;
    final pass = password.text;

    final db = await SQLHelper.db();

    try {
      final users = await db.query(
        'user',
        where: 'username = ? AND password = ?',
        whereArgs: [username, pass],
      );

      if (users.isNotEmpty) {
        final userId = users.first['id'] as int; // Ambil ID user
        UserManager().setUserId(userId);
        // Navigasi ke halaman Tes sambil membawa ID user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavBar(), // Kirim ID user ke Tes
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login gagal. Periksa username dan password.'),
          ),
        );
      }
    } catch (e) {
      print('Error in login: $e');
    }
  }

  Future<void> createAccount() async {
    final username = user.text;
    final pass = password.text;

    // Memeriksa apakah username sudah ada dalam database
    final existingUsers =
        await SQLHelper.getUsers(); // Mengambil semua user dari database
    final userExists =
        existingUsers.any((user) => user['username'] == username);

    if (userExists) {
      // Jika username sudah ada, tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username sudah ada. Pilih username lain.'),
        ),
      );
      print("user sudah ada");
    } else {
      // Jika username belum ada, tambahkan user baru ke database
      final id = await SQLHelper.tambahUser(username, pass);
      refreshuser();

      if (id > 0) {
        // Berhasil mendaftar, lakukan tindakan sesuai
        // Contoh: Navigasi ke halaman utama
        print("Berhasil mendaftar");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavBar(), // Kirim ID user ke Tes
          ),
        );
      } else {
        // Gagal mendaftar, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi gagal. Terjadi kesalahan.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // ... (Bagian tampilan tidak berubah)

            // Bagian Form Login/Register
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    akun == 1 ? "Login" : "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.green,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          TextField(
                            controller: user,
                            decoration: InputDecoration(
                              hintText: 'Username',
                            ),
                          ),
                          TextField(
                            controller: password,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            obscureText:
                                true, // Mengubah teks menjadi tersembunyi
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (akun == 1) {
                                  login();
                                } else {
                                  createAccount();
                                }
                              },
                              child: Text(akun == 1 ? "Login" : "Register"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                akun = akun == 1 ? 0 : 1;
                              });
                            },
                            child: Text(
                              akun == 1
                                  ? "Create account"
                                  : "I already have an account",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
