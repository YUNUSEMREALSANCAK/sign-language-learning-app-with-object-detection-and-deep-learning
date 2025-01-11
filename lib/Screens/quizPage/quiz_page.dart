import 'package:flutter/material.dart';
import '../../variables.dart';
import 'quiz_viewmodel.dart';

class QuizPage extends StatefulWidget {
  final QuizViewModel quizViewModel;

  const QuizPage({
    super.key,
    required this.quizViewModel,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Image? _currentGif;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  Future<void> _initializeQuiz() async {
    await _loadNewQuestion();
  }

  Future<void> _loadNewQuestion() async {
    setState(() {
      _isLoading = true;
    });

    await widget.quizViewModel.loadNewQuestion();
    await _loadGif();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadGif() async {
    final gifFile = widget.quizViewModel.currentQuiz?.gifFile;
    if (gifFile != null) {
      print('Gif yükleniyor: $gifFile');
      setState(() {
        _currentGif = Image.asset(
          gifFile,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            print('Gif yükleme hatası: $error');
            print('Hata ayrıntıları: $stackTrace');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Gif yüklenemedi: $gifFile',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          },
        );
      });
    }
  }

  void _handleAnswerSelection(String answer) {
    setState(() {
      widget.quizViewModel.selectAnswer(answer);
    });

    if (widget.quizViewModel.isAnswerCorrect()) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        await _loadNewQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = widget.quizViewModel.currentQuiz;
    if (_isLoading || currentQuiz == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: CustomTheme.primaryGradient,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4, // Gif alanı için 4 birim
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _currentGif != null
                                ? _currentGif!
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Yukarıda gösterilen işaret hangi kelimeye karşılık gelir?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CustomTheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3, // Şıklar için 3 birim
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: currentQuiz.options.map((option) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: ElevatedButton(
                                  onPressed: widget.quizViewModel.answered &&
                                          widget.quizViewModel.selectedAnswer ==
                                              currentQuiz.correctAnswer
                                      ? null
                                      : () => _handleAnswerSelection(option),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.quizViewModel.answered &&
                                                option ==
                                                    currentQuiz.correctAnswer &&
                                                widget.quizViewModel
                                                        .selectedAnswer ==
                                                    currentQuiz.correctAnswer
                                            ? Colors.green
                                            : widget.quizViewModel.answered &&
                                                    option ==
                                                        widget.quizViewModel
                                                            .selectedAnswer
                                                ? Colors.red
                                                : CustomTheme.colorPage2,
                                    foregroundColor: CustomTheme.black,
                                    minimumSize: Size(double.infinity, 50),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    option,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
