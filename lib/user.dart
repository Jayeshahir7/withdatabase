import 'package:flutter/material.dart';
import 'package:withdatabase/insert.dart';

import 'data.dart';

class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  database db = database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Userpage"),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder(
        future: db.copyPasteAssetFileToRoot(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            return FutureBuilder(
              future: db.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return insert(
                              map: snapshot.data![index]);
                            },
                          )).then((value) {
                            setState(() {});
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                snapshot.data![index]['name'].toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data![index]['spi'].toString(),
                                style: TextStyle(fontSize: 25),),
                            ),
                            IconButton(
                              onPressed: () {
                                db.daleteData(int.parse(
                                    "${snapshot.data![index]['id']}"))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            )
                          ],
                        ),

                      );
                    },
                  );
                } else {
                  return Text("no user found");
                }
              },
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return insert();
        })).then((value) {
          setState(() {});
        });
      },
        child: Icon(Icons.add),
      ),
    );
  }
}
