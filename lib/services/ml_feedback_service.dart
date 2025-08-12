import '../models/step_data.dart';
import '../models/diet_log.dart';

class MLFeedbackService {
  String getFeedback(List<StepData> steps, List<DietLog> diets) {
    if (steps.isEmpty || diets.isEmpty) return "No data available.";

    final totalSteps = steps.map((e) => e.stepsCount ?? 0).reduce((a, b) => a + b);
    final totalCalories = diets.map((e) => e.calories ?? 0).reduce((a, b) => a + b);

    if (totalSteps < 5000 && totalCalories > 2000) {
      return "Reduce calorie intake and increase steps to 5000+!";
    } else if (totalSteps >= 10000 && totalCalories < 1500) {
      return "Great progress! Consider adding more calories for energy.";
    }
    return "You're on track! Keep it up!";
  }
}