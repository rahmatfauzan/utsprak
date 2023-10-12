import 'package:flutter/material.dart';
import 'datamovie.dart';
import 'detail.dart';

class ListMovieGrid extends StatelessWidget {
  const ListMovieGrid ({super.key});
  //Class FirstScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F88F7),
        title: const Text("Now Showing"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: dataMovie.length,
          itemBuilder: (context, index) {
            return InkWell(
                child: Column(
                  children: [
                    Image.asset(dataMovie[index].poster,
                      width: 150.0,
                      height : 220.0,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150, // <-- Your width
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Detail(dataMovie: dataMovie[index]),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color(0xFFA1C5EF);  //warna pas ditekan
                              }
                              return const Color(0xFF233269); //warna default
                            },
                          ),
                          fixedSize: MaterialStateProperty.all(const Size(0, 0)),
                        ),
                        child: const Text('Buy Now',
                          style:TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 10
                          ),
                        ),
                      ),
                    )
                  ]
                ));
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            childAspectRatio: 0.63, //ngatur ukuran grid
            //childAspectRatio: MediaQuery.of(context).size.height / 1130, //ngatur ukuran grid
          ),
        ),
      ),
    );
  }
}
