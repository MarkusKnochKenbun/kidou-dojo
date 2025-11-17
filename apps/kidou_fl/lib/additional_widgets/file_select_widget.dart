import 'package:flutter/material.dart';

class FileSelectWidget extends StatefulWidget {

  final Future<String> Function() selectFile;
  final String selectText;

  const FileSelectWidget({
    super.key,
    required this.selectFile,
    required this.selectText,
  });

  @override
  State<FileSelectWidget> createState() => _FileSelectWidgetState();
}

class _FileSelectWidgetState extends State<FileSelectWidget> {
  late TextEditingController _textController;
  late FocusNode _fileFocusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");
    _fileFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _fileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      focusNode: _fileFocusNode,
      readOnly: true,
      onTap: () async {
        _textController.text = await widget.selectFile();
        _fileFocusNode.unfocus();
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: widget.selectText,
      ),
    );
  }
}
