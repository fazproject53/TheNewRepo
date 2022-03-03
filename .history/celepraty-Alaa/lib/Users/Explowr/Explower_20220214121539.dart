import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:flutter/material.dart';

class Explower extends StatefulWidget {
  const Explower({Key? key}) : super(key: key);

  @override
  State<Explower> createState() => _ExplowerState();
}

class _ExplowerState extends State<Explower> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar("اكسبلور"),
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //عدد العناصر في كل صف
                  crossAxisSpacing: 8, // المسافات الراسية
                  childAspectRatio: 0.70, //حجم العناصر
                  mainAxisSpacing: 12 //المسافات الافقية

                  ),
              itemBuilder: (context, i) {
                r
              })),
    );
  }

  grifVew() {
    GridView.builder(
        itemCount: 10, // عدد العناصر الكلية
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //عدد العناصر في كل صف
            crossAxisSpacing: 8, // المسافات الراسية
            childAspectRatio: 0.70, //حجم العناصر
            mainAxisSpacing: 12 //المسافات الافقية

            ),
        itemBuilder: (context, i) {
//الشكل المراد عرضه=========================================================================================
          return InkWell(
            onTap: () {},
            child: Card(
              color: pink,
              child: Column(
                children: [
                  //image============================================================================
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("Assist/image/profile.jpg"),
                                fit: BoxFit.cover)),
                      )),
                  // name ===================================================================
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: grey,
                      child: Text(
                        "name",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // price===================================================================
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: grey,
                          ),
                          Text(
                            "price",
                          )
                        ],
                      )),

                  // address and send reqesu buttom====================================================
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: grey,
                            size: 30,
                          ),
                          Text("address"),
                          // SizedBox(
                          //   width: width / 10,
                          // ),
                          IconButton(
                              icon: Icon(Icons.departure_board_rounded,
                                  color: grey),
                              onPressed: () {}),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
