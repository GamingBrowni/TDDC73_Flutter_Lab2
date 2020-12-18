import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(

    home: Home(),


  ));
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // -- DROPDOWN BUTTON LISTS ------------------------------------------------
  String yearChoice;
  List yearList = [
    "2020","2021","2022","2023","2024","2025","2026","2027"
  ];

  String monthChoice;
  List monthList = [
    "01","02","03","04","05","06","07","08","09","10","11","12"
  ];
  // -------------------------------------------------------------------------

  // -- VARIABLES, BOOLS, STRINGS  -------------------------------------------
  String year = 'YY';
  String month = 'MM';
  String name = 'FULL NAME';
  String cvv = '';
  String cardInputDefault = '####  ####  ####  ####';
  String cardMaskAMEX = '####  ######  #####';
  String cardMaskDC = '####  ######  ####';
  String theCard = 'visa';

  var cardMask = new MaskTextInputFormatter(mask: '####  ####  ####  ####', filter: {'#': RegExp(r'[0-9]')});

  int cvvLength = 3;
  bool cardFront = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Specifies how the AppBar will look at the top
      /*appBar: AppBar(
        title: Text(
          "Flutter Lab 2",
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.lightBlue[300],
      ),*/

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),

          // -- CARD FRONT ----------------------------------------------------
          Visibility(
            visible: cardFront == true,
            //maintainState: true,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage('assets/cardMotive.jpeg'),
                    height: 240.0,
                  ),
                ),

                // CHIP
                Positioned(
                  left: 20,
                  top: 20,
                  child: Image.asset(
                      'assets/chip.png',
                      scale: 1.6,
                  ),
                ),

                // CARD NETWORK
                // Default: VISA
                // Other: AMEX, DINERSCLUB, DISCOVER, JCB, MASTERCARD, TROY, UNIONPAY
                Positioned(
                  right: 20,
                  top: 20,
                  child: Image(
                      image: AssetImage('assets/$theCard.png'),
                      height: 40.0,
                    ),
                ),

                Positioned(
                  top: 100.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('$cardInputDefault',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // CARD HOLDER
                Positioned(
                  bottom: 35,
                  left: 15,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Card Holder',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // SHOW CARD HOLDER INPUT
                Positioned(
                  left: 25,
                  bottom: 25,
                  child: Container(
                    child: Text('$name',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                ),

                // EXPIRES
                Positioned(
                  right: 40,
                  bottom: 45,
                  child: Container(
                    child: Text('Expires',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // SHOW EXPIRED INPUT
                Positioned(
                  right: 40,
                  bottom: 25,
                  child: Container(
                    child: Text('$month/$year',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ------------------------------------------------------------------


          // -- CARD BACK ----------------------------------------------------
          Visibility(
            visible: cardFront == false,
            //maintainState: true,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget> [

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage('assets/cardMotive_back.jpeg'),
                    height: 240.0,
                  ),
                ),

                // MAGNET STRIP
                Positioned(
                  left: 0,
                  top: 22,
                  child: Container(
                    height: 40.0,
                    width: 380.0,
                    color: Colors.black,
                  ),
                ),

                // CVV TEXT
                Positioned(
                  top: 90,
                  right: 15,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('CVV',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // CVV INPUT TEXT
                Positioned(
                  top: 120.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 35.0,
                      width: 350.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(310, 8, 0, 0),
                        child: Text('$cvv',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // CARD NETWORK
                // Default: VISA
                // Other: AMEX, DINERSCLUB, DISCOVER, JCB, MASTERCARD, TROY, UNIONPAY
                Positioned(
                  right: 12,
                  bottom: 35,
                  child: Image(
                    image: AssetImage('assets/$theCard.png'),
                    height: 35.0,
                  ),
                ),
              ],
            ),
          ),
          // ------------------------------------------------------------------


          SizedBox(
            height: 20.0,
          ),


          // -- INPUT STUFF ---------------------------------------------------

          // CARD NUMBER TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
            Text('Card Number',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),

            // CARD NUMBER INPUT
              // ---- ADD WHICH CARD DEPENDING ON INPUT NUMBER ----
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 330.0,
                maxWidth: 330.0,
                minHeight: 40.0,
                maxHeight: 40.0,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                inputFormatters: [cardMask],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (numberInput) {
                    setState(() {
                      cardFront = true;
                      cardInputDefault = numberInput;
                      cvvLength = 3;
                      cardMask.updateMask(mask: '####  ####  ####  ####', filter: {'#': RegExp(r'[0-9]')});

                      // VISA: 1st digit = 4
                      RegExp regEx = RegExp('^4');
                      if(regEx.stringMatch(numberInput) != null || numberInput.isEmpty) {
                        theCard = 'visa';
                      }
                      // MASTERCARD: 1st digit = 5, 2nd digit = [1-5]
                      regEx = RegExp('^5[1-5]');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'mastercard';
                      }
                      // DISCOVER: First 4 digits = 6011
                      regEx = RegExp('^6011');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'discover';
                      }
                      // TROY: First 4 digits = 9792
                      regEx = RegExp('^9792');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'troy';
                      }
                      // DINERSCLUB: Starts with 36|38, 14 digits
                      regEx = RegExp('^36|38');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'dinersclub';
                        cardMask.updateMask(mask: cardMaskDC, filter: {'#': RegExp(r'[0-9]')});
                      }
                      // JCB: Starts with 35
                      regEx = RegExp('^35');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'jcb';
                      }
                      // UNIONPAY: Starts with 62
                      regEx = RegExp('^62');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'unionpay';
                      }
                      // AMERICAN EXPRESS:
                      // First 2 digits either 34|37 + 4 CVV + change mask
                      regEx = RegExp('^34|37');
                      if(regEx.stringMatch(numberInput) != null) {
                        theCard = 'amex';
                        cvvLength = 4;
                        cardMask.updateMask(mask: cardMaskAMEX, filter: {'#': RegExp(r'[0-9]')});
                      }
                    });
                },
              ),
            ),
            ],
          ),

          SizedBox(
            height: 10.0,
          ),

          // CARD NAME TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text('Card Name',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),

              // CARD NAME INPUT
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 330.0,
                  maxWidth: 330.0,
                  minHeight: 40.0,
                  maxHeight: 40.0,
                ),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (nameInput) {
                    setState(() {
                      cardFront = true;
                      name = nameInput;
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10.0,
          ),

          // EXPIRATION DATE + CVV
          Row(
              children: <Widget> [

                SizedBox(
                  width: 30.0,
                ),

                // EXPIRATION DATE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // Expiration Date
                    Text('Expiration Date',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //MONTH
                    Row(
                      children: <Widget>[
                        Container(
                          width: 95.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton(
                              hint: Text('Month'),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              value: monthChoice,
                              onChanged: (monthInput) {
                                setState(() {
                                  cardFront = true;
                                  monthChoice = monthInput;
                                  month = monthInput;
                                });
                              },
                              items: monthList.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 10.0,
                        ),

                        // YEAR
                        Container(
                          width: 95.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton(
                              hint: Text('Year'),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              value: yearChoice,
                              onChanged: (yearInput) {
                                setState(() {
                                  cardFront = true;
                                  yearChoice = yearInput;
                                  year = yearInput.substring(2);
                                });
                              },
                              items: yearList.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  width: 36.0,
                ),

                // CVV
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CVV',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 95.0,
                        maxWidth: 95.0,
                        minHeight: 40.0,
                        maxHeight: 40.0,
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(cvvLength)],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (cvvInput) {
                            setState(() {
                              cardFront = false;
                              cvv = cvvInput;
                            });
                        },
                      ),
                    ),
                  ],
                ),
              ],
          ),
        ],
      ),
    );
  }
}
