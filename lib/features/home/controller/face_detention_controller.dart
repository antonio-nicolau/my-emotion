import 'package:google_ml_example/features/home/module/face_model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetetorController {
  FaceDetector? _faceDetector;

  Future<List<FaceModel>?> processImage(inputImage) async {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
      ),
    );

    final faces = await _faceDetector?.processImage(inputImage);
    return extractFaceInfo(faces);
  }

  List<FaceModel>? extractFaceInfo(List<Face>? faces) {
    List<FaceModel>? response = [];
    double? smile;
    double? leftYears;
    double? rightYears;

    for (Face face in faces!) {
      final rect = face.boundingBox;
      if (face.smilingProbability != null) {
        smile = face.smilingProbability;
      }

      leftYears = face.leftEyeOpenProbability;
      rightYears = face.rightEyeOpenProbability;

      final faceModel = FaceModel(
        smile: smile,
        leftYearsOpen: leftYears,
        rightYearsOpen: rightYears,
      );

      response.add(faceModel);
    }

    return response;
  }
}
