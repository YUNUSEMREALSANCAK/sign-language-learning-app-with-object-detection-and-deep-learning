import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_model.dart';
import 'gif_service.dart';
import 'package:flutter/foundation.dart';


class QuizStatistics {
  final String questionName;
  final bool isCorrect;
  final String selectedAnswer;
  final String correctAnswer;
  final DateTime timestamp;

  QuizStatistics({
    required this.questionName,
    required this.isCorrect,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.timestamp,
  });

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() => {
        'questionName': questionName,
        'isCorrect': isCorrect,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
        'timestamp': timestamp.toIso8601String(),
      };

  // JSON'dan oluşturma
  factory QuizStatistics.fromJson(Map<String, dynamic> json) => QuizStatistics(
        questionName: json['questionName'],
        isCorrect: json['isCorrect'],
        selectedAnswer: json['selectedAnswer'],
        correctAnswer: json['correctAnswer'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

class QuizViewModel extends ChangeNotifier {
  final GifService _gifService = GifService();
  QuizModel? currentQuiz;
  bool answered = false;
  String? selectedAnswer;
  bool isQuizComplete = false;

  // İstatistikler için liste
  final List<QuizStatistics> statistics = [];
  int totalQuestions = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  QuizViewModel() {
    // Tüm kategorilerden 200 soru ayarla
    _gifService.setQuizParameters(
      category: 'all', // 'all' tüm kategorileri kullanır
      questionCount: 200,
    );
    // İstatistikleri yükle
    loadStatistics();
  }

  // İstatistikleri kaydet
  Future<void> saveStatistics() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // İstatistik listesini JSON'a dönüştür
      final statsList = statistics.map((stat) => stat.toJson()).toList();
      await prefs.setString('quiz_statistics', jsonEncode(statsList));

      // Sayısal değerleri kaydet
      await prefs.setInt('total_questions', totalQuestions);
      await prefs.setInt('correct_answers', correctAnswers);
      await prefs.setInt('wrong_answers', wrongAnswers);

      print('İstatistikler kaydedildi');
    } catch (e) {
      print('İstatistik kaydetme hatası: $e');
    }
  }

  // İstatistikleri yükle
  Future<void> loadStatistics() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // İstatistik listesini yükle
      final statsJson = prefs.getString('quiz_statistics');
      if (statsJson != null) {
        final List<dynamic> statsList = jsonDecode(statsJson);
        statistics.clear();
        statistics.addAll(
            statsList.map((json) => QuizStatistics.fromJson(json)).toList());
      }

      // Sayısal değerleri yükle
      totalQuestions = prefs.getInt('total_questions') ?? 0;
      correctAnswers = prefs.getInt('correct_answers') ?? 0;
      wrongAnswers = prefs.getInt('wrong_answers') ?? 0;

      notifyListeners();
      print('İstatistikler yüklendi');
    } catch (e) {
      print('İstatistik yükleme hatası: $e');
    }
  }

  // Yeni soru yükle
  Future<void> loadNewQuestion() async {
    try {
      if (!_gifService.hasRemainingQuestions()) {
        isQuizComplete = true;
        notifyListeners();
        return;
      }

      final gifFile = await _gifService.getRandomGif();
      // Debug için gif yolunu yazdır
      _gifService.printGifPath(gifFile);

      final correctAnswer = _gifService.getAnswerForGif(gifFile);
      final options = _gifService.getShuffledOptions(correctAnswer);

      currentQuiz = QuizModel(
        gifFile: gifFile,
        correctAnswer: correctAnswer,
        options: options,
      );
      answered = false;
      selectedAnswer = null;
      totalQuestions++;
      await saveStatistics(); // İstatistikleri kaydet
      notifyListeners();
    } catch (e) {
      print('Soru yükleme hatası: $e');
    }
  }

  // Şık seçimi
  void selectAnswer(String answer) {
    selectedAnswer = answer;
    answered = true;

    // İstatistikleri güncelle
    if (currentQuiz != null) {
      final isCorrect = answer == currentQuiz!.correctAnswer;
      if (isCorrect) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }

      // İstatistiklere ekle
      statistics.add(QuizStatistics(
        questionName: _getQuestionNameFromPath(currentQuiz!.gifFile),
        isCorrect: isCorrect,
        selectedAnswer: answer,
        correctAnswer: currentQuiz!.correctAnswer,
        timestamp: DateTime.now(),
      ));

      saveStatistics(); // İstatistikleri kaydet
      notifyListeners();
    }
  }

  // Gif dosya yolundan soru adını çıkar
  String _getQuestionNameFromPath(String path) {
    final parts = path.split('/');
    final category = parts[parts.length - 2].replaceAll('downloaded_gifs_', '');
    final questionName = parts.last.replaceAll('.gif', '');
    return '$category/$questionName';
  }

  bool isAnswerCorrect() {
    return selectedAnswer == currentQuiz?.correctAnswer;
  }

  // İstatistik metodları
  double getSuccessRate() {
    if (totalQuestions == 0) return 0;
    return (correctAnswers / totalQuestions) * 100;
  }

  List<QuizStatistics> getLastAnswers({int count = 10}) {
    return statistics.reversed.take(count).toList();
  }

  Map<String, List<QuizStatistics>> getStatisticsByCategory() {
    Map<String, List<QuizStatistics>> categoryStats = {};

    for (var stat in statistics) {
      final category = stat.questionName.split('/')[0];
      categoryStats.putIfAbsent(category, () => []);
      categoryStats[category]!.add(stat);
    }

    return categoryStats;
  }
}
