import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/newmodel.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<Newmodel> dataa = [];

  Future<List<Newmodel>> getData() async{
    var data = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var jsonData = jsonDecode(data.body.toString());
    if(data.statusCode == 200){
      for(Map i in jsonData){
        dataa.add(Newmodel.fromJson(i as Map<String,dynamic>));
      }
      return dataa;
    }
    else{
      return dataa;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title:const Text('API Response',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getData(), 
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: dataa.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          leading: Text(dataa[index].id.toString(),style:const TextStyle(fontSize: 25),),
                          title: Text(dataa[index].title.toString(),style:const TextStyle(fontSize: 15)),
                          subtitle: Text(dataa[index].body.toString(),style:const TextStyle(fontSize: 10)),
                        );

                      });
                  }
                }))
          ],
        )
      )
    );
  }
}