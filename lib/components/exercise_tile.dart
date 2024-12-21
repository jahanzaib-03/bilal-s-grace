import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          onCheckBoxChanged!(!isCompleted), // Toggle the checkbox on tap
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isCompleted ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Name
            Text(
              exerciseName.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 8.0),
            // Black Ovals for Weight, Reps, Sets
            Row(
              children: [
                _buildBlackOval("${weight}kg"),
                const SizedBox(width: 8.0),
                _buildBlackOval("$reps reps"),
                const SizedBox(width: 8.0),
                _buildBlackOval("$sets sets"),
              ],
            ),
            const SizedBox(height: 8.0),
            // Checkbox (trailing)
            Align(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: isCompleted,
                onChanged: onCheckBoxChanged,
                activeColor: Colors.white,
                checkColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for black ovals
  Widget _buildBlackOval(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
