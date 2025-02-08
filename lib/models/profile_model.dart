class ProfileModel {
  final String name;
  final String birthdate;
  final String bio;
  late final String image;

  ProfileModel({
    required this.name,
    required this.birthdate,
    required this.bio,
    required this.image,
  });

  // Add the copyWith method
  ProfileModel copyWith({
    String? name,
    String? birthdate,
    String? bio,
    String? image,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
      bio: bio ?? this.bio,
      image: image ?? this.image,
    );
  }

  // Add a method to convert ProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthdate': birthdate,
      'bio': bio,
      'image': image,
    };
  }

  // Add a factory constructor to create ProfileModel from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      birthdate: json['birthdate'],
      bio: json['bio'],
      image: json['image'],
    );
  }
}