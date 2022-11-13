import 'package:flutter/material.dart';

final bool value = false;
List<DropdownMenuItem> items = [
  DropdownMenuItem(
      child: CheckboxListTile(
    title: Text("Africa"),
    value: value,
    onChanged: (value) {
      print("object");
    },
  ))
];

class contains extends StatelessWidget {
  const contains({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter",
                  style: TextStyle(
                      fontFamily: "Axiforma", fontWeight: FontWeight.w900),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel))
              ],
            ),
            // DropdownButton(items: items, onChanged: (){})
          ],
        ),
      ),
    );
  }
}
