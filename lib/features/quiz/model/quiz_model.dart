class QuizModel {
  final String id;
  final String question;
  final String correctAnswer;
  final List<String> options;
  final String gifUrl;
  final String category;

  QuizModel({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.options,
    required this.gifUrl,
    required this.category,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      correctAnswer: json['correct_answer'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      gifUrl: json['gif_url'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'correct_answer': correctAnswer,
      'options': options,
      'gif_url': gifUrl,
      'category': category,
    };
  }
}
