import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/journal_cubit.dart';
import '../cubit/journal_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class JournalScreen extends StatefulWidget {
  JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _contentController = TextEditingController();
  int _moodScore = 5;
  bool _showForm = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _showForm = !_showForm),
        backgroundColor: AppColors.primary,
        child: Icon(_showForm ? Icons.close : Icons.edit),
      ),
      body: BlocConsumer<JournalCubit, JournalState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_) {
              if (_contentController.text.isNotEmpty) {
                _contentController.clear();
                setState(() {
                  _moodScore = 5;
                  _showForm = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Journal entry saved!'),
                    backgroundColor: AppColors.scoreGreen,
                  ),
                );
              }
            },
            error: (msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg))),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Write form
                if (_showForm) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('How are you feeling today?', style: AppTextStyles.h2),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('😞', style: TextStyle(fontSize: 24)),
                            Expanded(
                              child: Slider(
                                value: _moodScore.toDouble(),
                                min: 1,
                                max: 10,
                                divisions: 9,
                                label: _moodScore.toString(),
                                activeColor: AppColors.primary,
                                onChanged: (val) => setState(() => _moodScore = val.toInt()),
                              ),
                            ),
                            Text('😊', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _contentController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Write your reflections...',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            filled: true,
                            fillColor: AppColors.background,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 16),
                        state.maybeWhen(
                          loading: () => Center(child: CircularProgressIndicator()),
                          orElse: () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                if (_contentController.text.isNotEmpty) {
                                  context.read<JournalCubit>().saveEntry(_contentController.text, _moodScore);
                                }
                              },
                              child: Text('Save Entry', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],

                // Past entries
                Text('Past Entries', style: AppTextStyles.h2),
                SizedBox(height: 12),
                state.when(
                  initial: () => Center(child: CircularProgressIndicator()),
                  loading: () => _showForm
                      ? const SizedBox.shrink()
                      : Center(child: CircularProgressIndicator()),
                  error: (msg) => Center(child: Text(msg, style: TextStyle(color: AppColors.scoreRed))),
                  loaded: (entries) {
                    if (entries.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Icon(Icons.book_outlined, size: 64, color: Colors.grey.shade600),
                              SizedBox(height: 16),
                              Text('No journal entries yet', style: AppTextStyles.bodySecondary),
                              SizedBox(height: 8),
                              Text('Tap the ✏️ button to write your first entry!', style: AppTextStyles.bodySecondary),
                            ],
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: entries.map((entry) => Card(
                        color: AppColors.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      entry.date,
                                      style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                entry.content,
                                style: AppTextStyles.body,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
