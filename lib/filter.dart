import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoiceChipDisplay extends StatefulWidget {
  @override
  _ChoiceChipDisplayState createState() => _ChoiceChipDisplayState();
}

class _ChoiceChipDisplayState extends State<ChoiceChipDisplay> {
  List<String> chipList = [
    "Recyclezd",
    "Vegetarian",
    "Skilled",
    "Energetic",
    "Friendly",
    "Luxurious",
    "Recycled 0",
    "Vegetarian 1",
    "Skilled 2",
    "Energetic 3",
    "Friendly 4",
    "Luxurious 4"
  ];
  List<String> chipList2 = [
    "Chemise",
    "Habit",
    "Pantalon",
    "modele",
    "Fash",
    "Veste",
    "Booba",
  ];
  bool isNext = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFF200087),
        title: new Text('Fash Modes'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: Center(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Container(
            width: 380,
            height: 400,
            child: Column(
              children: <Widget>[
                !isNext
                    ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        //color: new Color(0xffffc107),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xffffc107),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Filter le produit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        //color: new Color(0xffffc107),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xffffc107),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                !isNext
                    ? Container(
                        child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          choiceChipWidget(chipList),
                        ],
                      ))
                    : Container(
                        child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          choiceChipWidget(chipList2),
                        ],
                      )),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    child: RaisedButton(
                        color: Color(0xffffbf00),
                        child: new Text(
                          'Suivant',
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            isNext = true;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            // je te salut dans mon code BLUA Chère gentille maman
            setState(() {
              selectedChoice = item;
            });
            print(item);
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
