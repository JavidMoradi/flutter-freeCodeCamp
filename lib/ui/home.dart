import 'package:crash_course/net/api_methods.dart';
import 'package:crash_course/net/flutterfire.dart';
import 'package:crash_course/ui/add_view.dart';
import 'package:crash_course/ui/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double bitcoin = 0.0;
  double dogecoin = 0.0;
  double litecoin = 0.0;

  @override
  @mustCallSuper
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    dogecoin = await getPrice("dogecoin");
    litecoin = await getPrice("litecoin");
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id) {
      if (id == "bitcoin") {
        return bitcoin;
      } else if (id == "dogecoin") {
        return dogecoin;
      } else if (id == "litecoin") {
        return litecoin;
      }
    }

    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Coin name ${document.id}"),
                              Text("Amount owned: ${document["Amount"]}"),
                              Text("Current value per ${document.id}: \$${getValue(document.id)}"),
                              Text("Total net: \$${document["Amount"] * getValue(document.id)}\n"),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddView(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.lightBlue,
            ),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              bool bExit = await logOut();

              if (bExit) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authentication(),
                  ),
                );
              }
            },
            child: Icon(
              Icons.ac_unit_rounded,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
