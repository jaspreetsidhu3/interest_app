//Developed by Jaspreet Singh

import 'package:flutter/material.dart';

// Main function
void main() {
  // inflate the widgets into views
  runApp(MainActivity());
}
// Stateless Widgets
class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.amberAccent,
          brightness: Brightness.dark),
      title: "Interest App",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Interest App"),
        ),
        body: MyWidgets(),
      ),
    ));
  }
}
//Stateful widgets
class MyWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyWidgetsState();
  }
}
// States of stateful widgets
class MyWidgetsState extends State<MyWidgets> {
  //Global key for form
  var _keyform = GlobalKey<FormState>();
  // Text Controller to fetch the data in textfields
  TextEditingController principleController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  //Dropdown items
  var amount_type = ["Ruppees", "Dollar", "Pounds", "Other"];
  String amount = "Ruppees";
  //Net value / sum
  String value = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return (Form(
      key: _keyform,
      child: ListView(
        padding:
            EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0, bottom: 0.0),
        children: [
          Container(
              child: Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Text(
              "Welcome to Interest calculating app",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          )),
          TextFormField(
            controller: principleController,
            style: textStyle,
            validator: (String data) {
              if (data.isEmpty) {
                return 'Please enter principal amount';
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelStyle: textStyle,
                hintText: "Enter the Amount eg 2000",
                labelText: "Principal"),
          ),
          TextFormField(
            controller: interestController,
            style: textStyle,
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter the rate';
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelStyle: textStyle,
                hintText: "Example eg 200",

                labelText: "Rate of interest"),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: periodController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter period';
                    }
                  },
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      hintText: "example 2 years",
                      labelText: "Time"),
                ),
              ),
              Expanded(
                child: DropdownButton(
                  items: amount_type.map((String index) {
                    return DropdownMenuItem<String>(
                      value: index,
                      child: Text(index),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      this.amount = value;
                    });
                  },
                  value: amount,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    child: Text("Calculate"),
                    color: Colors.amberAccent,
                    elevation: 10,
                    onPressed: () {
                      setState(() {
                        if(_keyform.currentState.validate()){
                          getData();
                        }

                      });
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text("Reset"),
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        resetData();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ));
  }

// Get Data for computing interest
  void getData() {
    double principle = double.parse(principleController.text);
    double interest = double.parse(interestController.text);
    double period = double.parse(periodController.text);
    double sum = principle + (principle * interest * period) / 100;
    this.value =
        "Total interest you got is ${sum} ${amount} after ${period} years";
  }

// Reset data called when pressing reset data in app
  void resetData() {
    principleController.text = '';
    interestController.text = '';
    periodController.text = '';
    this.value = '';
  }
}
