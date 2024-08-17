import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:flutter/material.dart';

class SpecialInstructionsWidget extends StatefulWidget {
  final Function(String instructions) onSpecialInstructionsChanged;

  SpecialInstructionsWidget({
    required this.onSpecialInstructionsChanged,
  });

  @override
  _SpecialInstructionsWidgetState createState() =>
      _SpecialInstructionsWidgetState();
}

class _SpecialInstructionsWidgetState
    extends State<SpecialInstructionsWidget> {
  bool isPanelExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          this.isPanelExpanded = !this.isPanelExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Ajouter des inscruction spéciales',
                  style: AppFonts.dishDescTextstyle,
                ),
              ),
            );

          },
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Entrer des instructions spéciales...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  style: AppFonts.bodyTextStyle,
                  onChanged: (instructions) {
                    widget.onSpecialInstructionsChanged(instructions);
                  },
                ),
              ],
            ),
          ),
          isExpanded: isPanelExpanded,
        ),
      ],
    );
  }
}
