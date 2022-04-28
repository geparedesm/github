class BranchesModel {
  final String name;

  const BranchesModel({
    required this.name,
  });

  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
      name: json['name'],
    );
  }
}
