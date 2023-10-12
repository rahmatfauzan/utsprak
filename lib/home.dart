import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utsprak/detailsoon.dart';
import 'datasoon.dart';
import 'list.dart';
import 'datamovie.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Steps to use color from hex in Flutter:
      //1. Remove the # sign.
      //2. Add 0xFF at the beginning of the color code.
      //3. Place it inside the Color class like this Color(0xFFbfeb91).
      //ganti background color jadi hitem
      //backgroundColor: const Color(0xFF393434),
      appBar: AppBar(
        //ngilangin appbar
        elevation: 0,
        toolbarHeight: 0,
        //ngubah warna status bar
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF4F88F7),
        ),
      ),
      body:
      Container(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Halo",
                style:TextStyle(
                    color: Color(0xFF393434),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 28),
              ),
              const Text("Mau nonton apa hari ini?",
                style:TextStyle(
                    color: Color(0xFF393434),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 16),
              ),

              Expanded(
                  child: ListView.builder(
                    //biar listview menyamping
                      scrollDirection: Axis.horizontal,
                      itemCount: dataSoon.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailSoon(dataSoon: dataSoon[index]),
                              ),
                            );
                          },
                          child: Row(
                              children: [
                                Image.asset(dataSoon[index].poster,
                                  width: 320.0,
                                  height : 200.0,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(width: 10),
                              ]
                          ),
                        );
                      }
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Now Showing",
                    style: TextStyle(
                        color: Color(0xFF393434),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 16),
                  ),
                  //biar bisa dipush pas teks ditekan
                  GestureDetector(
                    child: const Text("See All",
                      style: TextStyle(
                          color: Color(0xFF4F88F7),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 12),
                    ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const ListMovie()));
                      },
                  )
                ],
              ),

              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataMovie.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Detail(dataMovie: dataMovie[index]),
                              ),
                            );
                          },
                          child: Row(
                              children: [
                                Image.asset(dataMovie[index].poster,
                                  width: 150.0,
                                  height : 220.0,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(width: 10),
                              ]
                          ),
                          //)   Card
                        );
                      }
                  )),
            ],
          )
      ),
    );

  }
}
