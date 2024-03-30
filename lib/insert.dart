import 'package:flutter/material.dart';
import 'package:withdatabase/data.dart';

class insert extends StatefulWidget {
  insert({super.key, this.map});
  Map? map;

  @override
  State<insert> createState() => _insertState();
}

class _insertState extends State<insert> {
  TextEditingController namecontroller =TextEditingController();
  TextEditingController spicontroller =TextEditingController();
  database db=database();


  void initState(){
    super.initState();
    namecontroller.text=widget.map?['name']==null? "":widget.map!['name'];
    spicontroller.text = widget.map?['cpi'] == null ? "" : widget.map!['cpi'].toString();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insert and Update")),

      body: Column(
        children: [
          TextFormField(
            controller: namecontroller,
          ),
          TextFormField(
            controller: spicontroller,
          ),
          ElevatedButton(onPressed: (){
            if(widget.map==null)
              {
                db.insertData(name:namecontroller.text,spi: spicontroller.text).then((value) {
                  Navigator.pop(context);
                });
              }
            else{
              db.updateDate(name: namecontroller.text,spi: spicontroller.text,id: widget.map!['id'],).then((value){
                Navigator.pop(context);
              });
            }
          }, child: Text("Subit"))
        ],
      ),
    );
  }
}
