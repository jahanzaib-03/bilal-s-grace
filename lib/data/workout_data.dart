import 'package:flutter/material.dart';
// import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
// import 'package:workout_tracker/datetime/date_time.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
/*
data structure for workout

-list containing diff workout
-workout name,and list of exercise 
*/

  List<Workout> workoutList = [
    //default workout
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
        )
      ],
    )
  ];

//get list of workout
  List<Workout> getWorkoutList() {
    return workoutList;
  }

//add workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

//add exercises to workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
//find relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
  }

  //check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //find relevant workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    //chexk off boolean to show completed
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

//get length of the workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

//return relevant workout object, given a workout name

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //return relevant exercise object,give workout name + exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant wprkout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // then find the relevant exercise in the workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
//   }

//     //get start date

    
// // String getStartData(){
// //   return db.getStartDaate{};
// // }
//     /*
    
    
//     heat map

//     */
// Map<DateTime>, int> HeatMapDataSet ={};
//     void loadHeatMap() {
//       DateTime startDate = createDateTimeObject(getStartDate());

//       // Count the number of days to load
//       int daysInBetween = DateTime.now().difference(startDate).inDays;

//       // Go from start date to today and add each completion status to the dataset
//       // "COMPLETION_STATUS_yyyymmdd" will be the key in the database
//       for (int i = 0; i < daysInBetween + 1; i++) {
//         // Generate date in yyyymmdd format
//         String yyyymmdd =
//             convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));

//         // Get completion status (0 or 1)
//         int completionStatus = db.getCompletionStatus(yyyymmdd);

//         // Extract year, month, and day
//         int year = startDate.add(Duration(days: i)).year;
//         int month = startDate.add(Duration(days: i)).month;
//         int day = startDate.add(Duration(days: i)).day;

//         // Create a map entry for the heatmap dataset
//         final percentForEachDay = <DateTime, int>{
//           DateTime(year, month, day): completionStatus,
//         };

//         // Add to the heatmap dataset
//         heatMapDataSet.addEntries(percentForEachDay.entries);
//       }
//     }
//   }
// }
