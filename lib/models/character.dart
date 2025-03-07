// TODO: 1st create class for your json response
class Character {
  const Character({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
  });
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
    );
  }

  static const defaultValue = Character(
    id: 0,
    firstName: '',
    lastName: '',
    imageUrl: '',
  );

  @override
  String toString() {
    return 'Character(id: $id, firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl)';
  }
}
