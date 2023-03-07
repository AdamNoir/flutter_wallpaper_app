import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;

  const FullScreen({super.key, required this.imageUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  // Funcion para setear el Wallpaper
  Future<void>setWallpaper() async {
    int location = WallpaperManagerFlutter.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    WallpaperManagerFlutter().setwallpaperfromFile(file, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageUrl),
              ),
            ),
            InkWell(
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: TextButton(
                onPressed: (){
                  setWallpaper();
                },
                child: const Center(
                  child: Text("Set Wallpaper",
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
}