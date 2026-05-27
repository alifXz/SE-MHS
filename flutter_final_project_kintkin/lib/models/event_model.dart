class EventModel {
  final String id;
  final String title;
  final String organizer;
  final String location;
  final String locationLink;
  final String description;
  final String imageUrl;
  final String time;
  final String eventDate;
  final String venuePartner;
  final int price;

  EventModel({
    required this.id,
    required this.title,
    required this.organizer,
    required this.location,
    required this.locationLink,
    required this.description,
    required this.imageUrl,
    required this.time,
    required this.eventDate,
    required this.venuePartner,
    required this.price,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      organizer: json['organizer'],
      location: json['location'],
      locationLink: json['location_link'],
      description: json['description'],
      imageUrl: json['image_url'],
      time: json['time'],
      eventDate: json ['event_date'],
      venuePartner: json['venue_partner'],
      price: json['price'] is int? json['price']: int.parse(json['price'].toString()),
    );
  }
}