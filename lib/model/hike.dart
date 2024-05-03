// hike.dart
class Hike {
  int? id;
  String? category;
  String? title;
  String? desc;
  String? image;
  String? date_time;
  String? location;
  String? start_point;
  String? end_point;
  String? start_lat;
  String? start_lng;
  String? end_lat;
  String? end_lng;
  String? ctnAmount;
  String? resAmount;
  String? trstAmount;
  String? whatCarry;
  String? addActivities;
  String? difficulty;
  String? maxSize;
  String? minAge;

  Hike({
    this.id,
    this.category,
    this.title,
    this.desc,
    this.image,
    this.date_time,
    this.location,
    this.start_point,
    this.end_point,
    this.start_lat,
    this.start_lng,
    this.end_lat,
    this.end_lng,
    this.ctnAmount,
    this.resAmount,
    this.trstAmount,
    this.whatCarry,
    this.addActivities,
    this.difficulty,
    this.maxSize,
    this.minAge,
  });

  factory Hike.fromJson(Map<String, dynamic> json) {
    return Hike(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      desc: json['desc'],
      image: json['image'],
      date_time: json['date_time'],
      location: json['location'],
      start_point: json['start_point'],
      end_point: json['end_point'],
      start_lat: json['start_lat'],
      start_lng: json['start_lng'],
      end_lat: json['end_lat'],
      end_lng: json['end_lng'],
      ctnAmount: json['ctnAmount'],
      resAmount: json['resAmount'],
      trstAmount: json['trstAmount'],
      whatCarry: json['whatCarry'],
      addActivities: json['addActivities'],
      difficulty: json['difficulty'],
      maxSize: json['maxSize'],
      minAge : json['minAge'],
    );
  }
}
