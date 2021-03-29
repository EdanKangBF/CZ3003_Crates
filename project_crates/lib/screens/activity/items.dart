import 'package:flutter/material.dart';

abstract class NotifItem {
  //The title line to show in the list
  Widget buildTitle(BuildContext context);

  // to build the subtitle if there is any
  Widget buildSubtitle(BuildContext context);
}

class MessageItem implements NotifItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) {
    return Text(sender);
  }

  Widget buildSubtitle(BuildContext context) {
    return Text(body, overflow: TextOverflow.ellipsis);
  }
}

// do we need heading? probabl not
class HeadingItem implements NotifItem {
  final String heading;
  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

// TODO this is the function to show all the details of the report for listing
Widget reportFormat(BuildContext context) {
  String listingname, listedby, reporttitle, reportby, reporton;
  return SingleChildScrollView(
    child: Container(
        child: Column(
      children: [
        Container(
          alignment: Alignment(-1, -1),
          child: TextButton.icon(
              icon: Icon(Icons.keyboard_backspace),
              label: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ), //backbutton
        Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              margin: const EdgeInsets.all(15.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Image.asset('assets/images/Thisonedoesntshowanything.jpg')
              // Icon(Icons.favorite,
              // color: Colors.pink,
              // size: 24.0,
              // semanticLabel: 'HERE COMES THE PARTY!')
              ,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200.0,
                  height: 30.0,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(TextSpan(
                      text: 'Listing ID:',
                      children: <TextSpan>[
                        TextSpan(
                            text: listingname,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ])),
                ),
                Container(
                  width: 200.0,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(TextSpan(
                      text: 'Listed by: ',
                      children: <TextSpan>[
                        TextSpan(
                            text: listedby,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ])),
                )
              ],
            ),
          ],
        ), //picture + listing id:listing name + listed by
        Container(
            margin: const EdgeInsets.only(left: 23.0, top: 15.0),
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Title of report: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                children: <TextSpan>[
                  TextSpan(
                      text: reporttitle,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]))), // title of report + TODO replace gg in textspan with variable
        Container(
            margin: const EdgeInsets.only(left: 23.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Reported by: ',
                children: <TextSpan>[
                  TextSpan(
                      text: reportby,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]))), //reported by + TODO text: gg replacement
        Container(
            margin: const EdgeInsets.only(left: 23.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Reported on: ',
                children: <TextSpan>[
                  TextSpan(
                      text: reporton,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]))), //date of report +TODO text replacement for gg
        Container(
            margin: const EdgeInsets.only(left: 23.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(
                'Report Description: ')), // text of just report description
        Container(
            margin: const EdgeInsets.only(left: 23.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text('Descriptions')),
        Row(
          children: [
            Container(
              child: chooseActions(context),
              alignment: Alignment.bottomCenter,
            ),
            Container(
                child: dismissReport(context),
                alignment: Alignment.bottomCenter),
          ],
        ),
      ],
    )),
  );
}

//TODO This is the button to choose actions, so we will need to return certain values to database
Widget chooseActions(BuildContext context) {
  return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text('Actions',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 24)),
                        MyCheckboxTesting(),
                        SecondCheckbox(),
                        Text('Penalties',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 24)),
                        RadioButton(),
                        MyTextField(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32.0, top: 32.0),
                              child: submit(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32.0, top: 32.0),
                              child: cancel(context),
                            )
                          ],
                        )
                      ],
                    )));
          },
        );
      }, //show popup dialog
      child: Text('Choose Actions'));
}

//TODO This is the button to classify the report as no count, need to return some value as well.
Widget dismissReport(BuildContext context) {
  return TextButton(
      style: TextButton.styleFrom(
          primary: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      onPressed: () {
        ; //TODO Dismiss report
      }, //show popup dialog
      child: Text('Dismiss Report'));
}

// TODO this mychecboxtesting is the first check box, which is to delete listing. need to know what value to return to delete listing
class MyCheckboxTesting extends StatefulWidget {
  @override
  _MyCheckboxTestingState createState() => _MyCheckboxTestingState();
}

class _MyCheckboxTestingState extends State<MyCheckboxTesting> {
  bool _isSelected = false;
  bool deleted;
  _MyCheckboxTestingState({this.deleted});
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Deleted Listing'),
      value: _isSelected,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
          deleted = true;
          return deleted;
        });
      },
    );
  }
}

// TODO secondcheckbox is to give warning to the user, need to automate?
class SecondCheckbox extends StatefulWidget {
  @override
  _SecondCheckboxState createState() => _SecondCheckboxState();
}

class _SecondCheckboxState extends State<SecondCheckbox> {
  bool _isSelected = false;
  bool givewarning;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.only(left: 16.0),
      title: const Text('Give warning to the user'),
      value: _isSelected,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
          givewarning = true;
        });
      },
    );
  }
}

//Radio button 2 param
enum Penalties { temporary, permanent }

/// Radio Button widget
class RadioButton extends StatefulWidget {
  const RadioButton({Key key}) : super(key: key);

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

/// This is the private State class that goes with RadioButton.
// TODO this radio button give out penalities to the user, need to know give what penalty, either this or this
class _RadioButtonState extends State<RadioButton> {
  Penalties _penalty = Penalties.temporary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Ban Account for 1 month'),
          leading: Radio<Penalties>(
            value: Penalties.temporary,
            groupValue: _penalty,
            toggleable: true,
            onChanged: (Penalties value) {
              setState(() {
                _penalty = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Ban Account permanently'),
          leading: Radio<Penalties>(
            value: Penalties.permanent,
            groupValue: _penalty,
            toggleable: true,
            onChanged: (Penalties value) {
              setState(() {
                _penalty = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

// For text field
class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
//TODO this returns the reasons for the banning
class _MyTextFieldState extends State<MyTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.all(12),
      child: TextField(
          controller: myController,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Reason for list of actions',
            fillColor: Colors.grey[300],
            filled: true,
          )),
    );
  }
}

// Cancel button
Widget cancel(BuildContext context) {
  return TextButton(
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        Navigator.pop(context);
      }, //show popup dialog
      child: Text('Cancel'));
}

// submit button
//TODO need to submit all the form values
Widget submit(BuildContext context) {
  return TextButton(
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        ; //TODO Dismiss report
      }, //show popup dialog
      child: Text('Submit'));
}

// drop down menu
class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key key}) : super(key: key);

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

/// This is the private State class that goes with DropDownMenu.
class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// This widget is for the all listing tab, but where to put it???
Widget reportbuttonforlisting(BuildContext context) {
  return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text('Actions',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 24)),
                        MyCheckboxTesting(),
                        SecondCheckbox(),
                        Text('Penalties',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 24)),
                        RadioButton(),
                        MyTextField(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32.0, top: 32.0),
                              child: submit(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32.0, top: 32.0),
                              child: cancel(context),
                            )
                          ],
                        )
                      ],
                    )));
          },
        );
      }); //show popup dialog
}
