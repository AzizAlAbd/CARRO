import 'package:cars_app/UI/helpers/constants.dart';

import 'package:cars_app/UI/views/result_screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  final String? searchText;
  const SearchScreen({super.key, this.searchText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    if (widget.searchText != null) {
      searchController.text = widget.searchText!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 10.w,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: grayColor.withOpacity(0.3)),
          padding: EdgeInsets.only(left: 2.w),
          child: TextField(
            controller: searchController,
            onEditingComplete: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  ResultScreen.routeName, (route) => route.isFirst,
                  arguments: searchController.text);
            },
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
                hintText: 'Search for a car', border: InputBorder.none),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [buildTile(), buildTile(), buildTile()],
        ),
      ),
    ));
  }

  buildTile() {
    return ListTile(
      onTap: () {},
      leading: Icon(
        Icons.history,
        size: 28.Q,
      ),
      title: Text('BMW X400', style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
