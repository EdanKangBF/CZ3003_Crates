import 'package:flutter/material.dart';
import '../moderator/reportlisting.dart';
import '../activity/activity.dart';
import '../moderator/reportpage.dart';

//TODO pass in parameters respectively, etc details
Widget reportChatFormat(BuildContext context) {
  //pass in respective parameters?
  String listingname, listedby, user1, user2, reporttitle, reportby, reporton;
  return SingleChildScrollView(
    child: Container(
        height: MediaQuery.of(context).size.height,
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Icon(Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                      semanticLabel: 'HERE COMES THE PARTY!'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200.0,
                      height: 30.0,
                      alignment: Alignment.centerLeft,
                      child: Text.rich(TextSpan(
                          text: 'Listing Name:',
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
                    ),
                    Container(
                      width: 200.0,
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                          TextSpan(text: 'Chat between: ', children: <TextSpan>[
                        TextSpan(
                            text: user1,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' & ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: user2,
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
                    ]))), //date of report + TODO text replacement for gg
            Container(
                margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Report Description: ')), // text of just report description
            Container(
                margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                alignment: Alignment.centerLeft,
                child: Text('Descriptions')),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: chooseChatActions(context),
                      decoration: myBoxDecoration(),
                    ),
                    Container(
                      child: dismissReport(context),
                      decoration: myBoxDecoration(),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}

//TODO pass in parameters respectively, etc details
Widget chooseChatActions(BuildContext context) {
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
                        ChatRestrictedCheckBox(),
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

class ChatRestrictedCheckBox extends StatefulWidget {
  @override
  _ChatRestrictedCheckBoxState createState() => _ChatRestrictedCheckBoxState();
}

class _ChatRestrictedCheckBoxState extends State<ChatRestrictedCheckBox> {
  bool _isSelected = false;
  bool deleted;
  _ChatRestrictedCheckBoxState({this.deleted});
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Restrict chat for 1 month'),
      value: _isSelected,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
          deleted = true;
          return deleted; //TODO this one return what vlaue to database
        });
      },
    );
  }
}

Widget listofreportedchats() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: hello.length,
    itemBuilder: (context, index) {
      final item = hello[index];
      return Card(
          child: ListTile(
        leading: FlutterLogo(), //  TODO to be removed later
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReportChat()));
        },
        title: item.buildTitle(context),
        subtitle: item.buildSubtitle(context),
        trailing: Icon(Icons.keyboard_arrow_right),
        isThreeLine: true,
      ));
    },
  );
}
