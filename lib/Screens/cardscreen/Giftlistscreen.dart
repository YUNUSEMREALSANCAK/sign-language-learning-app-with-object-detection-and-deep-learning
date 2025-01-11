import 'package:flutter/material.dart';

import '../../variables.dart';

class GifListPage extends StatelessWidget {
  final String category;
  final List<String> gifs;

  const GifListPage({
    super.key,
    required this.category,
    required this.gifs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.colorPage1,
        title: Text(category),
      ),
      body: gifs.isEmpty
          ? const Center(
              child: Text('Bu kategoride henüz gif bulunmamaktadır.'),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [CustomTheme.colorPage1, CustomTheme.colorPage3],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Yatayda 2 gif
                  childAspectRatio: 0.85, // Gif boyut oranı
                  crossAxisSpacing: 8.0, // Yatay boşluk
                  mainAxisSpacing: 8.0, // Dikey boşluk
                ),
                itemCount: gifs.length,
                itemBuilder: (context, index) {
                  final gifPath = gifs[index];
                  final gifName = gifPath.split('/').last.split('.').first;
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: CustomTheme.secondaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                gifPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              gifName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: CustomTheme.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
