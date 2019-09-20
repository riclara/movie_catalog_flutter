import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  final movies = [
    'Spiderman',
    'Aquiaman',
    'Batman',
    'Shazam',
    'Iroman',
    'Capitan America'
  ];

  final moviesRecently = [
    'Spiderman',
    'Capitan America'
  ];

  

  @override
  List<Widget> buildActions(BuildContext context) {
    // Field actions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // left icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // build results to show
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestions on type
    final listSuggested = (query.isEmpty) ? movies : movies.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: listSuggested.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text( listSuggested[i]),
        );
      },
    );
  }

}