final  Map<String, dynamic>cookData = {
  '1': {
    'CookFullName': 'Cook Full Name',
    'rates': "4.3",
    'Location': 'Alger, Algérie',
    'cookProfilePicture': 'assets/image/TestImage.png',
    'Galerie': 'assets/image/menu/Menu1.png',
    'bio': " Description Description  "
  }
};

String cookFullName = cookData['1']?['CookFullName'] ?? '';
  String rates = cookData['1']?['rates'] ?? '';
  String location = cookData['1']?['Location'] ?? '';
  String cookProfilePicture = cookData['1']?['cookProfilePicture'] ?? 'assets/image/Logo.png';
  String bio = cookData['1']?['bio'] ?? '';
  String galerie = cookData['1']?['Galerie'] ?? 'assets/image/menu/Menu1.png';
