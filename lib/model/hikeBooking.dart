// hike.dart
class HikeBook {
  int? id;
  String? status;
  String? car_pooling;
  String? date_time;
  String? image;
  String? nationality;
  String? no_adults;
  String? no_kids;
  String? add_info;

  HikeBook({
    this.id,
    this.status,
    this.car_pooling,
    this.image,
    this.nationality,
    this.date_time,
    this.no_kids,
    this.no_adults,
    this.add_info,
  });

  factory HikeBook.fromJson(Map<String, dynamic> json) {
    return HikeBook(
      id: json['id'],
      status: json['status'],
      car_pooling: json['car_pooling'],
      image: json['image'],
      nationality: json['nationality'],
      date_time: json['date_time'],
      no_kids: json['no_kids'],
      no_adults: json['no_adults'],
      add_info: json['add_info'],
    );
  }
}
