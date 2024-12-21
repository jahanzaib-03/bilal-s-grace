import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:workout_tracker/components/heat_map.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text controller
  final newWorkoutNameController = TextEditingController();

  // Create new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Workout"),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: InputDecoration(hintText: "Enter workout name"),
        ),
        actions: [
          // Save button
          MaterialButton(
            onPressed: save,
            child: Text("Save"),
          ),
          // Cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // Go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  // Save workout
  void save() {
    // Get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // Add workout to WorkoutData list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // Pop dialog box
    Navigator.pop(context);
    clear();
  }

  // Cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // Clear controller
  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Workout Tracker'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          backgroundColor: Colors.black, // Black circle
          child: const Icon(
            Icons.add,
            color: Colors.white, // White "+" symbol
          ),
        ),
        body: ListView(
          children: [
            // Heatmap (commented out for now)
            // MyHeatMap(
            //     datasets: value.heatMapDataSet,
            //     startDateYYYYMMDD: value.getStartData()),

            // Workout List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) {
                var workout = value.getWorkoutList()[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black, // Black tile background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center, // Dumbbell icon
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          workout.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => goToWorkoutPage(workout.name),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
