class UserModel {
  final String name;
  final String time;

  UserModel({
    required this.name,
    required this.time,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      time: json['time'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': time,
    };
  }
}
