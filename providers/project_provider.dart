import 'package:flutter/foundation.dart';
import '../models/project_model.dart';

class ProjectProvider extends ChangeNotifier {
  final List<ProjectModel> _projects = <ProjectModel>[];

  List<ProjectModel> get projects => List.unmodifiable(_projects);

  void addProject(ProjectModel project) {
    _projects.add(project);
    notifyListeners();
  }

  void clear() {
    _projects.clear();
    notifyListeners();
  }
}


