# İşaret Dili Tercümanı

Bu proje, işaret dilini öğrenmek isteyenler için geliştirilmiş bir Flutter uygulamasıdır.

## Gereksinimler

- Flutter SDK (3.5.1 veya üzeri)
- Dart SDK (3.0.0 veya üzeri)
- Android Studio / VS Code
- Git

## Kurulum Adımları

1. Flutter SDK'yı yükleyin:
   ```bash
   git clone https://github.com/YUNUSEMREALSANCAK/sign-language-learning-app-with-object-detection-and-deep-learning
   ```

2. Flutter'ı PATH'e ekleyin:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```

3. Bağımlılıkları kontrol edin:
   ```bash
   flutter doctor
   ```

4. Projeyi klonlayın:
   ```bash
   git clone [PROJE_URL]
   cd isaretdilitercumaniprojesi
   ```

5. .env dosyasını oluşturun:
   ```bash
   cp .env.example .env
   ```
   Ve gerekli API anahtarlarını ekleyin.

6. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

## Bağımlılıklar

Projenin çalışması için gerekli olan paketler:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  lottie: ^3.1.2
  concentric_transition: ^1.0.1+1
  bubble_tab_indicator: ^0.1.6
  font_awesome_flutter: ^10.7.0
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  video_player: ^2.9.2
  animated_bottom_navigation_bar: ^1.3.3
  shared_preferences: ^2.3.3
  intl: ^0.19.0
  get: ^4.6.6
  permission_handler: ^11.1.0
  tflite_v2: ^1.0.0
  image_picker: ^1.0.4
  flutter_dotenv: ^5.1.0
  http: ^1.1.2
```

## Önemli Notlar

1. Firebase kurulumu:
   - Firebase Console'dan yeni bir proje oluşturun
   - Android ve iOS platformları için gerekli yapılandırmaları ekleyin
   - google-services.json dosyasını android/app/ klasörüne ekleyin

2. TensorFlow Lite modeli:
   - assets/model_unquant.tflite
   - assets/labels.txt
   dosyalarının varlığından emin olun

3. API Anahtarları:
   - .env dosyasında gerekli API anahtarlarını tanımlayın

## Klasör Yapısı

```
lib/
├── core/
│   ├── constants/
│   ├── init/
│   └── base/
├── features/
│   ├── auth/
│   ├── cards/
│   ├── camera/
│   └── quiz/
└── main.dart
```

## Çalıştırma

```bash
flutter run
```

## Hata Ayıklama

Eğer kurulum sırasında sorun yaşarsanız:

1. Bağımlılıkları temizleyin:
   ```bash
   flutter clean
   ```

2. Pub cache'i temizleyin:
   ```bash
   flutter pub cache repair
   ```

3. Bağımlılıkları yeniden yükleyin:
   ```bash
   flutter pub get
   ```

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
