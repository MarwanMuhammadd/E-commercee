class LocationModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl = "";

  LocationModel({required this.id, required this.city, required this.country});
}

List<LocationModel> dummyLocations = [
  LocationModel(id: "1", city: "New York", country: "USA"),
  LocationModel(id: "2", city: "Los Angeles", country: "USA"),
  LocationModel(id: "3", city: "Chicago", country: "USA"),
  LocationModel(id: "4", city: "Houston", country: "USA"),
  LocationModel(id: "5", city: "Phoenix", country: "USA"),
];
