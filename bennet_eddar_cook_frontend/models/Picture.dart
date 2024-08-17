import 'dart:typed_data';

class Picture{
  String name;
  int cookID;
  Uint8List picture;
  
  Picture({
    required this.name,
    required this.cookID,
    required this.picture
  });
}