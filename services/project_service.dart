import '../models/project_model.dart';

class ProjectService {
  Future<List<ProjectModel>> fetchProjects() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return <ProjectModel>[
      const ProjectModel(id: 'p1', name: 'Forest Restoration', description: 'Replanting trees'),
      const ProjectModel(id: 'p2', name: 'Soil Carbon Sequestration', description: 'Regenerative agriculture'),
    ];
  }
}


