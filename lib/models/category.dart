class Category{
  var id;
  String name;
  Category({this.id,this.name});


  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name":name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> item) {
    return Category(
      id: item['_id'],
     name: item['name'],
    );
  }
}