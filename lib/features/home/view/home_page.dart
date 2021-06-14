import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_example/features/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Emotion'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.camera_alt),
      ),
      body: GetBuilder<HomeController>(
        init: _homeController,
        initState: (_) async {
          await _homeController.loadCamera();
          _homeController.startImageStream();
        },
        builder: (_) {
          return Container(
            child: Column(
              children: [
                _.cameraController != null &&
                        _.cameraController!.value.isInitialized
                    ? Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: CameraPreview(_.cameraController!))
                    : Center(child: Text('loading')),
                SizedBox(height: 15),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 200,
                    height: 200,
                    color: Colors.white,
                    child: Image.asset(
                      'images/${_.faceAtMoment}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  '${_.label}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
