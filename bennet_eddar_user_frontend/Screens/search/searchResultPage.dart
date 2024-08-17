import 'package:bennet_eddar_app/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import 'search_card.dart';
import '../../commons/images.dart';
import '../../commons/colors.dart';

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrgAppTopBar(
        title: 'RÉSULTATS DE RECHERCHE',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Nous avons trouvé 80 résultats pour "Couscous"',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Yaldevi',
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Pop the context when Nouvelle recherche is pressed
                            },
                            child: Text(
                              'Nouvelle recherche',
                              style: TextStyle(
                                color: AppColors.accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Yaldevi',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            SearchCard(
                              title: 'Menu #1',
                              subtitle: 'Algérien',
                              imagePath: couscous_image,
                              cookName: 'John Doe',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 2 heures',
                            ),
                            SearchCard(
                              title: 'Menu #2',
                              subtitle: 'Algérien',
                              imagePath: bourak_image,
                              cookName: 'Alice Smith',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 1 jour',
                            ),
                            SearchCard(
                              title: 'Menu #3',
                              subtitle: 'Algérien',
                              imagePath: kesra_image,
                              cookName: 'Bob Johnson',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 3 jours',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 35),
                            SearchCard(
                              title: 'Menu #4',
                              subtitle: 'Algérien',
                              imagePath: tlitli_image,
                              cookName: 'Eva Williams',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 5 jours',
                            ),
                            SearchCard(
                              title: 'Menu #5',
                              subtitle: 'Algérien',
                              imagePath: tlitli_image,
                              cookName: 'Michael Davis',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 1 jour',
                            ),
                            SearchCard(
                              title: 'Menu #6',
                              subtitle: 'Algérien',
                              imagePath: tlitli_image,
                              cookName: 'Sophia Brown',
                              cookProfileImage: cook_image,
                              postTime: '- Il y a 2 semaines',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
