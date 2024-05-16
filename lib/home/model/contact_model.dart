class ContactModel{
  final String id;
  final String name;
  final String contact;
  final String url;

  ContactModel({
    required this.url, required this.id, required this.name, required this.contact
});
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      contact: json['Contacts'],
      url: json['url'],
    );
  }
}