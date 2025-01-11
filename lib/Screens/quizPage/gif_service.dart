import 'dart:math';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class GifService {
  final List<String> _gifFolders = [
    'downloaded_gifs_aile',
    'downloaded_gifs_anatomi',
    'downloaded_gifs_aracgerec',
    'downloaded_gifs_cografya',
    'downloaded_gifs_dini',
    'downloaded_gifs_diyalog',
    'downloaded_gifs_duygu',
    'downloaded_gifs_hayvan',
    'downloaded_gifs_matematik',
    'downloaded_gifs_spor',
    'downloaded_gifs_teknoloji',
    'downloaded_gifs_zamir',
    'downloaded_gifs_zaman',
    'downloaded_gifs_ulke_kita',
    'downloaded_gifs_tip_saglik',
    'downloaded_gifs_sifat',
  ];

  String _selectedCategory = 'all'; // Varsayılan olarak tüm kategoriler
  int _remainingQuestions = 200; // Varsayılan soru sayısı

  // Kategori ve soru sayısını ayarla
  void setQuizParameters({String category = 'all', int questionCount = 200}) {
    _selectedCategory = category;
    _remainingQuestions = questionCount;
  }

  // Kalan soru sayısını kontrol et
  bool hasRemainingQuestions() {
    return _remainingQuestions > 0;
  }

  final Map<String, List<String>> _gifFiles = {
    'downloaded_gifs_aile': [
      'agabey.gif',
      'amca.gif',
      'anne.gif',
      'baba.gif',
      'bebek.gif',
      'buyukanne.gif',
      'buyukbaba.gif',
      'dayi.gif',
      'dede.gif',
      'erkekkardes.gif',
      'hala.gif',
      'kizkardes.gif',
      'kuzen.gif',
      'nine.gif',
      'teyze.gif',
      'yenge.gif'
    ],
    'downloaded_gifs_anatomi': [
      'agiz.gif',
      'ayak.gif',
      'bacak.gif',
      'bas.gif',
      'beyin.gif',
      'bogaz.gif',
      'burun.gif',
      'dil.gif',
      'dis.gif',
      'dudak.gif',
      'el.gif',
      'goz.gif',
      'kafa.gif',
      'kalp.gif',
      'karin.gif',
      'kemik.gif',
      'kol.gif',
      'kulak.gif',
      'mide.gif',
      'parmak.gif',
      'sac.gif',
      'sirt.gif',
      'yuz.gif'
    ],
    'downloaded_gifs_aracgerec': [
      'araba.gif',
      'bilgisayar.gif',
      'canta.gif',
      'dolap.gif',
      'kalem.gif',
      'koltuk.gif',
      'lamba.gif',
      'masa.gif',
      'makas.gif',
      'sandalye.gif',
      'saat.gif',
      'silgi.gif',
      'telefon.gif',
      'televizyon.gif',
      'yatak.gif'
    ],
    'downloaded_gifs_cografya': [
      'ada.gif',
      'dag.gif',
      'deniz.gif',
      'dere.gif',
      'gol.gif',
      'nehir.gif',
      'orman.gif',
      'ova.gif',
      'plaj.gif',
      'tepe.gif',
      'vadi.gif',
      'yol.gif'
    ],
    'downloaded_gifs_dini': [
      'abdest.gif',
      'allah.gif',
      'camii.gif',
      'cennet.gif',
      'cehennem.gif',
      'dua.gif',
      'ezan.gif',
      'hac.gif',
      'imam.gif',
      'kuran.gif',
      'melek.gif',
      'namaz.gif',
      'oruc.gif',
      'secde.gif',
      'tesbih.gif'
    ],
    'downloaded_gifs_diyalog': [
      'afiyet.gif',
      'anliyorum.gif',
      'evet.gif',
      'gunaydin.gif',
      'hayir.gif',
      'hosgeldin.gif',
      'iyiaksamlar.gif',
      'iyigeceler.gif',
      'iyigunler.gif',
      'lutfen.gif',
      'merhaba.gif',
      'nasilsin.gif',
      'rica.gif',
      'tesekkur.gif',
      'tamam.gif',
      'gorusuruz.gif'
    ],
    'downloaded_gifs_duygu': [
      'aci.gif',
      'aglama.gif',
      'ask.gif',
      'gulme.gif',
      'heyecan.gif',
      'korku.gif',
      'mutlu.gif',
      'nefret.gif',
      'ofke.gif',
      'saskin.gif',
      'sevgi.gif',
      'sikinti.gif',
      'stres.gif',
      'uzgun.gif',
      'yorgun.gif'
    ],
    'downloaded_gifs_hayvan': [
      'ayi.gif',
      'balik.gif',
      'fil.gif',
      'horoz.gif',
      'inek.gif',
      'kedi.gif',
      'kopek.gif',
      'koyun.gif',
      'kus.gif',
      'tavsan.gif',
      'tavuk.gif',
      'timsah.gif',
      'yilan.gif',
      'zebra.gif',
      'zurafa.gif'
    ],
    'downloaded_gifs_matematik': [
      'arti.gif',
      'bir.gif',
      'bes.gif',
      'carpma.gif',
      'cikarma.gif',
      'dort.gif',
      'iki.gif',
      'sifir.gif',
      'uc.gif',
      'yedi.gif',
      'alti.gif',
      'sekiz.gif',
      'dokuz.gif',
      'on.gif',
      'yuz.gif',
      'bin.gif',
      'milyon.gif',
      'esittir.gif',
      'bolme.gif'
    ],
    'downloaded_gifs_spor': [
      'basketbol.gif',
      'futbol.gif',
      'voleybol.gif',
      'tenis.gif',
      'yuzme.gif',
      'kosma.gif',
      'bisiklet.gif',
      'boks.gif',
      'gures.gif',
      'jimnastik.gif',
      'kayak.gif',
      'masa_tenisi.gif'
    ],
    'downloaded_gifs_teknoloji': [
      'bilgisayar.gif',
      'internet.gif',
      'klavye.gif',
      'mouse.gif',
      'tablet.gif',
      'telefon.gif',
      'yazici.gif',
      'ekran.gif',
      'hoparlor.gif',
      'kamera.gif',
      'sarj.gif',
      'wifi.gif'
    ],
    'downloaded_gifs_zamir': [
      'ben.gif',
      'sen.gif',
      'o.gif',
      'biz.gif',
      'siz.gif',
      'onlar.gif',
      'bu.gif',
      'su.gif',
      'kim.gif',
      'ne.gif',
      'hangi.gif',
      'kendi.gif'
    ],
    'downloaded_gifs_zaman': [
      'aksam.gif',
      'bugun.gif',
      'dun.gif',
      'yarin.gif',
      'simdi.gif',
      'sabah.gif',
      'gece.gif',
      'gunduz.gif',
      'ogle.gif',
      'hafta.gif',
      'ay.gif',
      'yil.gif',
      'mevsim.gif',
      'ilkbahar.gif',
      'yaz.gif',
      'sonbahar.gif',
      'kis.gif'
    ],
    'downloaded_gifs_ulke_kita': [
      'afrika.gif',
      'almanya.gif',
      'amerika.gif',
      'avrupa.gif',
      'asya.gif',
      'avustralya.gif',
      'fransa.gif',
      'ingiltere.gif',
      'italya.gif',
      'japonya.gif',
      'kanada.gif',
      'rusya.gif',
      'turkiye.gif',
      'yunanistan.gif'
    ],
    'downloaded_gifs_tip_saglik': [
      'agri.gif',
      'ates.gif',
      'doktor.gif',
      'grip.gif',
      'hastane.gif',
      'ilac.gif',
      'nobetci.gif',
      'recete.gif',
      'ambulans.gif',
      'asi.gif',
      'hasta.gif',
      'hemsire.gif',
      'kalp.gif',
      'kan.gif',
      'tansiyon.gif'
    ],
    'downloaded_gifs_sifat': [
      'ac.gif',
      'acik.gif',
      'agir.gif',
      'alcak.gif',
      'beyaz.gif',
      'buyuk.gif',
      'dar.gif',
      'derin.gif',
      'dolu.gif',
      'eski.gif',
      'genc.gif',
      'genis.gif',
      'guzel.gif',
      'hafif.gif',
      'hizli.gif',
      'iyi.gif',
      'kaba.gif',
      'kalin.gif',
      'kapali.gif',
      'kara.gif',
      'karanlik.gif',
      'kirmizi.gif',
      'kisa.gif',
      'kotu.gif',
      'kucuk.gif',
      'mavi.gif',
      'mor.gif',
      'pembe.gif',
      'sari.gif',
      'sert.gif',
      'sicak.gif',
      'siyah.gif',
      'soguk.gif',
      'tatli.gif',
      'tok.gif',
      'uzak.gif',
      'uzun.gif',
      'yeni.gif',
      'yesil.gif',
      'yasli.gif',
      'yavas.gif',
      'yakin.gif',
      'yumusak.gif',
      'zayif.gif',
      'zor.gif'
    ]
  };

  final Random _random = Random();
  final Set<String> _verifiedGifs = {};
  final Set<String> _failedGifs = {};
  final Set<String> _usedGifs = {};

  // Gif dosyasının varlığını kontrol et
  Future<bool> _verifyGifExists(String path) async {
    if (_verifiedGifs.contains(path)) return true;
    if (_failedGifs.contains(path)) return false;

    try {
      final ByteData data = await rootBundle.load(path);
      if (data.lengthInBytes > 0) {
        _verifiedGifs.add(path);
        print('Gif doğrulandı: $path');
        return true;
      }
      _failedGifs.add(path);
      print('Gif yüklenemedi (boş dosya): $path');
      return false;
    } catch (e) {
      _failedGifs.add(path);
      print('Gif bulunamadı: $path - Hata: $e');
      return false;
    }
  }

  // Rastgele bir gif dosyası seç
  Future<String> getRandomGif() async {
    if (!hasRemainingQuestions()) {
      throw Exception('Tüm sorular tamamlandı!');
    }

    List<String> gifList;
    String folder;

    if (_selectedCategory == 'all') {
      // Tüm kategorilerden rastgele seç
      folder = _gifFolders[_random.nextInt(_gifFolders.length)];
      gifList = _gifFiles[folder]!;
    } else {
      folder = _selectedCategory;
      gifList = _gifFiles[_selectedCategory]!;
    }

    final availableGifs =
        gifList.where((gif) => !_usedGifs.contains('$folder/$gif')).toList();

    if (availableGifs.isEmpty) {
      _usedGifs.clear();
      print('Tüm gifler kullanıldı, liste yenileniyor...');
    }

    // En fazla 20 deneme yap
    for (int i = 0; i < 20; i++) {
      final gifFile = availableGifs.isEmpty
          ? gifList[_random.nextInt(gifList.length)]
          : availableGifs[_random.nextInt(availableGifs.length)];

      final path = 'assets/$folder/$gifFile';

      if (await _verifyGifExists(path)) {
        _usedGifs.add('$folder/$gifFile');
        _remainingQuestions--;
        return path;
      }
    }

    if (_verifiedGifs.isNotEmpty) {
      _remainingQuestions--;
      return _verifiedGifs.first;
    }

    throw Exception('Hiçbir gif dosyası yüklenemedi');
  }

  // Debug için gif yolunu yazdır
  void printGifPath(String path) {
    print('Yüklenen gif yolu: $path');
    print('Kalan soru sayısı: $_remainingQuestions');
  }

  // Gif dosyasının adından doğru cevabı çıkar
  String getAnswerForGif(String gifPath) {
    final fileName = gifPath.split('/').last;
    return fileName.replaceAll('.gif', '');
  }

  // Tüm gif dosyalarının listesini oluştur
  List<String> _getAllGifNames() {
    Set<String> allGifNames = {};

    if (_selectedCategory == 'all') {
      _gifFiles.forEach((folder, files) {
        for (var file in files) {
          allGifNames.add(file.replaceAll('.gif', ''));
        }
      });
    } else {
      final files = _gifFiles[_selectedCategory]!;
      for (var file in files) {
        allGifNames.add(file.replaceAll('.gif', ''));
      }
    }

    return allGifNames.toList();
  }

  // Karışık şıkları oluştur
  List<String> getShuffledOptions(String correctAnswer) {
    final allGifNames = _getAllGifNames()..remove(correctAnswer);
    allGifNames.shuffle();

    // 3 yanlış cevap al
    final options = allGifNames.take(3).toList();

    // Doğru cevabı rastgele bir konuma ekle
    options.insert(_random.nextInt(4), correctAnswer);
    return options;
  }
}
