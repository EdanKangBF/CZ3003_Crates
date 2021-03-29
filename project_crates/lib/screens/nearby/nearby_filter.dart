import 'package:flutter/material.dart';
import '../common/widgets.dart';
import '../common/theme.dart';

class NearbyFilter extends StatefulWidget {
  @override
  _NearbyFilterState createState() => _NearbyFilterState();
}

class _NearbyFilterState extends State<NearbyFilter> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  // distance slider
  double _currentSliderValue = 2;

  // category dropdown
  String _currentCat;
  final List<String> _categories = <String>["All", "Vegetables", "Canned Foods", "Dairy Products"];

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _currentCat = _categories[0];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        drawer: MenuDrawer(),
        backgroundColor: offWhite,
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topCard(_globalKey),
                SizedBox(height:50),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,0,0,0),
                  child: Text('location',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                      decoration: InputDecoration(
                          focusedBorder :OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          ),
                          prefixIcon: Icon(Icons.search),
                          prefixStyle: TextStyle(
                            decorationColor: Colors.red,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'search')),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,0,0,10),
                  child: Text('distance',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 50,
                    divisions: 100,
                    label: _currentSliderValue.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,10,0,10),
                  child: Text('category',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,15,25,0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusColor: Colors.red,
                        value: _currentCat,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _currentCat = newValue;
                          });
                        },
                        items: _categories.map((_categories) {
                          return DropdownMenuItem(
                            value: _categories,
                            child: Text(_categories),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120,50,120,0),
                  child: CustomButton(
                    btnText: 'Filter',
                    btnPressed: (){}
                  ),
                )

              ]
            )
        )

    );
  }
}

Widget topCard(_globalKey){
  return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
              margin: EdgeInsets.zero,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:42),
                  Center(
                    child: Text(
                      "Filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 2,
                        color: offWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(10, 35, 0,0),
          child: IconButton(
            iconSize: 30,
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: (){
              _globalKey.currentState.openDrawer();
            },
          ),
        ),

      ]
  );

}