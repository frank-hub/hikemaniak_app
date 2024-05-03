class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        placeId = json['place_id'];
}