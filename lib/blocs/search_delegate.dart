import 'package:flutter/material.dart';
import 'package:flutter_app/constants/UIConstants/text_styles.dart';

import 'app_localizations.dart';

class MySearchDelegate extends SearchDelegate {
  String selectedResult;
  final Function callback;

  MySearchDelegate(this.callback);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  void showResults(BuildContext context) {
    selectedResult = query;
    callback(query);
    close(context, query);
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = [AppLocalizations.of(context).translate("Kharkiv"), AppLocalizations.of(context).translate("Kyiv"), query].where((element) => element.contains(query)).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index],
            style: TextStyles.search),
          onTap: () {
            selectedResult = searchResults[index];
            callback(selectedResult);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}