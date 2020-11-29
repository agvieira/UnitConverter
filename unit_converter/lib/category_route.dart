import 'package:flutter/material.dart';
import 'package:unit_converter/unit.dart';
import 'category.dart';

class CategoryItem {
  final String name;
  final ColorSwatch color;
  const CategoryItem(this.name, this.color);
}

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {

  static const _categoriesItem = <CategoryItem>[
    CategoryItem('Length', Colors.tealAccent),
    CategoryItem('Area', Colors.orangeAccent),
    CategoryItem('Volume', Colors.pinkAccent),
    CategoryItem('Mass', Colors.blueAccent),
    CategoryItem('Time', Colors.yellowAccent),
    CategoryItem('Digital Storage', Colors.greenAccent),
    CategoryItem('Energy', Colors.purpleAccent),
    CategoryItem('Currency', Colors.redAccent),
  ];

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(name: '$categoryName $i', conversion: i.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {

    final categories = _categoriesItem.map( (e) => Category(name: e.name, color: e.color, iconLocation: Icons.cake, units: _retrieveUnitList(e.name))).toList();
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(categories),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Unit Converter',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}