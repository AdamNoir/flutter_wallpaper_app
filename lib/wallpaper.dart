import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/full_screen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});


  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  // Mapa donde se almacena la respuesta
  late Map result;
  List? images = [];
  int page = 1;

    //Llamar a la Api usando HTTP
  fetchApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
    headers: {
      'Authorization': 'P9l5eI7bEOFlcCIVsAjFv20xJbwdOQO7cllqStar8XuslaiB3kOGxSHH'
    }).then((value) => {
      result = jsonDecode(value.body),
      setState(() => {
        images = result['photos']
      }),
    });
  }

  // Mostrar mas Elementos
  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=${page.toString()}';
    
    await http.get(Uri.parse(url),
    headers: {
      'Authorization': 'P9l5eI7bEOFlcCIVsAjFv20xJbwdOQO7cllqStar8XuslaiB3kOGxSHH'
    }).then((value) => {
      result = jsonDecode(value.body),
      setState(() {
      images?.addAll(result['photos']);
    })
    });
  }

    // Init state
  @override
  void initState(){
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2/3,
                  mainAxisSpacing: 2
                ),
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>FullScreen(
                          imageUrl: images?[index]['src']['large2x']
                        )
                      ));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(images?[index]['src']['tiny'],
                      fit: BoxFit.cover,),
                    ),
                  );
                },
              ),
            )
          ),
          InkWell(
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: TextButton(
                onPressed: (){
                  loadMore();
                },
                child: const Center(
                  child: Text("Load More",
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}