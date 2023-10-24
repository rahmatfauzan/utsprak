import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utsprak/detailsoon.dart';
import 'datasoon.dart';
import 'list.dart';
import 'datamovie.dart';
import 'detail.dart';

class TimeSelectionPage extends StatelessWidget {
  TimeSelectionPage({super.key, required this.dataMovie});
  final Movie dataMovie;
  final List<String> availableTimes = [
    '10:00 AM',
    '1:00 PM',
    '4:00 PM',
    '7:00 PM',
    '10:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4F88F7),
          title: Text('Pilih Jam Tayang'),
        ),
        body: ListView.builder(
          itemCount: availableTimes.length,
          itemBuilder: (context, index) {
            final time = availableTimes[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  // Action ketika jam tertentu dipilih
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatSelectionPage(),
                    ),
                  );
                },
                title: Text(
                  time,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(dataMovie.name),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ));
  }
}

class SeatSelectionPage extends StatefulWidget {
  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<String> selectedSeats = [];

  List<String> availableSeats = [
    'A1',
    'A2',
    'A3',
    'A4',
    'B1',
    'B2',
    'B3',
    'B4',
    'C1',
    'C2',
    'C3',
    'C4',
    'D1',
    'D2',
    'D3',
    'D4',
  ];

  void toggleSeatSelection(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat); // Batalkan pemilihan kursi
      } else {
        selectedSeats.add(seat); // Pilih kursi
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F88F7),
        title: Text('Select Seats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Daftar kursi dalam 4 baris
            for (int row = 0; row < 4; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int col = 0; col < 4; col++)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final seat =
                              String.fromCharCode('A'.codeUnitAt(0) + row) +
                                  (col + 1).toString(); //A/B/C/D+nomor kolom
                          toggleSeatSelection(seat);
                        },
                        style: selectedSeats.contains(
                                String.fromCharCode('A'.codeUnitAt(0) + row) +
                                    (col + 1).toString())
                            ? ElevatedButton.styleFrom(primary: Colors.green)
                            : null,
                        child: Text(
                            String.fromCharCode('A'.codeUnitAt(0) + row) +
                                (col + 1).toString()),
                      ),
                    ),
                ],
              ),
            // Tombol "Pesan"
            ElevatedButton(
              onPressed: () {},
              child: Text('Pesan'),
            ),
          ],
        ),
      ),
    );
  }
}
