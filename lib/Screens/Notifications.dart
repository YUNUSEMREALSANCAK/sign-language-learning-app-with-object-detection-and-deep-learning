import 'package:flutter/material.dart';
import '../variables.dart';
import 'quizPage/quiz_viewmodel.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomTheme.colorPage1, CustomTheme.colorPage2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'Search Page',
          style: TextStyle(fontSize: 24, color: CustomTheme.black),
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  final QuizViewModel quizViewModel;

  const NotificationsPage({super.key, required this.quizViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: CustomTheme.primaryGradient,
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Card(
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
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(
                        'Toplam Soru',
                        quizViewModel.totalQuestions.toString(),
                        Icons.question_answer,
                      ),
                      _buildStatCard(
                        'Doğru',
                        quizViewModel.correctAnswers.toString(),
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      _buildStatCard(
                        'Yanlış',
                        quizViewModel.wrongAnswers.toString(),
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      _buildStatCard(
                        'Başarı',
                        '${quizViewModel.getSuccessRate().toStringAsFixed(1)}%',
                        Icons.trending_up,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TabBar(
              labelColor: CustomTheme.black,
              unselectedLabelColor: CustomTheme.black.withOpacity(0.5),
              indicatorColor: CustomTheme.black,
              tabs: const [
                Tab(text: 'Son Cevaplar'),
                Tab(text: 'Kategoriler'),
                Tab(text: 'Yanlışlar'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildLastAnswersTab(),
                  _buildCategoriesTab(),
                  _buildWrongAnswersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      {Color? color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: color ?? CustomTheme.black),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? CustomTheme.black,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: CustomTheme.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildLastAnswersTab() {
    final lastAnswers = quizViewModel.getLastAnswers(count: 20);
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: lastAnswers.length,
      itemBuilder: (context, index) {
        final stat = lastAnswers[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomTheme.secondaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                stat.isCorrect ? Icons.check_circle : Icons.cancel,
                color: stat.isCorrect ? Colors.green : Colors.red,
              ),
              title: Text(
                stat.questionName,
                style: const TextStyle(color: CustomTheme.black),
              ),
              subtitle: Text(
                'Cevabınız: ${stat.selectedAnswer}\n'
                'Doğru Cevap: ${stat.correctAnswer}',
                style: TextStyle(color: CustomTheme.black.withOpacity(0.7)),
              ),
              trailing: Text(
                DateFormat('HH:mm').format(stat.timestamp),
                style: TextStyle(
                  color: CustomTheme.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesTab() {
    final categoryStats = quizViewModel.getStatisticsByCategory();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: categoryStats.length,
      itemBuilder: (context, index) {
        final category = categoryStats.keys.elementAt(index);
        final stats = categoryStats[category]!;
        final correctCount = stats.where((s) => s.isCorrect).length;
        final successRate =
            (correctCount / stats.length * 100).toStringAsFixed(1);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomTheme.secondaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              title: Text(
                category.toUpperCase(),
                style: const TextStyle(
                  color: CustomTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Başarı: $successRate% (${correctCount}/${stats.length})',
                style: TextStyle(
                  color: CustomTheme.black.withOpacity(0.7),
                ),
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: CustomTheme.primaryGradient,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stats.length,
                    itemBuilder: (context, i) {
                      final stat = stats[i];
                      return ListTile(
                        leading: Icon(
                          stat.isCorrect ? Icons.check_circle : Icons.cancel,
                          color: stat.isCorrect ? Colors.green : Colors.red,
                        ),
                        title: Text(
                          stat.questionName.split('/')[1],
                          style: const TextStyle(color: CustomTheme.black),
                        ),
                        subtitle: Text(
                          'Cevabınız: ${stat.selectedAnswer}\n'
                          'Doğru Cevap: ${stat.correctAnswer}',
                          style: TextStyle(
                            color: CustomTheme.black.withOpacity(0.7),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWrongAnswersTab() {
    final wrongAnswers =
        quizViewModel.statistics.where((s) => !s.isCorrect).toList();
    wrongAnswers.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: wrongAnswers.length,
      itemBuilder: (context, index) {
        final stat = wrongAnswers[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomTheme.secondaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: Text(
                stat.questionName,
                style: const TextStyle(color: CustomTheme.black),
              ),
              subtitle: Text(
                'Yanlış Cevap: ${stat.selectedAnswer}\n'
                'Doğru Cevap: ${stat.correctAnswer}',
                style: TextStyle(color: CustomTheme.black.withOpacity(0.7)),
              ),
              trailing: Text(
                DateFormat('dd/MM HH:mm').format(stat.timestamp),
                style: TextStyle(
                  color: CustomTheme.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
