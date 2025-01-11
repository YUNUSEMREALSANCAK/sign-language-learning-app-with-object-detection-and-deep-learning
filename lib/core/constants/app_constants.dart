class AppConstants {
  static const String appName = 'İşaret Dili Tercümanı';

  // API Endpoints
  static const String baseUrl = 'https://isaretce.com/wp-json/wl/v1';
  static const String tagListEndpoint = '$baseUrl/tag-list';
  static const String postListEndpoint = '$baseUrl/post-list';

  // Asset Paths
  static const String modelPath = 'assets/model_unquant.tflite';
  static const String labelsPath = 'assets/labels.txt';

  // Route Names
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String cameraRoute = '/camera';
  static const String quizRoute = '/quiz';
  static const String cardsRoute = '/cards';
}
