import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatefulWidget {
  final String? initialValue;
  final Function(String) onValidChanged;
  const TextInputWidget({super.key, required this.onValidChanged, this.initialValue});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    final initValue = widget.initialValue;

    if (initValue != null) {
      _controller.text = initValue;
      _validateText(initValue); // Initial validation
    }
  }

  void _validateText(String? value) {
    final stringValue = value;
    if (stringValue == null || stringValue.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a valid endpoint';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });
    widget.onValidChanged(stringValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      decoration: InputDecoration(
        labelText: 'endpoint',
        errorText: _errorMessage, // Display error message
        border: const OutlineInputBorder(),
      ),
      onChanged: _validateText,
      onSubmitted: _validateText,
      textAlign: TextAlign.start,
    );
  }
}
