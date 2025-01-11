import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/quiz_model.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';

class QuizViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<QuizModel> _quizzes = <QuizModel>[].obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxMap<String, dynamic> _statistics = <String, dynamic>{}.obs;
  final RxBool _isLoading = false.obs;

  List<QuizModel> get quizzes => _quizzes;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  Map<String, dynamic> get statistics => _statistics;
  bool get isLoading => _isLoading.value;

  late final AuthViewModel _authViewModel;

  @override
  void onInit() {
    super.onInit();
    _authViewModel = Get.find<AuthViewModel>();
    loadQuizzes();
    loadStatistics();
  }

  String? get _userId => _authViewModel.user?.uid;

  Future<void> loadQuizzes() async {
    try {
      _isLoading.value = true;
      final querySnapshot = await _firestore.collection('quizzes').get();
      _quizzes.value = querySnapshot.docs
          .map((doc) => QuizModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Quiz yüklenirken hata: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadStatistics() async {
    if (_userId == null) return;

    try {
      final doc = await _firestore.collection('statistics').doc(_userId).get();
      if (doc.exists) {
        _statistics.value = doc.data() ?? {};
      }
    } catch (e) {
      print('İstatistikler yüklenirken hata: $e');
    }
  }

  void answerQuestion(String answer) {
    if (_currentQuestionIndex.value < _quizzes.length) {
      final currentQuiz = _quizzes[_currentQuestionIndex.value];
      if (currentQuiz.correctAnswer == answer) {
        _score.value++;
      }
      _currentQuestionIndex.value++;
      if (_currentQuestionIndex.value == _quizzes.length) {
        _saveStatistics();
      }
    }
  }

  Future<void> _saveStatistics() async {
    if (_userId == null) return;

    try {
      await _firestore.collection('statistics').doc(_userId).set({
        'totalQuizzes': FieldValue.increment(1),
        'totalScore': FieldValue.increment(_score.value),
        'lastQuizDate': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('İstatistikler kaydedilirken hata: $e');
    }
  }

  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
  }
}
