import 'package:bennet_eddar_cook/utils/Posts.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/button_widget.dart';
import '../../utils/user_info.dart';

class PromoCodeAddPage extends StatefulWidget {
  const PromoCodeAddPage({Key? key}) : super(key: key);

  @override
  _PromoCodeAddPageState createState() => _PromoCodeAddPageState();
}

class _PromoCodeAddPageState extends State<PromoCodeAddPage> {
  late List<Map<String, dynamic>> promoCodes = [];

  late TextEditingController _name;
  late TextEditingController _pourcentage;
  late TextEditingController _utilisation;
  late TextEditingController _availability;

  bool isLoading = true;
  late int cookID;

  void initState() {
    super.initState();
    _name = TextEditingController();
    _pourcentage = TextEditingController();
    _utilisation = TextEditingController();
    _availability = TextEditingController();
    getPromoCodes();
  }

  Future<void> getPromoCodes() async {
    await CookID();
    List<dynamic> promocodes = await Posts.getPromoCodesForCook(cookID);

    List<Map<String, dynamic>> transformedPromocodes = promocodes.map((dynamic promo) {
      Map<String, dynamic> promoMap = {
        'name': promo['Name'],
        'pourcentage': promo['Pourcentage'],
        'utilisation': promo['Utilisation'],
        'availability': promo['Availability'],
      };

      return promoMap;
    }).toList();

    promoCodes = transformedPromocodes;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const OrgAppTopBar(
        title: 'AJOUTER UN CODE PROMO',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.07),
          child:isLoading
          ?Center(
            child: CircularProgressIndicator(color: Color(0xFFFFB261)),
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextFormField('NOM DU CODE PROMO', _name),
              buildTextFormField('POURCENTAGE(%)', _pourcentage, keyboardType: TextInputType.number),
              buildTextFormField('UTILISATION (PAR UTILISATEUR)', _utilisation, keyboardType: TextInputType.number),
              buildTextFormField('VALABLE POUR (HEURES)', _availability, keyboardType: TextInputType.number),
              SizedBox(height: screenHeight * 0.02),
              AppElevatedButton(
                onPressed: () async {
                  if(_name.text.isNotEmpty&& _availability.text.isNotEmpty&& _utilisation.text.isNotEmpty && _pourcentage.text.isNotEmpty){
                    setState(() {
                    isLoading = true;
                    });
                    bool added = await _addPromoCode();
                    if(added){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Code Promo Ajouté'),
                        ),
                      );
                      await getPromoCodes();
                      setState(() {
                        isLoading = false;
                      });
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erreur lors de l\'ajout du code promo.Veuillez réessayer plus tard.'),
                        ),
                      );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Certains champs ne sont pas remplis.'),
                        ),
                      );
                  }
                },
                label: 'AJOUTER',
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                'CODES PROMO PRECEDENTS',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: promoCodes.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return buildPromoCodeTile(promoCodes[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(String labelText, TextEditingController controller, {TextInputType? keyboardType}) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
          keyboardType: keyboardType,
        ),
        SizedBox(height: screenHeight * 0.016),
      ],
    );
  }

  Widget buildPromoCodeTile(Map<String, dynamic> promoCode) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      title: Text('${promoCode['name']}'),
      subtitle: Text(
        'Pourcentage: ${promoCode['pourcentage']}%\n'
        'Utilisation: ${promoCode['utilisation']} fois\n'
        'Période de validité: ${promoCode['availability']} heures',
      ),
      trailing: Text(
        'VALIDE',
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Future<bool> _addPromoCode() async {
    Map<String, dynamic> PromoCodeDetails = {
      'cookID': cookID,
      'name': _name.text,
      'pourcentage': _pourcentage.text,
      'utilisation': _utilisation.text,
      'availability': _availability.text
    };

    try {
      await Posts.addPromoCode(PromoCodeDetails);
      print('Success: PC added successfully');
      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<void> CookID() async {
    String? userID = await getUserId();
    if (userID != null) {
      cookID = int.parse(userID);
    } else {
      print('error getting user id');
    }
  }
}
