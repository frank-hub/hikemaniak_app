// hike.dart
class Hike {
  int? id;
  String? difficulty;
  String? title;
  String? desc;
  String? image;
  String? date_time;
  String? location;
  String? start_point;
  String? amount;

  Hike({
    this.id,
    this.difficulty,
    this.title,
    this.desc,
    this.image,
    this.date_time,
    this.location,
    this.start_point,
    this.amount,
  });

  factory Hike.fromJson(Map<String, dynamic> json) {
    return Hike(
      id: json['id'],
      difficulty: json['difficulty'],
      title: json['title'],
      desc: json['desc'],
      image: json['image'],
      date_time: json['date_time'],
      location: json['location'],
      start_point: json['start_point'],
      amount: json['amount'],
    );
  }
}
