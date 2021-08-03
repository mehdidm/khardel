class Role{
  var id;
  String name;

  Role(
      {this.id,
        this.name

      });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
     "name": name,
    };
  }
  factory Role.fromJson(Map<String, dynamic> item) {
    return Role(
      id: item['id'],
      name: item['name'],
    );
  }
}