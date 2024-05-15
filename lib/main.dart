import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/new_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<NewData> dataa = [];

  Future<List<NewData>> getData() async {
    var data =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var jsonData = jsonDecode(data.body.toString());
    if(data.statusCode==200){
      for(Map i in jsonData){
        dataa.add(NewData.fromJson(i as Map<String,dynamic>));
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
              title: const Text(
                'API Response',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                              leading: Image.network(dataa[index].url.toString()),
                              title: Text(dataa[index].title.toString()),
                              subtitle: Text(dataa[index].thumbnailUrl.toString()),
                            );
                          });
                      }
                    }))
              ],
            )));
  }
}
