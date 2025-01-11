import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../../../core/constants/app_constants.dart';

class CameraViewModel extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RxString _imagePath = ''.obs;
  final RxString _result = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isModelLoaded = false.obs;

  String get imagePath => _imagePath.value;
  String get result => _result.value;
  bool get isLoading => _isLoading.value;
  bool get isModelLoaded => _isModelLoaded.value;

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  @override
  void onClose() {
    Tflite.close();
    super.onClose();
  }

  Future<void> loadModel() async {
    try {
      _isLoading.value = true;
      await Tflite.loadModel(
        model: AppConstants.modelPath,
        labels: AppConstants.labelsPath,
      );
      _isModelLoaded.value = true;
    } catch (e) {
      print('Model yüklenirken hata: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      _isLoading.value = true;
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _imagePath.value = image.path;
        await detectImage(File(image.path));
      }
    } catch (e) {
      print('Resim seçilirken hata: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> detectImage(File image) async {
    if (!_isModelLoaded.value) return;

    try {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        _result.value = recognitions[0]['label'].toString();
      }
    } catch (e) {
      print('Görüntü işlenirken hata: $e');
    }
  }
}
