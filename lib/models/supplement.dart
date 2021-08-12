class Supplement{
  var id;
  String title;
  Supplement({this.id,this.title});


  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title":title,
    };
  }

  factory Supplement.fromJson(Map<String, dynamic> item) {
    return Supplement(
      id: item['_id'],
      title: item['title'],
    );
  }
}