import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CommonText(text: 'Search Screen')],
      ),
    );
  }
}
