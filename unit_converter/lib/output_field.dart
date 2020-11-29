import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

class OutputField extends StatefulWidget {
  final List<Unit> units;
  final ValueChanged<dynamic> onChanged;
  final Unit unitSelected;
  final String convertedValue;

  const OutputField({
    @required this.units,
    @required this.onChanged,
    @required this.unitSelected,
    this.convertedValue
  }) : assert(units != null),
        assert(onChanged != null),
        assert(unitSelected != null);

  @override
  State<StatefulWidget> createState() => _OutputFieldState();
}

class _OutputFieldState extends State<OutputField> {

  List<DropdownMenuItem> _unitMenuItems;

  @override
  void initState() {
    super.initState();
    _buildDropdowmMenuItems();
  }

  void _buildDropdowmMenuItems() {
    setState(() {
      _unitMenuItems = widget.units.map((Unit unit) {
        return DropdownMenuItem(
          value: unit.name,
          child: Container(
            child: Text(
              unit.name,
              softWrap: true,
            ),
          ),
        );
      }).toList();
    });
  }

  Widget _createDropdown(BuildContext context, String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(
            color: Colors.grey[400],
            width: 1.0,
          )
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              widget.convertedValue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(context, widget.unitSelected.name, widget.onChanged),
        ],
      ),
    );
  }
}