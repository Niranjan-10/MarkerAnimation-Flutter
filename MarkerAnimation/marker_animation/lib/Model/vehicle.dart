class Vehicle {
  var vehicleNumber;
  var lat;
  var lng;

  Vehicle({this.vehicleNumber, this.lat, this.lng});

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
        vehicleNumber: json["vehicleNumber"],
        lat: json["lat"],
        lng: json["lng"]
    );
  }

  factory Vehicle.updateObject(Vehicle vehicle,Map<String,dynamic> json){
    vehicle.vehicleNumber =json['vehicleNumber'];
    vehicle.lat = json["lat"];
    vehicle.lng = json["lng"];
    return vehicle;
  }
}