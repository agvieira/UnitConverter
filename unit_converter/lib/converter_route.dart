import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';
import 'input_field.dart';
import 'output_field.dart';

class ConverterRoute extends StatefulWidget {
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    @required this.color,
    @required this.units
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}


class _ConverterRouteState extends State<ConverterRoute> {

  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  void _updateInputValue(String input) {
    // print(input);
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(input);
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
        }
      }
    });
  }

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  void _updateConversion() {
    setState(() {
      _convertedValue = _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }

  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
          (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  @override
  Widget build(BuildContext context) {
    final input = InputField(
        units: widget.units,
        onChanged: _updateFromConversion,
        unitSelected: _fromValue,
        onChangedInput: _updateInputValue
    );


    final arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );


    final output = OutputField(
        units: widget.units,
        onChanged: _updateToConversion,
        unitSelected: _toValue,
        convertedValue: _convertedValue
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        input,
        arrows,
        output,
      ],
    );

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: converter,
    );
  }

}