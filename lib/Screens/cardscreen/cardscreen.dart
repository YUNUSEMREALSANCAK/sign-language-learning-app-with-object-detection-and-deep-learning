import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isaretdilitercumaniprojesi/variables.dart';
import 'Giftlistscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Kategoriler ve gif dosyaları
  Future<Map<String, List<String>>> loadCategories() async {
    final Map<String, List<String>> categories = {
      'Aile': [],
      'Anatomi': [],
      'Araç Gereç': [],
      'Coğrafya': [],
      'Dini': [],
      'Diyalog': [],
      'Duygu': [],
      'Hayvan': [],
      'Matematik': [],
      'Spor': [],
    };

    // "Aile" kategorisi için GIF'leri yükle
    categories['Aile'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_aile/');
    categories['Anatomi'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_anatomi/');
    categories['Araç Gereç'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_aracgerec/');
    categories['Coğrafya'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_cografya/');
    categories['Dini'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_dini/');
    categories['Diyalog'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_diyalog/');
    categories['Duygu'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_duygu/');
    categories['Hayvan'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_hayvan/');
    categories['Matematik'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_matematik/');
    categories['Spor'] =
        await _loadAssetsFromFolder('assets/assets/downloaded_gifs_spor/');
    categories['Teknoloji'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_teknoloji/');
    categories['Zamir'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_zamir/');
    categories['Zaman'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_zaman/');
    categories['Ülkeler ve Kıtalar'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_ulke_kita/');
    categories['Tip Sağlık'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_tip_saglik/');
    categories['Sıfat'] =
        await _loadAssetsFromFolder('assets/downloaded_gifs_sifat/');

    return categories;
  }

  Future<List<String>> _loadAssetsFromFolder(String folderPath) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Belirtilen klasördeki dosyaları filtrele
    return manifestMap.keys
        .where((key) => key.startsWith(folderPath) && key.endsWith('.gif'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.colorPage1,
      body: FutureBuilder<Map<String, List<String>>>(
        future: loadCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu.'));
          }

          final categories = snapshot.data ?? {};
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomTheme.colorPage1, CustomTheme.colorPage3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: categories.keys.length,
              itemBuilder: (context, index) {
                final category = categories.keys.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    // Kategoriye tıklandığında
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GifListPage(
                          category: category,
                          gifs: categories[category]!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomTheme.colorPage2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
