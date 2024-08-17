class Dish {
  int ?id;
  int cookID;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  double price;
  String picture_Path;

  Dish({
    this.id,
    required this.cookID,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.picture_Path,
  });
}


