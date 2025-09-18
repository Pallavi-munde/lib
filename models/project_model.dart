class ProjectModel {
  final String id;
  final String name;
  final String description;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}


