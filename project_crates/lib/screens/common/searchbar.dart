

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
    // return StreamBuilder<UnmodifiableListView<Whateverlistcalled>>(
    //     stream: whatweneed,
    //     builder: (context,
    //         AsyncSnapshot<UnmodifiableListView<Whateverlistcalled>> snapshot) {
    //       if (!snapshot.hasData) {
    //         return Center(
    //           child: Text('NO data!'),
    //         );
    //       }
    //       return ListView(children:snapshot.data.map<Widget>((a)=?Text(a.title),)
    // );});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text(query);
  }
}
