import 'dart:async';
import 'package:flutter/material.dart';

class LocationSearchBar extends StatelessWidget {
  final SearchController controller;
  final Icon leadingIcon;
  final List<Widget>? trailingIcon;
  final String hintText;
  final void Function(String)? viewOnChanged;
  final FutureOr<Iterable<Widget>> Function(BuildContext, SearchController) suggestionsBuilder;

  const LocationSearchBar({
    Key? key,
    required this.controller,
    required this.leadingIcon,
    this.trailingIcon,
    required this.hintText,
    required this.viewOnChanged,
    required this.suggestionsBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return TextField(
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (value) {
            controller.openView();
          },
          decoration: InputDecoration(
            prefixIcon: leadingIcon,
            suffixIcon: trailingIcon != null ? Row(
              mainAxisSize: MainAxisSize.min,
              children: trailingIcon!,
            ) : SizedBox(),
            hintText: hintText,
          ),
        );
      },
      viewOnChanged: viewOnChanged,
      suggestionsBuilder: suggestionsBuilder,
    );
  }
}