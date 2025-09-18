class CarbonRecordModel {
  final String id;
  final String projectId;
  final double amountTons;
  final DateTime recordedAt;

  const CarbonRecordModel({
    required this.id,
    required this.projectId,
    required this.amountTons,
    required this.recordedAt,
  });

  factory CarbonRecordModel.fromJson(Map<String, dynamic> json) => CarbonRecordModel(
        id: json['id'] as String,
        projectId: json['projectId'] as String,
        amountTons: (json['amountTons'] as num).toDouble(),
        recordedAt: DateTime.parse(json['recordedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'amountTons': amountTons,
        'recordedAt': recordedAt.toIso8601String(),
      };
}


