import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../model/gif_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CardsViewModel extends GetxController {
  final RxList<GifModel> _gifs = <GifModel>[].obs;
  final RxList<String> _tags = <String>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _selectedTag = ''.obs;

  List<GifModel> get gifs => _gifs;
  List<String> get tags => _tags;
  bool get isLoading => _isLoading.value;
  String get selectedTag => _selectedTag.value;

  @override
  void onInit() {
    super.onInit();
    loadTags();
  }

  Future<void> loadTags() async {
    try {
      _isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppConstants.tagListEndpoint),
        headers: {'Authorization': dotenv.env['ISARETCE_API_KEY'] ?? ''},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _tags.value = data.map((tag) => tag.toString()).toList();
        if (_tags.isNotEmpty) {
          await loadGifsByTag(_tags[0]);
        }
      }
    } catch (e) {
      print('Tag listesi yüklenirken hata: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadGifsByTag(String tag) async {
    try {
      _isLoading.value = true;
      _selectedTag.value = tag;

      final response = await http.get(
        Uri.parse('${AppConstants.postListEndpoint}?tag=$tag'),
        headers: {'Authorization': dotenv.env['ISARETCE_API_KEY'] ?? ''},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _gifs.value = data.map((json) => GifModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('GIF\'ler yüklenirken hata: $e');
    } finally {
      _isLoading.value = false;
    }
  }
}
