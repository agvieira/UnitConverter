import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:math';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

class InputField extends StatefulWidget {
  final List<Unit> units;
  final ValueChanged<dynamic> onChanged;
  final ValueChanged<String> onChangedInput;
  final Unit unitSelected;

  const InputField({
    @required this.units,
    @required this.onChanged,
    @required this.unitSelected,
    this.onChangedInput
  }) : assert(units != null),
        assert(onChanged != null),
        assert(unitSelected != null);

  @override
  State<StatefulWidget> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidateError = false;

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

  TextField _createTextField(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.display1,
      decoration: InputDecoration(
        labelStyle: Theme.of(context).textTheme.display1,
        errorText: _showValidateError ? 'Invalid number entered' : null,
        labelText: 'Input',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: widget.onChangedInput,
    );
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _createTextField(context),
          _createDropdown(context, widget.unitSelected.name, widget.onChanged)
        ],
      ),
    );
  }
}